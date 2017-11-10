--Copyright (C) 2017 Siavoosh Payandeh Azad
------------------------------------------------------
-- This router uses Routing Table for each input LBDR!
-- In order to Reduce the Crtitical Path Latency, Input-to-Output bypass
-- has been implemented.
-- The bypass can be done for 90 degree turns or strait directions (both
-- horizontal and vertical paths for example N2S and E2W).
-- The bypass has been implemented between all router ports except for
-- Local port! (for example you can not bypass L2N).
-- detailed information is documented inside the Router PORT description.
---------------------------------------------
-- Here is a sample how the TX and Valid_out signals are generated:
-- please note that the port numbers are arbitrary!
--
--               +----------------------------------------
--               |                      ________
--               |   router TX_4-----> |        \
--               | router valid out4-> |         \
--  --RX_1-----> |-------------------> |          \
--  -Valid_in1-> |-------------------> |   MUX    |
--               |-------------------> |          |--TX_4----->
--  --RX_2-----> |-------------------> |          |-Valid_out4->
--  -Valid_in2-> |-------------------> |          |
--               |-------------------> |         /
--  --RX_3-----> |-------------------> |        /
--  -Valid_in3-> |-------------------> |			 /
--               |-------------------> |______/
--               |												^
--               |												|
--   --sel_4---> |------------------------'
--               |
--               +----------------------------------------
-- similarly the credit_in sigal is bypassed from the output to input!

library ieee;
use ieee.std_logic_1164.all;
--use IEEE.STD_LOGIC_ARITH.ALL;
--use IEEE.STD_LOGIC_UNSIGNED.ALL;

library work;
use work.type_def_pack.all;

entity router_credit_based is
	generic (
        DATA_WIDTH: integer := 32;
        current_address : integer := 0;
        NoC_size: integer := 4;

        routing_table_bits_local: t_tata := (
            0 =>    "0000", 1 =>    "0000", 2 =>    "0000", 3 =>    "0000",
						4 =>    "0000", 5 =>    "0000", 6 =>    "0000", 7 =>    "0000",
						8 =>    "0000", 9 =>    "0000", 10 =>   "0000", 11 =>   "0000",
						12 =>   "0000", 13 =>   "0000", 14 =>   "0000", 15 =>   "0100"
        );

        routing_table_bits_north: t_tata := (
            0 =>    "0000", 1 =>    "0000", 2 =>    "0000", 3 =>    "0000",
						4 =>    "0000", 5 =>    "0000", 6 =>    "0000", 7 =>    "0000",
						8 =>    "0000", 9 =>    "0000", 10 =>   "0000", 11 =>   "0000",
						12 =>   "0000", 13 =>   "0000", 14 =>   "0000", 15 =>   "0100"
        );

        routing_table_bits_east: t_tata := (
            0 =>    "0000", 1 =>    "0000", 2 =>    "0000", 3 =>    "0000",
						4 =>    "0000", 5 =>    "0000", 6 =>    "0000", 7 =>    "0000",
						8 =>    "0000", 9 =>    "0000", 10 =>   "0000", 11 =>   "0000",
						12 =>   "0000", 13 =>   "0000", 14 =>   "0000", 15 =>   "0100"
        );

        routing_table_bits_west: t_tata := (
            0 =>    "0000", 1 =>    "0000", 2 =>    "0000", 3 =>    "0000",
						4 =>    "0000", 5 =>    "0000", 6 =>    "0000", 7 =>    "0000",
						8 =>    "0000", 9 =>    "0000", 10 =>   "0000", 11 =>   "0000",
						12 =>   "0000", 13 =>   "0000", 14 =>   "0000", 15 =>   "0100"
        );

        routing_table_bits_south: t_tata := (
            0 =>    "0000", 1 =>    "0000", 2 =>    "0000", 3 =>    "0000",
						4 =>    "0000", 5 =>    "0000", 6 =>    "0000", 7 =>    "0000",
						8 =>    "0000", 9 =>    "0000", 10 =>   "0000", 11 =>   "0000",
						12 =>   "0000", 13 =>   "0000", 14 =>   "0000", 15 =>   "0100"
        )
    );
    port (
    reset, clk: in std_logic;

    RX_N, RX_E, RX_W, RX_S, RX_L : in std_logic_vector (DATA_WIDTH-1 downto 0);

    credit_in_N, credit_in_E, credit_in_W, credit_in_S, credit_in_L: in std_logic;
    valid_in_N, valid_in_E, valid_in_W, valid_in_S, valid_in_L : in std_logic;

    valid_out_N, valid_out_E, valid_out_W, valid_out_S, valid_out_L : out std_logic;
    credit_out_N, credit_out_E, credit_out_W, credit_out_S, credit_out_L: out std_logic;

    TX_N, TX_E, TX_W, TX_S, TX_L: out std_logic_vector (DATA_WIDTH-1 downto 0);

		-- Bypass Signals Documentation
		-- If you set these values to "00" the router would operate normally
		-- To bypass turns and paths use the following:
		--	to bypass E2N set sel_N to "01"
		--	to bypass W2N set sel_N to "10"
		--	to bypass S2N set sel_N to "11"
		----------------
		--	to bypass W2E set sel_E to "01"
		--	to bypass S2E set sel_E to "10"
		--	to bypass N2E set sel_E to "11"
		----------------
		--	to bypass S2W set sel_W to "01"
		--	to bypass N2W set sel_W to "10"
		--	to bypass E2W set sel_W to "11"
		----------------
		--	to bypass N2S set sel_S to "01"
		--	to bypass E2S set sel_S to "10"
		--	to bypass W2S set sel_S to "11"

		sel_N, sel_E, sel_W, sel_S: in std_logic_vector(1 downto 0)
    );
end router_credit_based;

architecture behavior of router_credit_based is

  COMPONENT FIFO_credit_based
 	generic (
        DATA_WIDTH: integer := 32
    );
    port (  reset: in  std_logic;
            clk: in  std_logic;
            RX: in std_logic_vector(DATA_WIDTH-1 downto 0);
            valid_in: in std_logic;
            read_en_N : in std_logic;
            read_en_E : in std_logic;
            read_en_W : in std_logic;
            read_en_S : in std_logic;
            read_en_L : in std_logic;
            credit_out: out std_logic;
            empty_out: out std_logic;
            Data_out: out std_logic_vector(DATA_WIDTH-1 downto 0)
    );
	end COMPONENT;

  COMPONENT allocator is

    port (  reset: in  std_logic;
            clk: in  std_logic;
            -- flow control
            credit_in_N, credit_in_E, credit_in_W, credit_in_S, credit_in_L: in std_logic;

            req_N_N, req_N_E, req_N_W, req_N_S, req_N_L: in std_logic;
            req_E_N, req_E_E, req_E_W, req_E_S, req_E_L: in std_logic;
            req_W_N, req_W_E, req_W_W, req_W_S, req_W_L: in std_logic;
            req_S_N, req_S_E, req_S_W, req_S_S, req_S_L: in std_logic;
            req_L_N, req_L_E, req_L_W, req_L_S, req_L_L: in std_logic;
            empty_N, empty_E, empty_W, empty_S, empty_L: in std_logic;
            -- grant_X_Y means the grant for X output port towards Y input port
            -- this means for any X in [N, E, W, S, L] then set grant_X_Y is one hot!
            valid_N, valid_E, valid_W, valid_S, valid_L : out std_logic;

            grant_N_N, grant_N_E, grant_N_W, grant_N_S, grant_N_L: out std_logic;
            grant_E_N, grant_E_E, grant_E_W, grant_E_S, grant_E_L: out std_logic;
            grant_W_N, grant_W_E, grant_W_W, grant_W_S, grant_W_L: out std_logic;
            grant_S_N, grant_S_E, grant_S_W, grant_S_S, grant_S_L: out std_logic;
            grant_L_N, grant_L_E, grant_L_W, grant_L_S, grant_L_L: out std_logic
            );
end COMPONENT;

COMPONENT RoutingTable is
    generic (
        cur_addr_rst: integer := 8;
        NoC_size: integer := 4;
        routing_table_rst: t_tata := (
            0 =>    "0000", 1 =>    "0000", 2 =>    "0000", 3 =>    "0000",
						4 =>    "0000", 5 =>    "0000", 6 =>    "0000", 7 =>    "0000",
						8 =>    "0000", 9 =>    "0000", 10 =>   "0000", 11 =>   "0000",
						12 =>   "0000", 13 =>   "0000", 14 =>   "0000", 15 =>   "0100"
        )
    );
    port (  reset: in  std_logic;
            clk: in  std_logic;

            empty: in  std_logic;
            flit_type: in std_logic_vector(2 downto 0);
            dst_addr: in std_logic_vector(NoC_size-1 downto 0);
            grant_N, grant_E, grant_W, grant_S, grant_L: in std_logic;
            Req_N, Req_E, Req_W, Req_S, Req_L:out std_logic
            );
end COMPONENT;


 	COMPONENT XBAR is
    generic (
        DATA_WIDTH: integer := 32
    );
    port (
        North_in: in std_logic_vector(DATA_WIDTH-1 downto 0);
        East_in: in std_logic_vector(DATA_WIDTH-1 downto 0);
        West_in: in std_logic_vector(DATA_WIDTH-1 downto 0);
        South_in: in std_logic_vector(DATA_WIDTH-1 downto 0);
        Local_in: in std_logic_vector(DATA_WIDTH-1 downto 0);
        sel: in std_logic_vector (4 downto 0);
        Data_out: out std_logic_vector(DATA_WIDTH-1 downto 0)
    );
	end COMPONENT;

  signal FIFO_D_out_N, FIFO_D_out_E, FIFO_D_out_W, FIFO_D_out_S, FIFO_D_out_L: std_logic_vector(DATA_WIDTH-1 downto 0);

 	signal Grant_NN, Grant_NE, Grant_NW, Grant_NS, Grant_NL: std_logic;
 	signal Grant_EN, Grant_EE, Grant_EW, Grant_ES, Grant_EL: std_logic;
 	signal Grant_WN, Grant_WE, Grant_WW, Grant_WS, Grant_WL: std_logic;
 	signal Grant_SN, Grant_SE, Grant_SW, Grant_SS, Grant_SL: std_logic;
 	signal Grant_LN, Grant_LE, Grant_LW, Grant_LS, Grant_LL: std_logic;

 	signal Req_NN, Req_EN, Req_WN, Req_SN, Req_LN: std_logic;
 	signal Req_NE, Req_EE, Req_WE, Req_SE, Req_LE: std_logic;
 	signal Req_NW, Req_EW, Req_WW, Req_SW, Req_LW: std_logic;
 	signal Req_NS, Req_ES, Req_WS, Req_SS, Req_LS: std_logic;
 	signal Req_NL, Req_EL, Req_WL, Req_SL, Req_LL: std_logic;

  signal empty_N, empty_E, empty_W, empty_S, empty_L: std_logic;
 	signal Xbar_sel_N, Xbar_sel_E, Xbar_sel_W, Xbar_sel_S, Xbar_sel_L: std_logic_vector(4 downto 0);

	-- the folloing signals are used for bypassing
	signal valid_out_N_aloc, valid_out_E_aloc, valid_out_W_aloc, valid_out_S_aloc : std_logic;
	signal credit_out_N_FIFO, credit_out_E_FIFO, credit_out_W_FIFO, credit_out_S_FIFO: std_logic;
	signal TX_N_xbar, TX_E_xbar, TX_W_xbar, TX_S_xbar: std_logic_vector(DATA_WIDTH-1 downto 0);


begin

------------------------------------------------------------------------------
-- here is the code for the muxes for Bypassing
-- data and Valid signal bypassing
process(sel_N, TX_N_xbar, RX_E, RX_W, RX_S, valid_out_N_aloc,
				valid_in_E, valid_in_W, valid_in_S)begin
	case(sel_N) is
		when "01" =>
			TX_N        		<= RX_E;
			valid_out_N     <= valid_in_E;
		when "10" =>
			TX_N        		<= RX_W;
			valid_out_N     <= valid_in_W;
		when "11" =>
			TX_N        		<= RX_S;
			valid_out_N     <= valid_in_S;
		when others =>
			TX_N        		<= TX_N_xbar;
			valid_out_N     <= valid_out_N_aloc;
	end case;
end process;


process(sel_E, RX_W, valid_in_W, RX_S, valid_in_S, RX_N, valid_in_N,
				TX_E_xbar, valid_out_E_aloc)begin
	case(sel_E) is
		when "01" =>
			TX_E        		<= RX_W;
			valid_out_E     <= valid_in_W;
		when "10" =>
			TX_E        		<= RX_S;
			valid_out_E     <= valid_in_S;
		when "11" =>
			TX_E        		<= RX_N;
			valid_out_E     <= valid_in_N;
		when others =>
			TX_E        		<= TX_E_xbar;
			valid_out_E     <= valid_out_E_aloc;
	end case;
end process;

process(sel_W, RX_S, valid_in_S, RX_N, valid_in_N, RX_E, valid_in_E,
				TX_W_xbar, valid_out_W_aloc)begin
	case(sel_W) is
		when "01" =>
			TX_W        		<= RX_S;
			valid_out_W     <= valid_in_S;
		when "10" =>
			TX_W        		<= RX_N;
			valid_out_W     <= valid_in_N;
		when "11" =>
			TX_W        		<= RX_E;
			valid_out_W     <= valid_in_E;
		when others =>
			TX_W        		<= TX_W_xbar;
			valid_out_W     <= valid_out_W_aloc;
	end case;
end process;

process(sel_S, RX_N, valid_in_N, RX_E, valid_in_E, RX_W, valid_in_W,
				TX_S_xbar, valid_out_S_aloc)begin
	case(sel_S) is
		when "01" =>
			TX_S        		<= RX_N;
			valid_out_S     <= valid_in_N;
		when "10" =>
			TX_S        		<= RX_E;
			valid_out_S     <= valid_in_E;
		when "11" =>
			TX_S        		<= RX_W;
			valid_out_S     <= valid_in_W;
		when others =>
			TX_S        		<= TX_S_xbar;
			valid_out_S     <= valid_out_S_aloc;
	end case;
end process;

-- CREDIT Bypassing!
process(sel_N, sel_E, sel_S, credit_in_N, credit_in_E, credit_in_S, credit_out_W_FIFO)begin
	credit_out_W <= credit_out_W_FIFO;
	if sel_N = "10" then
		credit_out_W <= credit_in_N;
	elsif sel_E = "01" then
		credit_out_W <= credit_in_E;
	elsif sel_S = "11" then
		credit_out_W <= credit_in_S;
	end if;
end process;

process(sel_N, sel_W, sel_S, credit_in_N, credit_in_W, credit_in_S, credit_out_E_FIFO)begin
	credit_out_E <= credit_out_E_FIFO;
	if sel_N = "01" then
		credit_out_E <= credit_in_N;
	elsif sel_W = "11" then
		credit_out_E <= credit_in_W;
	elsif sel_S = "10" then
		credit_out_E <= credit_in_S;
	end if;
end process;


process(sel_N, sel_E, sel_W, credit_in_N, credit_in_E, credit_in_W, credit_out_S_FIFO)begin
	credit_out_S <= credit_out_S_FIFO;
	if sel_N = "11" then
		credit_out_S <= credit_in_N;
	elsif sel_E = "10" then
		credit_out_S <= credit_in_E;
	elsif sel_W = "01" then
		credit_out_S <= credit_in_W;
	end if;
end process;

process(sel_E, sel_W, sel_S, credit_in_E, credit_in_W, credit_in_S, credit_out_N_FIFO)begin
	credit_out_N <= credit_out_N_FIFO;
	if sel_E = "11" then
		credit_out_N <= credit_in_E;
	elsif sel_W = "10" then
		credit_out_N <= credit_in_W;
	elsif sel_S = "01" then
		credit_out_N <= credit_in_S;
	end if;
end process;
-- End of Bypassing of Routers
------------------------------------------------------------------------------

-- all the FIFOs
FIFO_N: FIFO_credit_based
    generic map ( DATA_WIDTH => DATA_WIDTH)
    port map ( reset => reset, clk => clk, RX => RX_N, valid_in => valid_in_N,
            read_en_N => '0', read_en_E =>Grant_EN, read_en_W =>Grant_WN, read_en_S =>Grant_SN, read_en_L =>Grant_LN,
            credit_out => credit_out_N_FIFO, empty_out => empty_N, Data_out => FIFO_D_out_N);

FIFO_E: FIFO_credit_based
    generic map ( DATA_WIDTH => DATA_WIDTH)
    port map ( reset => reset, clk => clk, RX => RX_E, valid_in => valid_in_E,
            read_en_N => Grant_NE, read_en_E =>'0', read_en_W =>Grant_WE, read_en_S =>Grant_SE, read_en_L =>Grant_LE,
            credit_out => credit_out_E_FIFO, empty_out => empty_E, Data_out => FIFO_D_out_E);

FIFO_W: FIFO_credit_based
    generic map ( DATA_WIDTH => DATA_WIDTH)
    port map ( reset => reset, clk => clk, RX => RX_W, valid_in => valid_in_W,
            read_en_N => Grant_NW, read_en_E =>Grant_EW, read_en_W =>'0', read_en_S =>Grant_SW, read_en_L =>Grant_LW,
            credit_out => credit_out_W_FIFO, empty_out => empty_W, Data_out => FIFO_D_out_W);

FIFO_S: FIFO_credit_based
    generic map ( DATA_WIDTH => DATA_WIDTH)
    port map ( reset => reset, clk => clk, RX => RX_S, valid_in => valid_in_S,
            read_en_N => Grant_NS, read_en_E =>Grant_ES, read_en_W =>Grant_WS, read_en_S =>'0', read_en_L =>Grant_LS,
            credit_out => credit_out_S_FIFO, empty_out => empty_S, Data_out => FIFO_D_out_S);

FIFO_L: FIFO_credit_based
    generic map ( DATA_WIDTH => DATA_WIDTH)
    port map ( reset => reset, clk => clk, RX => RX_L, valid_in => valid_in_L,
            read_en_N => Grant_NL, read_en_E =>Grant_EL, read_en_W =>Grant_WL, read_en_S => Grant_SL, read_en_L =>'0',
            credit_out => credit_out_L, empty_out => empty_L, Data_out => FIFO_D_out_L);

------------------------------------------------------------------------------------------------------------------------------

-- All the routing tables
ROUTING_TABLE_N: RoutingTable generic map (cur_addr_rst => current_address, NoC_size => NoC_size, routing_table_rst => routing_table_bits_north)
       PORT MAP (reset => reset, clk => clk, empty => empty_N,
                 flit_type => FIFO_D_out_N(DATA_WIDTH-1 downto DATA_WIDTH-3), dst_addr=> FIFO_D_out_N(NoC_size  downto 1) ,
                 grant_N => '0', grant_E =>Grant_EN, grant_W => Grant_WN, grant_S=>Grant_SN, grant_L =>Grant_LN,
                 Req_N=> Req_NN, Req_E=>Req_NE, Req_W=>Req_NW, Req_S=>Req_NS, Req_L=>Req_NL);

ROUTING_TABLE_E: RoutingTable generic map (cur_addr_rst => current_address, NoC_size => NoC_size, routing_table_rst => routing_table_bits_east)
       PORT MAP (reset =>  reset, clk => clk, empty => empty_E,
                 flit_type => FIFO_D_out_E(DATA_WIDTH-1 downto DATA_WIDTH-3), dst_addr=> FIFO_D_out_E(NoC_size downto 1) ,
                 grant_N => Grant_NE, grant_E =>'0', grant_W => Grant_WE, grant_S=>Grant_SE, grant_L =>Grant_LE,
                 Req_N=> Req_EN, Req_E=>Req_EE, Req_W=>Req_EW, Req_S=>Req_ES, Req_L=>Req_EL);

ROUTING_TABLE_W: RoutingTable generic map (cur_addr_rst => current_address, NoC_size => NoC_size, routing_table_rst => routing_table_bits_west)
       PORT MAP (reset =>  reset, clk => clk, empty => empty_W,
                 flit_type => FIFO_D_out_W(DATA_WIDTH-1 downto DATA_WIDTH-3), dst_addr=> FIFO_D_out_W(NoC_size downto 1) ,
                 grant_N => Grant_NW, grant_E =>Grant_EW, grant_W =>'0' ,grant_S=>Grant_SW, grant_L =>Grant_LW,
                 Req_N=> Req_WN, Req_E=>Req_WE, Req_W=>Req_WW, Req_S=>Req_WS, Req_L=>Req_WL);

ROUTING_TABLE_S: RoutingTable generic map (cur_addr_rst => current_address, NoC_size => NoC_size, routing_table_rst => routing_table_bits_south)
       PORT MAP (reset =>  reset, clk => clk, empty => empty_S,
                 flit_type => FIFO_D_out_S(DATA_WIDTH-1 downto DATA_WIDTH-3), dst_addr=> FIFO_D_out_S(NoC_size downto 1) ,
                 grant_N => Grant_NS, grant_E =>Grant_ES, grant_W =>Grant_WS ,grant_S=>'0', grant_L =>Grant_LS,
                 Req_N=> Req_SN, Req_E=>Req_SE, Req_W=>Req_SW, Req_S=>Req_SS, Req_L=>Req_SL);

ROUTING_TABLE_L: RoutingTable generic map (cur_addr_rst => current_address, NoC_size => NoC_size, routing_table_rst => routing_table_bits_local)
       PORT MAP (reset =>  reset, clk => clk, empty => empty_L,
                 flit_type => FIFO_D_out_L(DATA_WIDTH-1 downto DATA_WIDTH-3), dst_addr=> FIFO_D_out_L(NoC_size downto 1) ,
                 grant_N => Grant_NL, grant_E =>Grant_EL, grant_W => Grant_WL,grant_S=>Grant_SL, grant_L =>'0',
                 Req_N=> Req_LN, Req_E=>Req_LE, Req_W=>Req_LW, Req_S=>Req_LS, Req_L=>Req_LL);

------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------

-- switch allocator

allocator_unit: allocator port map ( reset => reset, clk => clk,
            -- flow control
            credit_in_N => credit_in_N, credit_in_E => credit_in_E, credit_in_W => credit_in_W, credit_in_S => credit_in_S, credit_in_L => credit_in_L,

            -- requests from the LBDRS
            req_N_N => '0', req_N_E => Req_NE, req_N_W => Req_NW, req_N_S => Req_NS, req_N_L => Req_NL,
            req_E_N => Req_EN, req_E_E => '0', req_E_W => Req_EW, req_E_S => Req_ES, req_E_L => Req_EL,
            req_W_N => Req_WN, req_W_E => Req_WE, req_W_W => '0', req_W_S => Req_WS, req_W_L => Req_WL,
            req_S_N => Req_SN, req_S_E => Req_SE, req_S_W => Req_SW, req_S_S => '0', req_S_L => Req_SL,
            req_L_N => Req_LN, req_L_E => Req_LE, req_L_W => Req_LW, req_L_S => Req_LS, req_L_L => '0',
            empty_N => empty_N, empty_E => empty_E, empty_w => empty_W, empty_S => empty_S, empty_L => empty_L,
            valid_N => valid_out_N_aloc, valid_E => valid_out_E_aloc, valid_W => valid_out_W_aloc, valid_S => valid_out_S_aloc, valid_L => valid_out_L,
            -- grant_X_Y means the grant for X output port towards Y input port
            -- this means for any X in [N, E, W, S, L] then set grant_X_Y is one hot!
            grant_N_N => Grant_NN, grant_N_E => Grant_NE, grant_N_W => Grant_NW, grant_N_S => Grant_NS, grant_N_L => Grant_NL,
            grant_E_N => Grant_EN, grant_E_E => Grant_EE, grant_E_W => Grant_EW, grant_E_S => Grant_ES, grant_E_L => Grant_EL,
            grant_W_N => Grant_WN, grant_W_E => Grant_WE, grant_W_W => Grant_WW, grant_W_S => Grant_WS, grant_W_L => Grant_WL,
            grant_S_N => Grant_SN, grant_S_E => Grant_SE, grant_S_W => Grant_SW, grant_S_S => Grant_SS, grant_S_L => Grant_SL,
            grant_L_N => Grant_LN, grant_L_E => Grant_LE, grant_L_W => Grant_LW, grant_L_S => Grant_LS, grant_L_L => Grant_LL
            );

------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------
-- all the Xbar select_signals

Xbar_sel_N <= '0' & Grant_NE & Grant_NW & Grant_NS & Grant_NL;
Xbar_sel_E <= Grant_EN & '0' & Grant_EW & Grant_ES & Grant_EL;
Xbar_sel_W <= Grant_WN & Grant_WE & '0' & Grant_WS & Grant_WL;
Xbar_sel_S <= Grant_SN & Grant_SE & Grant_SW & '0' & Grant_SL;
Xbar_sel_L <= Grant_LN & Grant_LE & Grant_LW & Grant_LS & '0';


------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------
 -- all the Xbars
XBAR_N: XBAR generic map (DATA_WIDTH  => DATA_WIDTH)
   PORT MAP (North_in => FIFO_D_out_N, East_in => FIFO_D_out_E, West_in => FIFO_D_out_W, South_in => FIFO_D_out_S, Local_in => FIFO_D_out_L,
        sel => Xbar_sel_N,  Data_out=> TX_N_xbar);
XBAR_E: XBAR generic map (DATA_WIDTH  => DATA_WIDTH)
   PORT MAP (North_in => FIFO_D_out_N, East_in => FIFO_D_out_E, West_in => FIFO_D_out_W, South_in => FIFO_D_out_S, Local_in => FIFO_D_out_L,
        sel => Xbar_sel_E,  Data_out=> TX_E_xbar);
XBAR_W: XBAR generic map (DATA_WIDTH  => DATA_WIDTH)
   PORT MAP (North_in => FIFO_D_out_N, East_in => FIFO_D_out_E, West_in => FIFO_D_out_W, South_in => FIFO_D_out_S, Local_in => FIFO_D_out_L,
        sel => Xbar_sel_W,  Data_out=> TX_W_xbar);
XBAR_S: XBAR generic map (DATA_WIDTH  => DATA_WIDTH)
   PORT MAP (North_in => FIFO_D_out_N, East_in => FIFO_D_out_E, West_in => FIFO_D_out_W, South_in => FIFO_D_out_S, Local_in => FIFO_D_out_L,
        sel => Xbar_sel_S,  Data_out=> TX_S_xbar);
XBAR_L: XBAR generic map (DATA_WIDTH  => DATA_WIDTH)
   PORT MAP (North_in => FIFO_D_out_N, East_in => FIFO_D_out_E, West_in => FIFO_D_out_W, South_in => FIFO_D_out_S, Local_in => FIFO_D_out_L,
        sel => Xbar_sel_L,  Data_out=> TX_L);

end;

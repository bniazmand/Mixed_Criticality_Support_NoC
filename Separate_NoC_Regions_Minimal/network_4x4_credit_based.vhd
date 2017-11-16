--Copyright (C) 2016 Siavoosh Payandeh Azad
------------------------------------------------------------
-- This file is automatically generated!
-- Here are the parameters:
-- 	 network size x: 4
-- 	 network size y: 4
-- 	 Data width: 32
-- 	 Parity: False
------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
USE ieee.numeric_std.ALL; 

entity network_4x4 is
 generic (DATA_WIDTH: integer := 32; DATA_WIDTH_LV: integer := 11);
port (reset: in  std_logic; 
	clk: in  std_logic; 
	--------------
	RX_L_0: in std_logic_vector (DATA_WIDTH-1 downto 0);
	credit_out_L_0, valid_out_L_0: out std_logic;
	credit_in_L_0, valid_in_L_0: in std_logic;
	TX_L_0: out std_logic_vector (DATA_WIDTH-1 downto 0);
	--------------
	RX_L_1: in std_logic_vector (DATA_WIDTH-1 downto 0);
	credit_out_L_1, valid_out_L_1: out std_logic;
	credit_in_L_1, valid_in_L_1: in std_logic;
	TX_L_1: out std_logic_vector (DATA_WIDTH-1 downto 0);
	--------------
	RX_L_2: in std_logic_vector (DATA_WIDTH-1 downto 0);
	credit_out_L_2, valid_out_L_2: out std_logic;
	credit_in_L_2, valid_in_L_2: in std_logic;
	TX_L_2: out std_logic_vector (DATA_WIDTH-1 downto 0);
	--------------
	RX_L_3: in std_logic_vector (DATA_WIDTH-1 downto 0);
	credit_out_L_3, valid_out_L_3: out std_logic;
	credit_in_L_3, valid_in_L_3: in std_logic;
	TX_L_3: out std_logic_vector (DATA_WIDTH-1 downto 0);
	--------------
	RX_L_4: in std_logic_vector (DATA_WIDTH-1 downto 0);
	credit_out_L_4, valid_out_L_4: out std_logic;
	credit_in_L_4, valid_in_L_4: in std_logic;
	TX_L_4: out std_logic_vector (DATA_WIDTH-1 downto 0);
	--------------
	RX_L_5: in std_logic_vector (DATA_WIDTH-1 downto 0);
	credit_out_L_5, valid_out_L_5: out std_logic;
	credit_in_L_5, valid_in_L_5: in std_logic;
	TX_L_5: out std_logic_vector (DATA_WIDTH-1 downto 0);
	--------------
	RX_L_6: in std_logic_vector (DATA_WIDTH-1 downto 0);
	credit_out_L_6, valid_out_L_6: out std_logic;
	credit_in_L_6, valid_in_L_6: in std_logic;
	TX_L_6: out std_logic_vector (DATA_WIDTH-1 downto 0);
	--------------
	RX_L_7: in std_logic_vector (DATA_WIDTH-1 downto 0);
	credit_out_L_7, valid_out_L_7: out std_logic;
	credit_in_L_7, valid_in_L_7: in std_logic;
	TX_L_7: out std_logic_vector (DATA_WIDTH-1 downto 0);
	--------------
	RX_L_8: in std_logic_vector (DATA_WIDTH-1 downto 0);
	credit_out_L_8, valid_out_L_8: out std_logic;
	credit_in_L_8, valid_in_L_8: in std_logic;
	TX_L_8: out std_logic_vector (DATA_WIDTH-1 downto 0);
	--------------
	RX_L_9: in std_logic_vector (DATA_WIDTH-1 downto 0);
	credit_out_L_9, valid_out_L_9: out std_logic;
	credit_in_L_9, valid_in_L_9: in std_logic;
	TX_L_9: out std_logic_vector (DATA_WIDTH-1 downto 0);
	--------------
	RX_L_10: in std_logic_vector (DATA_WIDTH-1 downto 0);
	credit_out_L_10, valid_out_L_10: out std_logic;
	credit_in_L_10, valid_in_L_10: in std_logic;
	TX_L_10: out std_logic_vector (DATA_WIDTH-1 downto 0);
	--------------
	RX_L_11: in std_logic_vector (DATA_WIDTH-1 downto 0);
	credit_out_L_11, valid_out_L_11: out std_logic;
	credit_in_L_11, valid_in_L_11: in std_logic;
	TX_L_11: out std_logic_vector (DATA_WIDTH-1 downto 0);
	--------------
	RX_L_12: in std_logic_vector (DATA_WIDTH-1 downto 0);
	credit_out_L_12, valid_out_L_12: out std_logic;
	credit_in_L_12, valid_in_L_12: in std_logic;
	TX_L_12: out std_logic_vector (DATA_WIDTH-1 downto 0);
	--------------
	RX_L_13: in std_logic_vector (DATA_WIDTH-1 downto 0);
	credit_out_L_13, valid_out_L_13: out std_logic;
	credit_in_L_13, valid_in_L_13: in std_logic;
	TX_L_13: out std_logic_vector (DATA_WIDTH-1 downto 0);
	--------------
	RX_L_14: in std_logic_vector (DATA_WIDTH-1 downto 0);
	credit_out_L_14, valid_out_L_14: out std_logic;
	credit_in_L_14, valid_in_L_14: in std_logic;
	TX_L_14: out std_logic_vector (DATA_WIDTH-1 downto 0);
	--------------
	RX_L_15: in std_logic_vector (DATA_WIDTH-1 downto 0);
	credit_out_L_15, valid_out_L_15: out std_logic;
	credit_in_L_15, valid_in_L_15: in std_logic;
	TX_L_15: out std_logic_vector (DATA_WIDTH-1 downto 0); 

	Cx_reconf_0: in std_logic_vector(3 downto 0);
	Cx_reconf_1: in std_logic_vector(3 downto 0);
	Cx_reconf_2: in std_logic_vector(3 downto 0);
	Cx_reconf_3: in std_logic_vector(3 downto 0);
	Cx_reconf_4: in std_logic_vector(3 downto 0);
	Cx_reconf_5: in std_logic_vector(3 downto 0);
	Cx_reconf_6: in std_logic_vector(3 downto 0);
	Cx_reconf_7: in std_logic_vector(3 downto 0);
	Cx_reconf_8: in std_logic_vector(3 downto 0);
	Cx_reconf_9: in std_logic_vector(3 downto 0);
	Cx_reconf_10: in std_logic_vector(3 downto 0);
	Cx_reconf_11: in std_logic_vector(3 downto 0);
	Cx_reconf_12: in std_logic_vector(3 downto 0);
	Cx_reconf_13: in std_logic_vector(3 downto 0);
	Cx_reconf_14: in std_logic_vector(3 downto 0);
	Cx_reconf_15: in std_logic_vector(3 downto 0);

	Rxy_reconf_0: in std_logic_vector(7 downto 0);
	Rxy_reconf_1: in std_logic_vector(7 downto 0);
	Rxy_reconf_2: in std_logic_vector(7 downto 0);
	Rxy_reconf_3: in std_logic_vector(7 downto 0);
	Rxy_reconf_4: in std_logic_vector(7 downto 0);
	Rxy_reconf_5: in std_logic_vector(7 downto 0);
	Rxy_reconf_6: in std_logic_vector(7 downto 0);
	Rxy_reconf_7: in std_logic_vector(7 downto 0);
	Rxy_reconf_8: in std_logic_vector(7 downto 0);
	Rxy_reconf_9: in std_logic_vector(7 downto 0);
	Rxy_reconf_10: in std_logic_vector(7 downto 0);
	Rxy_reconf_11: in std_logic_vector(7 downto 0);
	Rxy_reconf_12: in std_logic_vector(7 downto 0);
	Rxy_reconf_13: in std_logic_vector(7 downto 0);
	Rxy_reconf_14: in std_logic_vector(7 downto 0);
	Rxy_reconf_15: in std_logic_vector(7 downto 0); 

	Reconfig : in std_logic
   ); 
end network_4x4; 


architecture behavior of network_4x4 is

component router_credit_based is
  generic (
        DATA_WIDTH: integer := 32; 
        current_address : integer := 0;
        NoC_size: integer := 4
    );
    port (
    reset, clk: in std_logic; 

    Cx_reconf:  in  std_logic_vector(3 downto 0);
    Rxy_reconf: in  std_logic_vector(7 downto 0);
    Reconfig : in std_logic;
    
    RX_N, RX_E, RX_W, RX_S, RX_L : in std_logic_vector (DATA_WIDTH-1 downto 0); 
    credit_in_N, credit_in_E, credit_in_W, credit_in_S, credit_in_L: in std_logic;
    valid_in_N, valid_in_E, valid_in_W, valid_in_S, valid_in_L : in std_logic;

    valid_out_N, valid_out_E, valid_out_W, valid_out_S, valid_out_L : out std_logic;
    credit_out_N, credit_out_E, credit_out_W, credit_out_S, credit_out_L: out std_logic;

    TX_N, TX_E, TX_W, TX_S, TX_L: out std_logic_vector (DATA_WIDTH-1 downto 0)
    ); 
end component; 

-- generating bulk signals. not all of them are used in the design...
	signal credit_out_N_0, credit_out_E_0, credit_out_W_0, credit_out_S_0: std_logic;
	signal credit_out_N_1, credit_out_E_1, credit_out_W_1, credit_out_S_1: std_logic;
	signal credit_out_N_2, credit_out_E_2, credit_out_W_2, credit_out_S_2: std_logic;
	signal credit_out_N_3, credit_out_E_3, credit_out_W_3, credit_out_S_3: std_logic;
	signal credit_out_N_4, credit_out_E_4, credit_out_W_4, credit_out_S_4: std_logic;
	signal credit_out_N_5, credit_out_E_5, credit_out_W_5, credit_out_S_5: std_logic;
	signal credit_out_N_6, credit_out_E_6, credit_out_W_6, credit_out_S_6: std_logic;
	signal credit_out_N_7, credit_out_E_7, credit_out_W_7, credit_out_S_7: std_logic;
	signal credit_out_N_8, credit_out_E_8, credit_out_W_8, credit_out_S_8: std_logic;
	signal credit_out_N_9, credit_out_E_9, credit_out_W_9, credit_out_S_9: std_logic;
	signal credit_out_N_10, credit_out_E_10, credit_out_W_10, credit_out_S_10: std_logic;
	signal credit_out_N_11, credit_out_E_11, credit_out_W_11, credit_out_S_11: std_logic;
	signal credit_out_N_12, credit_out_E_12, credit_out_W_12, credit_out_S_12: std_logic;
	signal credit_out_N_13, credit_out_E_13, credit_out_W_13, credit_out_S_13: std_logic;
	signal credit_out_N_14, credit_out_E_14, credit_out_W_14, credit_out_S_14: std_logic;
	signal credit_out_N_15, credit_out_E_15, credit_out_W_15, credit_out_S_15: std_logic;

	signal credit_in_N_0, credit_in_E_0, credit_in_W_0, credit_in_S_0: std_logic;
	signal credit_in_N_1, credit_in_E_1, credit_in_W_1, credit_in_S_1: std_logic;
	signal credit_in_N_2, credit_in_E_2, credit_in_W_2, credit_in_S_2: std_logic;
	signal credit_in_N_3, credit_in_E_3, credit_in_W_3, credit_in_S_3: std_logic;
	signal credit_in_N_4, credit_in_E_4, credit_in_W_4, credit_in_S_4: std_logic;
	signal credit_in_N_5, credit_in_E_5, credit_in_W_5, credit_in_S_5: std_logic;
	signal credit_in_N_6, credit_in_E_6, credit_in_W_6, credit_in_S_6: std_logic;
	signal credit_in_N_7, credit_in_E_7, credit_in_W_7, credit_in_S_7: std_logic;
	signal credit_in_N_8, credit_in_E_8, credit_in_W_8, credit_in_S_8: std_logic;
	signal credit_in_N_9, credit_in_E_9, credit_in_W_9, credit_in_S_9: std_logic;
	signal credit_in_N_10, credit_in_E_10, credit_in_W_10, credit_in_S_10: std_logic;
	signal credit_in_N_11, credit_in_E_11, credit_in_W_11, credit_in_S_11: std_logic;
	signal credit_in_N_12, credit_in_E_12, credit_in_W_12, credit_in_S_12: std_logic;
	signal credit_in_N_13, credit_in_E_13, credit_in_W_13, credit_in_S_13: std_logic;
	signal credit_in_N_14, credit_in_E_14, credit_in_W_14, credit_in_S_14: std_logic;
	signal credit_in_N_15, credit_in_E_15, credit_in_W_15, credit_in_S_15: std_logic;

	signal RX_N_0, RX_E_0, RX_W_0, RX_S_0 : std_logic_vector (DATA_WIDTH-1 downto 0);
	signal RX_N_1, RX_E_1, RX_W_1, RX_S_1 : std_logic_vector (DATA_WIDTH-1 downto 0);
	signal RX_N_2, RX_E_2, RX_W_2, RX_S_2 : std_logic_vector (DATA_WIDTH-1 downto 0);
	signal RX_N_3, RX_E_3, RX_W_3, RX_S_3 : std_logic_vector (DATA_WIDTH-1 downto 0);
	signal RX_N_4, RX_E_4, RX_W_4, RX_S_4 : std_logic_vector (DATA_WIDTH-1 downto 0);
	signal RX_N_5, RX_E_5, RX_W_5, RX_S_5 : std_logic_vector (DATA_WIDTH-1 downto 0);
	signal RX_N_6, RX_E_6, RX_W_6, RX_S_6 : std_logic_vector (DATA_WIDTH-1 downto 0);
	signal RX_N_7, RX_E_7, RX_W_7, RX_S_7 : std_logic_vector (DATA_WIDTH-1 downto 0);
	signal RX_N_8, RX_E_8, RX_W_8, RX_S_8 : std_logic_vector (DATA_WIDTH-1 downto 0);
	signal RX_N_9, RX_E_9, RX_W_9, RX_S_9 : std_logic_vector (DATA_WIDTH-1 downto 0);
	signal RX_N_10, RX_E_10, RX_W_10, RX_S_10 : std_logic_vector (DATA_WIDTH-1 downto 0);
	signal RX_N_11, RX_E_11, RX_W_11, RX_S_11 : std_logic_vector (DATA_WIDTH-1 downto 0);
	signal RX_N_12, RX_E_12, RX_W_12, RX_S_12 : std_logic_vector (DATA_WIDTH-1 downto 0);
	signal RX_N_13, RX_E_13, RX_W_13, RX_S_13 : std_logic_vector (DATA_WIDTH-1 downto 0);
	signal RX_N_14, RX_E_14, RX_W_14, RX_S_14 : std_logic_vector (DATA_WIDTH-1 downto 0);
	signal RX_N_15, RX_E_15, RX_W_15, RX_S_15 : std_logic_vector (DATA_WIDTH-1 downto 0);

	signal valid_out_N_0, valid_out_E_0, valid_out_W_0, valid_out_S_0: std_logic;
	signal valid_out_N_1, valid_out_E_1, valid_out_W_1, valid_out_S_1: std_logic;
	signal valid_out_N_2, valid_out_E_2, valid_out_W_2, valid_out_S_2: std_logic;
	signal valid_out_N_3, valid_out_E_3, valid_out_W_3, valid_out_S_3: std_logic;
	signal valid_out_N_4, valid_out_E_4, valid_out_W_4, valid_out_S_4: std_logic;
	signal valid_out_N_5, valid_out_E_5, valid_out_W_5, valid_out_S_5: std_logic;
	signal valid_out_N_6, valid_out_E_6, valid_out_W_6, valid_out_S_6: std_logic;
	signal valid_out_N_7, valid_out_E_7, valid_out_W_7, valid_out_S_7: std_logic;
	signal valid_out_N_8, valid_out_E_8, valid_out_W_8, valid_out_S_8: std_logic;
	signal valid_out_N_9, valid_out_E_9, valid_out_W_9, valid_out_S_9: std_logic;
	signal valid_out_N_10, valid_out_E_10, valid_out_W_10, valid_out_S_10: std_logic;
	signal valid_out_N_11, valid_out_E_11, valid_out_W_11, valid_out_S_11: std_logic;
	signal valid_out_N_12, valid_out_E_12, valid_out_W_12, valid_out_S_12: std_logic;
	signal valid_out_N_13, valid_out_E_13, valid_out_W_13, valid_out_S_13: std_logic;
	signal valid_out_N_14, valid_out_E_14, valid_out_W_14, valid_out_S_14: std_logic;
	signal valid_out_N_15, valid_out_E_15, valid_out_W_15, valid_out_S_15: std_logic;

	signal valid_in_N_0, valid_in_E_0, valid_in_W_0, valid_in_S_0: std_logic;
	signal valid_in_N_1, valid_in_E_1, valid_in_W_1, valid_in_S_1: std_logic;
	signal valid_in_N_2, valid_in_E_2, valid_in_W_2, valid_in_S_2: std_logic;
	signal valid_in_N_3, valid_in_E_3, valid_in_W_3, valid_in_S_3: std_logic;
	signal valid_in_N_4, valid_in_E_4, valid_in_W_4, valid_in_S_4: std_logic;
	signal valid_in_N_5, valid_in_E_5, valid_in_W_5, valid_in_S_5: std_logic;
	signal valid_in_N_6, valid_in_E_6, valid_in_W_6, valid_in_S_6: std_logic;
	signal valid_in_N_7, valid_in_E_7, valid_in_W_7, valid_in_S_7: std_logic;
	signal valid_in_N_8, valid_in_E_8, valid_in_W_8, valid_in_S_8: std_logic;
	signal valid_in_N_9, valid_in_E_9, valid_in_W_9, valid_in_S_9: std_logic;
	signal valid_in_N_10, valid_in_E_10, valid_in_W_10, valid_in_S_10: std_logic;
	signal valid_in_N_11, valid_in_E_11, valid_in_W_11, valid_in_S_11: std_logic;
	signal valid_in_N_12, valid_in_E_12, valid_in_W_12, valid_in_S_12: std_logic;
	signal valid_in_N_13, valid_in_E_13, valid_in_W_13, valid_in_S_13: std_logic;
	signal valid_in_N_14, valid_in_E_14, valid_in_W_14, valid_in_S_14: std_logic;
	signal valid_in_N_15, valid_in_E_15, valid_in_W_15, valid_in_S_15: std_logic;

	signal TX_N_0, TX_E_0, TX_W_0, TX_S_0 : std_logic_vector (DATA_WIDTH-1 downto 0);
	signal TX_N_1, TX_E_1, TX_W_1, TX_S_1 : std_logic_vector (DATA_WIDTH-1 downto 0);
	signal TX_N_2, TX_E_2, TX_W_2, TX_S_2 : std_logic_vector (DATA_WIDTH-1 downto 0);
	signal TX_N_3, TX_E_3, TX_W_3, TX_S_3 : std_logic_vector (DATA_WIDTH-1 downto 0);
	signal TX_N_4, TX_E_4, TX_W_4, TX_S_4 : std_logic_vector (DATA_WIDTH-1 downto 0);
	signal TX_N_5, TX_E_5, TX_W_5, TX_S_5 : std_logic_vector (DATA_WIDTH-1 downto 0);
	signal TX_N_6, TX_E_6, TX_W_6, TX_S_6 : std_logic_vector (DATA_WIDTH-1 downto 0);
	signal TX_N_7, TX_E_7, TX_W_7, TX_S_7 : std_logic_vector (DATA_WIDTH-1 downto 0);
	signal TX_N_8, TX_E_8, TX_W_8, TX_S_8 : std_logic_vector (DATA_WIDTH-1 downto 0);
	signal TX_N_9, TX_E_9, TX_W_9, TX_S_9 : std_logic_vector (DATA_WIDTH-1 downto 0);
	signal TX_N_10, TX_E_10, TX_W_10, TX_S_10 : std_logic_vector (DATA_WIDTH-1 downto 0);
	signal TX_N_11, TX_E_11, TX_W_11, TX_S_11 : std_logic_vector (DATA_WIDTH-1 downto 0);
	signal TX_N_12, TX_E_12, TX_W_12, TX_S_12 : std_logic_vector (DATA_WIDTH-1 downto 0);
	signal TX_N_13, TX_E_13, TX_W_13, TX_S_13 : std_logic_vector (DATA_WIDTH-1 downto 0);
	signal TX_N_14, TX_E_14, TX_W_14, TX_S_14 : std_logic_vector (DATA_WIDTH-1 downto 0);
	signal TX_N_15, TX_E_15, TX_W_15, TX_S_15 : std_logic_vector (DATA_WIDTH-1 downto 0);


--        organizaiton of the network:
--     x --------------->
--  y      .-----------------------------------------.
--		   |  ----       ----       ----       ----	 | C
--  |      | | 0  | --- | 1  | --- | 2  | --- | 3  | | R
--  |      |  ----       ----       ----       ----  | I
--  |      .---|-----------|----------|----.    |	 | T
--  |         ----       ----       ----   |   ----	 | I
--  |        | 4  | --- | 5  | --- | 6  | -+- | 7  | | C
--  |         ----       ----       ----   |   ----	 | A
--  |          |          |          |     |    |	 | L
--  |         ----       ----       ----   |   ----  |	
--  |        | 8  | --- | 9  | --- | 10 | -+- | 11 | | R
--  |         ----       ----       ----   |   ----  | E
--  |          |          |          |     |    |	 | G
--  |         ----       ----       ----   |   ----  | I
--  |        | 12 | --- | 13 | --- | 14 | -+- | 15 | | O
--  v         ----       ----       ----   |   ----  | N
--               						   .---------.	
-- 				   NON-CRITICAL REGION

begin

-- instantiating the routers
R_0: router_credit_based generic map (DATA_WIDTH  => DATA_WIDTH, current_address=>0, NoC_size=>4) -- critical region
PORT MAP (reset, clk, 
    Cx_reconf_0, Rxy_reconf_0, Reconfig,
	RX_N_0, RX_E_0, RX_W_0, RX_S_0, RX_L_0,
	credit_in_N_0, credit_in_E_0, credit_in_W_0, credit_in_S_0, credit_in_L_0,
	valid_in_N_0, valid_in_E_0, valid_in_W_0, valid_in_S_0, valid_in_L_0,
	valid_out_N_0, valid_out_E_0, valid_out_W_0, valid_out_S_0, valid_out_L_0,
	credit_out_N_0, credit_out_E_0, credit_out_W_0, credit_out_S_0, credit_out_L_0,
	TX_N_0, TX_E_0, TX_W_0, TX_S_0, TX_L_0); 

R_1: router_credit_based generic map (DATA_WIDTH  => DATA_WIDTH, current_address=>1, NoC_size=>4) -- critical region
PORT MAP (reset, clk, 
    Cx_reconf_1, Rxy_reconf_1, Reconfig,
	RX_N_1, RX_E_1, RX_W_1, RX_S_1, RX_L_1,
	credit_in_N_1, credit_in_E_1, credit_in_W_1, credit_in_S_1, credit_in_L_1,
	valid_in_N_1, valid_in_E_1, valid_in_W_1, valid_in_S_1, valid_in_L_1,
	valid_out_N_1, valid_out_E_1, valid_out_W_1, valid_out_S_1, valid_out_L_1,
	credit_out_N_1, credit_out_E_1, credit_out_W_1, credit_out_S_1, credit_out_L_1,
	TX_N_1, TX_E_1, TX_W_1, TX_S_1, TX_L_1); 

R_2: router_credit_based generic map (DATA_WIDTH  => DATA_WIDTH, current_address=>2, NoC_size=>4) -- critical region
PORT MAP (reset, clk, 
    Cx_reconf_2, Rxy_reconf_2, Reconfig,
	RX_N_2, RX_E_2, RX_W_2, RX_S_2, RX_L_2,
	credit_in_N_2, credit_in_E_2, credit_in_W_2, credit_in_S_2, credit_in_L_2,
	valid_in_N_2, valid_in_E_2, valid_in_W_2, valid_in_S_2, valid_in_L_2,
	valid_out_N_2, valid_out_E_2, valid_out_W_2, valid_out_S_2, valid_out_L_2,
	credit_out_N_2, credit_out_E_2, credit_out_W_2, credit_out_S_2, credit_out_L_2,
	TX_N_2, TX_E_2, TX_W_2, TX_S_2, TX_L_2); 

R_3: router_credit_based generic map (DATA_WIDTH  => DATA_WIDTH, current_address=>3, NoC_size=>4) -- critical region
PORT MAP (reset, clk, 
    Cx_reconf_3, Rxy_reconf_3, Reconfig,
	RX_N_3, RX_E_3, RX_W_3, RX_S_3, RX_L_3,
	credit_in_N_3, credit_in_E_3, credit_in_W_3, credit_in_S_3, credit_in_L_3,
	valid_in_N_3, valid_in_E_3, valid_in_W_3, valid_in_S_3, valid_in_L_3,
	valid_out_N_3, valid_out_E_3, valid_out_W_3, valid_out_S_3, valid_out_L_3,
	credit_out_N_3, credit_out_E_3, credit_out_W_3, credit_out_S_3, credit_out_L_3,
	TX_N_3, TX_E_3, TX_W_3, TX_S_3, TX_L_3); 

R_4: router_credit_based generic map (DATA_WIDTH  => DATA_WIDTH, current_address=>4, NoC_size=>4) 
PORT MAP (reset, clk, 
    Cx_reconf_4, Rxy_reconf_4, Reconfig,
	RX_N_4, RX_E_4, RX_W_4, RX_S_4, RX_L_4,
	credit_in_N_4, credit_in_E_4, credit_in_W_4, credit_in_S_4, credit_in_L_4,
	valid_in_N_4, valid_in_E_4, valid_in_W_4, valid_in_S_4, valid_in_L_4,
	valid_out_N_4, valid_out_E_4, valid_out_W_4, valid_out_S_4, valid_out_L_4,
	credit_out_N_4, credit_out_E_4, credit_out_W_4, credit_out_S_4, credit_out_L_4,
	TX_N_4, TX_E_4, TX_W_4, TX_S_4, TX_L_4); 

R_5: router_credit_based generic map (DATA_WIDTH  => DATA_WIDTH, current_address=>5, NoC_size=>4)
PORT MAP (reset, clk, 
    Cx_reconf_5, Rxy_reconf_5, Reconfig,
	RX_N_5, RX_E_5, RX_W_5, RX_S_5, RX_L_5,
	credit_in_N_5, credit_in_E_5, credit_in_W_5, credit_in_S_5, credit_in_L_5,
	valid_in_N_5, valid_in_E_5, valid_in_W_5, valid_in_S_5, valid_in_L_5,
	valid_out_N_5, valid_out_E_5, valid_out_W_5, valid_out_S_5, valid_out_L_5,
	credit_out_N_5, credit_out_E_5, credit_out_W_5, credit_out_S_5, credit_out_L_5,
	TX_N_5, TX_E_5, TX_W_5, TX_S_5, TX_L_5); 

R_6: router_credit_based generic map (DATA_WIDTH  => DATA_WIDTH, current_address=>6, NoC_size=>4)
PORT MAP (reset, clk, 
    Cx_reconf_6, Rxy_reconf_6, Reconfig,
	RX_N_6, RX_E_6, RX_W_6, RX_S_6, RX_L_6,
	credit_in_N_6, credit_in_E_6, credit_in_W_6, credit_in_S_6, credit_in_L_6,
	valid_in_N_6, valid_in_E_6, valid_in_W_6, valid_in_S_6, valid_in_L_6,
	valid_out_N_6, valid_out_E_6, valid_out_W_6, valid_out_S_6, valid_out_L_6,
	credit_out_N_6, credit_out_E_6, credit_out_W_6, credit_out_S_6, credit_out_L_6,
	TX_N_6, TX_E_6, TX_W_6, TX_S_6, TX_L_6); 

R_7: router_credit_based generic map (DATA_WIDTH  => DATA_WIDTH, current_address=>7, NoC_size=>4) -- critical region
PORT MAP (reset, clk, 
    Cx_reconf_7, Rxy_reconf_7, Reconfig,
	RX_N_7, RX_E_7, RX_W_7, RX_S_7, RX_L_7,
	credit_in_N_7, credit_in_E_7, credit_in_W_7, credit_in_S_7, credit_in_L_7,
	valid_in_N_7, valid_in_E_7, valid_in_W_7, valid_in_S_7, valid_in_L_7,
	valid_out_N_7, valid_out_E_7, valid_out_W_7, valid_out_S_7, valid_out_L_7,
	credit_out_N_7, credit_out_E_7, credit_out_W_7, credit_out_S_7, credit_out_L_7,
	TX_N_7, TX_E_7, TX_W_7, TX_S_7, TX_L_7); 

R_8: router_credit_based generic map (DATA_WIDTH  => DATA_WIDTH, current_address=>8, NoC_size=>4)
PORT MAP (reset, clk, 
    Cx_reconf_8, Rxy_reconf_8, Reconfig,
	RX_N_8, RX_E_8, RX_W_8, RX_S_8, RX_L_8,
	credit_in_N_8, credit_in_E_8, credit_in_W_8, credit_in_S_8, credit_in_L_8,
	valid_in_N_8, valid_in_E_8, valid_in_W_8, valid_in_S_8, valid_in_L_8,
	valid_out_N_8, valid_out_E_8, valid_out_W_8, valid_out_S_8, valid_out_L_8,
	credit_out_N_8, credit_out_E_8, credit_out_W_8, credit_out_S_8, credit_out_L_8,
	TX_N_8, TX_E_8, TX_W_8, TX_S_8, TX_L_8); 

R_9: router_credit_based generic map (DATA_WIDTH  => DATA_WIDTH, current_address=>9, NoC_size=>4)
PORT MAP (reset, clk, 
    Cx_reconf_9, Rxy_reconf_9, Reconfig,
	RX_N_9, RX_E_9, RX_W_9, RX_S_9, RX_L_9,
	credit_in_N_9, credit_in_E_9, credit_in_W_9, credit_in_S_9, credit_in_L_9,
	valid_in_N_9, valid_in_E_9, valid_in_W_9, valid_in_S_9, valid_in_L_9,
	valid_out_N_9, valid_out_E_9, valid_out_W_9, valid_out_S_9, valid_out_L_9,
	credit_out_N_9, credit_out_E_9, credit_out_W_9, credit_out_S_9, credit_out_L_9,
	TX_N_9, TX_E_9, TX_W_9, TX_S_9, TX_L_9); 

R_10: router_credit_based generic map (DATA_WIDTH  => DATA_WIDTH, current_address=>10, NoC_size=>4)
PORT MAP (reset, clk, 
    Cx_reconf_10, Rxy_reconf_10, Reconfig,
	RX_N_10, RX_E_10, RX_W_10, RX_S_10, RX_L_10,
	credit_in_N_10, credit_in_E_10, credit_in_W_10, credit_in_S_10, credit_in_L_10,
	valid_in_N_10, valid_in_E_10, valid_in_W_10, valid_in_S_10, valid_in_L_10,
	valid_out_N_10, valid_out_E_10, valid_out_W_10, valid_out_S_10, valid_out_L_10,
	credit_out_N_10, credit_out_E_10, credit_out_W_10, credit_out_S_10, credit_out_L_10,
	TX_N_10, TX_E_10, TX_W_10, TX_S_10, TX_L_10); 

R_11: router_credit_based generic map (DATA_WIDTH  => DATA_WIDTH, current_address=>11, NoC_size=>4) -- critical region
PORT MAP (reset, clk, 
    Cx_reconf_11, Rxy_reconf_11, Reconfig,
	RX_N_11, RX_E_11, RX_W_11, RX_S_11, RX_L_11,
	credit_in_N_11, credit_in_E_11, credit_in_W_11, credit_in_S_11, credit_in_L_11,
	valid_in_N_11, valid_in_E_11, valid_in_W_11, valid_in_S_11, valid_in_L_11,
	valid_out_N_11, valid_out_E_11, valid_out_W_11, valid_out_S_11, valid_out_L_11,
	credit_out_N_11, credit_out_E_11, credit_out_W_11, credit_out_S_11, credit_out_L_11,
	TX_N_11, TX_E_11, TX_W_11, TX_S_11, TX_L_11); 

R_12: router_credit_based generic map (DATA_WIDTH  => DATA_WIDTH, current_address=>12, NoC_size=>4)
PORT MAP (reset, clk, 
    Cx_reconf_12, Rxy_reconf_12, Reconfig,
	RX_N_12, RX_E_12, RX_W_12, RX_S_12, RX_L_12,
	credit_in_N_12, credit_in_E_12, credit_in_W_12, credit_in_S_12, credit_in_L_12,
	valid_in_N_12, valid_in_E_12, valid_in_W_12, valid_in_S_12, valid_in_L_12,
	valid_out_N_12, valid_out_E_12, valid_out_W_12, valid_out_S_12, valid_out_L_12,
	credit_out_N_12, credit_out_E_12, credit_out_W_12, credit_out_S_12, credit_out_L_12,
	TX_N_12, TX_E_12, TX_W_12, TX_S_12, TX_L_12); 

R_13: router_credit_based generic map (DATA_WIDTH  => DATA_WIDTH, current_address=>13, NoC_size=>4)
PORT MAP (reset, clk, 
    Cx_reconf_13, Rxy_reconf_13, Reconfig,
	RX_N_13, RX_E_13, RX_W_13, RX_S_13, RX_L_13,
	credit_in_N_13, credit_in_E_13, credit_in_W_13, credit_in_S_13, credit_in_L_13,
	valid_in_N_13, valid_in_E_13, valid_in_W_13, valid_in_S_13, valid_in_L_13,
	valid_out_N_13, valid_out_E_13, valid_out_W_13, valid_out_S_13, valid_out_L_13,
	credit_out_N_13, credit_out_E_13, credit_out_W_13, credit_out_S_13, credit_out_L_13,
	TX_N_13, TX_E_13, TX_W_13, TX_S_13, TX_L_13); 

R_14: router_credit_based generic map (DATA_WIDTH  => DATA_WIDTH, current_address=>14, NoC_size=>4)
PORT MAP (reset, clk, 
    Cx_reconf_14, Rxy_reconf_14, Reconfig,
	RX_N_14, RX_E_14, RX_W_14, RX_S_14, RX_L_14,
	credit_in_N_14, credit_in_E_14, credit_in_W_14, credit_in_S_14, credit_in_L_14,
	valid_in_N_14, valid_in_E_14, valid_in_W_14, valid_in_S_14, valid_in_L_14,
	valid_out_N_14, valid_out_E_14, valid_out_W_14, valid_out_S_14, valid_out_L_14,
	credit_out_N_14, credit_out_E_14, credit_out_W_14, credit_out_S_14, credit_out_L_14,
	TX_N_14, TX_E_14, TX_W_14, TX_S_14, TX_L_14); 

R_15: router_credit_based generic map (DATA_WIDTH  => DATA_WIDTH, current_address=>15, NoC_size=>4) -- critical region
PORT MAP (reset, clk, 
    Cx_reconf_15, Rxy_reconf_15, Reconfig,
	RX_N_15, RX_E_15, RX_W_15, RX_S_15, RX_L_15,
	credit_in_N_15, credit_in_E_15, credit_in_W_15, credit_in_S_15, credit_in_L_15,
	valid_in_N_15, valid_in_E_15, valid_in_W_15, valid_in_S_15, valid_in_L_15,
	valid_out_N_15, valid_out_E_15, valid_out_W_15, valid_out_S_15, valid_out_L_15,
	credit_out_N_15, credit_out_E_15, credit_out_W_15, credit_out_S_15, credit_out_L_15,
	TX_N_15, TX_E_15, TX_W_15, TX_S_15, TX_L_15); 

---------------------------------------------------------------
-- binding the routers together
-- vertical ins/outs
-- connecting router: 0 to router: 4 and vice versa
RX_N_4<= TX_S_0;
RX_S_0<= TX_N_4;
-------------------
-- connecting router: 1 to router: 5 and vice versa
RX_N_5<= TX_S_1;
RX_S_1<= TX_N_5;
-------------------
-- connecting router: 2 to router: 6 and vice versa
RX_N_6<= TX_S_2;
RX_S_2<= TX_N_6;
-------------------
-- connecting router: 3 to router: 7 and vice versa
RX_N_7<= TX_S_3;
RX_S_3<= TX_N_7;
-------------------
-- connecting router: 4 to router: 8 and vice versa
RX_N_8<= TX_S_4;
RX_S_4<= TX_N_8;
-------------------
-- connecting router: 5 to router: 9 and vice versa
RX_N_9<= TX_S_5;
RX_S_5<= TX_N_9;
-------------------
-- connecting router: 6 to router: 10 and vice versa
RX_N_10<= TX_S_6;
RX_S_6<= TX_N_10;
-------------------
-- connecting router: 7 to router: 11 and vice versa
RX_N_11<= TX_S_7;
RX_S_7<= TX_N_11;
-------------------
-- connecting router: 8 to router: 12 and vice versa
RX_N_12<= TX_S_8;
RX_S_8<= TX_N_12;
-------------------
-- connecting router: 9 to router: 13 and vice versa
RX_N_13<= TX_S_9;
RX_S_9<= TX_N_13;
-------------------
-- connecting router: 10 to router: 14 and vice versa
RX_N_14<= TX_S_10;
RX_S_10<= TX_N_14;
-------------------
-- connecting router: 11 to router: 15 and vice versa
RX_N_15<= TX_S_11;
RX_S_11<= TX_N_15;
-------------------

-- horizontal ins/outs
-- connecting router: 0 to router: 1 and vice versa
RX_E_0 <= TX_W_1;
RX_W_1 <= TX_E_0;
-------------------
-- connecting router: 1 to router: 2 and vice versa
RX_E_1 <= TX_W_2;
RX_W_2 <= TX_E_1;
-------------------
-- connecting router: 2 to router: 3 and vice versa
RX_E_2 <= TX_W_3;
RX_W_3 <= TX_E_2;
-------------------
-- connecting router: 4 to router: 5 and vice versa
RX_E_4 <= TX_W_5;
RX_W_5 <= TX_E_4;
-------------------
-- connecting router: 5 to router: 6 and vice versa
RX_E_5 <= TX_W_6;
RX_W_6 <= TX_E_5;
-------------------
-- connecting router: 6 to router: 7 and vice versa
RX_E_6 <= TX_W_7;
RX_W_7 <= TX_E_6;
-------------------
-- connecting router: 8 to router: 9 and vice versa
RX_E_8 <= TX_W_9;
RX_W_9 <= TX_E_8;
-------------------
-- connecting router: 9 to router: 10 and vice versa
RX_E_9 <= TX_W_10;
RX_W_10 <= TX_E_9;
-------------------
-- connecting router: 10 to router: 11 and vice versa
RX_E_10 <= TX_W_11;
RX_W_11 <= TX_E_10;
-------------------
-- connecting router: 12 to router: 13 and vice versa
RX_E_12 <= TX_W_13;
RX_W_13 <= TX_E_12;
-------------------
-- connecting router: 13 to router: 14 and vice versa
RX_E_13 <= TX_W_14;
RX_W_14 <= TX_E_13;
-------------------
-- connecting router: 14 to router: 15 and vice versa
RX_E_14 <= TX_W_15;
RX_W_15 <= TX_E_14;
-------------------
---------------------------------------------------------------
-- binding the routers together
-- connecting router: 0 to router: 4 and vice versa
valid_in_N_4 <= valid_out_S_0;
valid_in_S_0 <= valid_out_N_4;
credit_in_S_0 <= credit_out_N_4;
credit_in_N_4 <= credit_out_S_0;
-------------------
-- connecting router: 1 to router: 5 and vice versa
valid_in_N_5 <= valid_out_S_1;
valid_in_S_1 <= valid_out_N_5;
credit_in_S_1 <= credit_out_N_5;
credit_in_N_5 <= credit_out_S_1;
-------------------
-- connecting router: 2 to router: 6 and vice versa
valid_in_N_6 <= valid_out_S_2;
valid_in_S_2 <= valid_out_N_6;
credit_in_S_2 <= credit_out_N_6;
credit_in_N_6 <= credit_out_S_2;
-------------------
-- connecting router: 3 to router: 7 and vice versa
valid_in_N_7 <= valid_out_S_3;
valid_in_S_3 <= valid_out_N_7;
credit_in_S_3 <= credit_out_N_7;
credit_in_N_7 <= credit_out_S_3;
-------------------
-- connecting router: 4 to router: 8 and vice versa
valid_in_N_8 <= valid_out_S_4;
valid_in_S_4 <= valid_out_N_8;
credit_in_S_4 <= credit_out_N_8;
credit_in_N_8 <= credit_out_S_4;
-------------------
-- connecting router: 5 to router: 9 and vice versa
valid_in_N_9 <= valid_out_S_5;
valid_in_S_5 <= valid_out_N_9;
credit_in_S_5 <= credit_out_N_9;
credit_in_N_9 <= credit_out_S_5;
-------------------
-- connecting router: 6 to router: 10 and vice versa
valid_in_N_10 <= valid_out_S_6;
valid_in_S_6 <= valid_out_N_10;
credit_in_S_6 <= credit_out_N_10;
credit_in_N_10 <= credit_out_S_6;
-------------------
-- connecting router: 7 to router: 11 and vice versa
valid_in_N_11 <= valid_out_S_7;
valid_in_S_7 <= valid_out_N_11;
credit_in_S_7 <= credit_out_N_11;
credit_in_N_11 <= credit_out_S_7;
-------------------
-- connecting router: 8 to router: 12 and vice versa
valid_in_N_12 <= valid_out_S_8;
valid_in_S_8 <= valid_out_N_12;
credit_in_S_8 <= credit_out_N_12;
credit_in_N_12 <= credit_out_S_8;
-------------------
-- connecting router: 9 to router: 13 and vice versa
valid_in_N_13 <= valid_out_S_9;
valid_in_S_9 <= valid_out_N_13;
credit_in_S_9 <= credit_out_N_13;
credit_in_N_13 <= credit_out_S_9;
-------------------
-- connecting router: 10 to router: 14 and vice versa
valid_in_N_14 <= valid_out_S_10;
valid_in_S_10 <= valid_out_N_14;
credit_in_S_10 <= credit_out_N_14;
credit_in_N_14 <= credit_out_S_10;
-------------------
-- connecting router: 11 to router: 15 and vice versa
valid_in_N_15 <= valid_out_S_11;
valid_in_S_11 <= valid_out_N_15;
credit_in_S_11 <= credit_out_N_15;
credit_in_N_15 <= credit_out_S_11;
-------------------

-- connecting router: 0 to router: 1 and vice versa
valid_in_E_0 <= valid_out_W_1;
valid_in_W_1 <= valid_out_E_0;
credit_in_W_1 <= credit_out_E_0;
credit_in_E_0 <= credit_out_W_1;
-------------------
-- connecting router: 1 to router: 2 and vice versa
valid_in_E_1 <= valid_out_W_2;
valid_in_W_2 <= valid_out_E_1;
credit_in_W_2 <= credit_out_E_1;
credit_in_E_1 <= credit_out_W_2;
-------------------
-- connecting router: 2 to router: 3 and vice versa
valid_in_E_2 <= valid_out_W_3;
valid_in_W_3 <= valid_out_E_2;
credit_in_W_3 <= credit_out_E_2;
credit_in_E_2 <= credit_out_W_3;
-------------------
-- connecting router: 4 to router: 5 and vice versa
valid_in_E_4 <= valid_out_W_5;
valid_in_W_5 <= valid_out_E_4;
credit_in_W_5 <= credit_out_E_4;
credit_in_E_4 <= credit_out_W_5;
-------------------
-- connecting router: 5 to router: 6 and vice versa
valid_in_E_5 <= valid_out_W_6;
valid_in_W_6 <= valid_out_E_5;
credit_in_W_6 <= credit_out_E_5;
credit_in_E_5 <= credit_out_W_6;
-------------------
-- connecting router: 6 to router: 7 and vice versa
valid_in_E_6 <= valid_out_W_7;
valid_in_W_7 <= valid_out_E_6;
credit_in_W_7 <= credit_out_E_6;
credit_in_E_6 <= credit_out_W_7;
-------------------
-- connecting router: 8 to router: 9 and vice versa
valid_in_E_8 <= valid_out_W_9;
valid_in_W_9 <= valid_out_E_8;
credit_in_W_9 <= credit_out_E_8;
credit_in_E_8 <= credit_out_W_9;
-------------------
-- connecting router: 9 to router: 10 and vice versa
valid_in_E_9 <= valid_out_W_10;
valid_in_W_10 <= valid_out_E_9;
credit_in_W_10 <= credit_out_E_9;
credit_in_E_9 <= credit_out_W_10;
-------------------
-- connecting router: 10 to router: 11 and vice versa
valid_in_E_10 <= valid_out_W_11;
valid_in_W_11 <= valid_out_E_10;
credit_in_W_11 <= credit_out_E_10;
credit_in_E_10 <= credit_out_W_11;
-------------------
-- connecting router: 12 to router: 13 and vice versa
valid_in_E_12 <= valid_out_W_13;
valid_in_W_13 <= valid_out_E_12;
credit_in_W_13 <= credit_out_E_12;
credit_in_E_12 <= credit_out_W_13;
-------------------
-- connecting router: 13 to router: 14 and vice versa
valid_in_E_13 <= valid_out_W_14;
valid_in_W_14 <= valid_out_E_13;
credit_in_W_14 <= credit_out_E_13;
credit_in_E_13 <= credit_out_W_14;
-------------------
-- connecting router: 14 to router: 15 and vice versa
valid_in_E_14 <= valid_out_W_15;
valid_in_W_15 <= valid_out_E_14;
credit_in_W_15 <= credit_out_E_14;
credit_in_E_14 <= credit_out_W_15;
-------------------
end;

--Copyright (C) 2016 Siavoosh Payandeh Azad
------------------------------------------------------------
-- Here are the parameters:
-- 	 network size x:4
-- 	 network size y:4
-- 	 data width:32--

library ieee;
use ieee.std_logic_1164.all;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.TB_Package.all;
use work.TB_seeds_packet.all;
use work.TB_experiment_settings_packet.all;
use work.type_def_pack.all;

USE ieee.numeric_std.ALL;
use IEEE.math_real."ceil";
use IEEE.math_real."log2";

entity tb_network_4x4 is
end tb_network_4x4;


architecture behavior of tb_network_4x4 is

  -- Declaring network component
  component network_4x4 is
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

  	--routing table signals
  	routing_table_bits_0:  in t_tata_long;
  	routing_table_bits_1:  in t_tata_long;
  	routing_table_bits_2:  in t_tata_long;
  	routing_table_bits_3:  in t_tata_long;
  	routing_table_bits_4:  in t_tata_long;
  	routing_table_bits_5:  in t_tata_long;
  	routing_table_bits_6:  in t_tata_long;
  	routing_table_bits_7:  in t_tata_long;
  	routing_table_bits_8:  in t_tata_long;
  	routing_table_bits_9:  in t_tata_long;
  	routing_table_bits_10: in t_tata_long;
  	routing_table_bits_11: in t_tata_long;
  	routing_table_bits_12: in t_tata_long;
  	routing_table_bits_13: in t_tata_long;
  	routing_table_bits_14: in t_tata_long;
  	routing_table_bits_15: in t_tata_long;

  	-- bypass mux select signals
  	sel_N_R_0 , sel_E_R_0 , sel_W_R_0 , sel_S_R_0 : in std_logic_vector(1 downto 0);
  	sel_N_R_1 , sel_E_R_1 , sel_W_R_1 , sel_S_R_1 : in std_logic_vector(1 downto 0);
  	sel_N_R_2 , sel_E_R_2 , sel_W_R_2 , sel_S_R_2 : in std_logic_vector(1 downto 0);
  	sel_N_R_3 , sel_E_R_3 , sel_W_R_3 , sel_S_R_3 : in std_logic_vector(1 downto 0);
  	sel_N_R_4 , sel_E_R_4 , sel_W_R_4 , sel_S_R_4 : in std_logic_vector(1 downto 0);
  	sel_N_R_5 , sel_E_R_5 , sel_W_R_5 , sel_S_R_5 : in std_logic_vector(1 downto 0);
  	sel_N_R_6 , sel_E_R_6 , sel_W_R_6 , sel_S_R_6 : in std_logic_vector(1 downto 0);
  	sel_N_R_7 , sel_E_R_7 , sel_W_R_7 , sel_S_R_7 : in std_logic_vector(1 downto 0);
  	sel_N_R_8 , sel_E_R_8 , sel_W_R_8 , sel_S_R_8 : in std_logic_vector(1 downto 0);
  	sel_N_R_9 , sel_E_R_9 , sel_W_R_9 , sel_S_R_9 : in std_logic_vector(1 downto 0);
  	sel_N_R_10, sel_E_R_10, sel_W_R_10, sel_S_R_10: in std_logic_vector(1 downto 0);
  	sel_N_R_11, sel_E_R_11, sel_W_R_11, sel_S_R_11: in std_logic_vector(1 downto 0);
  	sel_N_R_12, sel_E_R_12, sel_W_R_12, sel_S_R_12: in std_logic_vector(1 downto 0);
  	sel_N_R_13, sel_E_R_13, sel_W_R_13, sel_S_R_13: in std_logic_vector(1 downto 0);
  	sel_N_R_14, sel_E_R_14, sel_W_R_14, sel_S_R_14: in std_logic_vector(1 downto 0);
  	sel_N_R_15, sel_E_R_15, sel_W_R_15, sel_S_R_15: in std_logic_vector(1 downto 0)
     );
  end component;

-- generating bulk signals...
	signal RX_L_0, TX_L_0:  std_logic_vector (31 downto 0);
	signal credit_counter_out_0:  std_logic_vector (1 downto 0);
	signal credit_out_L_0, credit_in_L_0, valid_in_L_0, valid_out_L_0: std_logic;
	signal RX_L_1, TX_L_1:  std_logic_vector (31 downto 0);
	signal credit_counter_out_1:  std_logic_vector (1 downto 0);
	signal credit_out_L_1, credit_in_L_1, valid_in_L_1, valid_out_L_1: std_logic;
	signal RX_L_2, TX_L_2:  std_logic_vector (31 downto 0);
	signal credit_counter_out_2:  std_logic_vector (1 downto 0);
	signal credit_out_L_2, credit_in_L_2, valid_in_L_2, valid_out_L_2: std_logic;
	signal RX_L_3, TX_L_3:  std_logic_vector (31 downto 0);
	signal credit_counter_out_3:  std_logic_vector (1 downto 0);
	signal credit_out_L_3, credit_in_L_3, valid_in_L_3, valid_out_L_3: std_logic;
	signal RX_L_4, TX_L_4:  std_logic_vector (31 downto 0);
	signal credit_counter_out_4:  std_logic_vector (1 downto 0);
	signal credit_out_L_4, credit_in_L_4, valid_in_L_4, valid_out_L_4: std_logic;
	signal RX_L_5, TX_L_5:  std_logic_vector (31 downto 0);
	signal credit_counter_out_5:  std_logic_vector (1 downto 0);
	signal credit_out_L_5, credit_in_L_5, valid_in_L_5, valid_out_L_5: std_logic;
	signal RX_L_6, TX_L_6:  std_logic_vector (31 downto 0);
	signal credit_counter_out_6:  std_logic_vector (1 downto 0);
	signal credit_out_L_6, credit_in_L_6, valid_in_L_6, valid_out_L_6: std_logic;
	signal RX_L_7, TX_L_7:  std_logic_vector (31 downto 0);
	signal credit_counter_out_7:  std_logic_vector (1 downto 0);
	signal credit_out_L_7, credit_in_L_7, valid_in_L_7, valid_out_L_7: std_logic;
	signal RX_L_8, TX_L_8:  std_logic_vector (31 downto 0);
	signal credit_counter_out_8:  std_logic_vector (1 downto 0);
	signal credit_out_L_8, credit_in_L_8, valid_in_L_8, valid_out_L_8: std_logic;
	signal RX_L_9, TX_L_9:  std_logic_vector (31 downto 0);
	signal credit_counter_out_9:  std_logic_vector (1 downto 0);
	signal credit_out_L_9, credit_in_L_9, valid_in_L_9, valid_out_L_9: std_logic;
	signal RX_L_10, TX_L_10:  std_logic_vector (31 downto 0);
	signal credit_counter_out_10:  std_logic_vector (1 downto 0);
	signal credit_out_L_10, credit_in_L_10, valid_in_L_10, valid_out_L_10: std_logic;
	signal RX_L_11, TX_L_11:  std_logic_vector (31 downto 0);
	signal credit_counter_out_11:  std_logic_vector (1 downto 0);
	signal credit_out_L_11, credit_in_L_11, valid_in_L_11, valid_out_L_11: std_logic;
	signal RX_L_12, TX_L_12:  std_logic_vector (31 downto 0);
	signal credit_counter_out_12:  std_logic_vector (1 downto 0);
	signal credit_out_L_12, credit_in_L_12, valid_in_L_12, valid_out_L_12: std_logic;
	signal RX_L_13, TX_L_13:  std_logic_vector (31 downto 0);
	signal credit_counter_out_13:  std_logic_vector (1 downto 0);
	signal credit_out_L_13, credit_in_L_13, valid_in_L_13, valid_out_L_13: std_logic;
	signal RX_L_14, TX_L_14:  std_logic_vector (31 downto 0);
	signal credit_counter_out_14:  std_logic_vector (1 downto 0);
	signal credit_out_L_14, credit_in_L_14, valid_in_L_14, valid_out_L_14: std_logic;
	signal RX_L_15, TX_L_15:  std_logic_vector (31 downto 0);
	signal credit_counter_out_15:  std_logic_vector (1 downto 0);
	signal credit_out_L_15, credit_in_L_15, valid_in_L_15, valid_out_L_15: std_logic;
	--------------
  signal PGen_0_TX :  std_logic_vector (31 downto 0);
  signal PGen_1_TX :  std_logic_vector (31 downto 0);
  signal PGen_2_TX :  std_logic_vector (31 downto 0);
  signal PGen_3_TX :  std_logic_vector (31 downto 0);
  signal PGen_4_TX :  std_logic_vector (31 downto 0);
  signal PGen_5_TX :  std_logic_vector (31 downto 0);
  signal PGen_6_TX :  std_logic_vector (31 downto 0);
  signal PGen_7_TX :  std_logic_vector (31 downto 0);
  signal PGen_8_TX :  std_logic_vector (31 downto 0);
  signal PGen_9_TX :  std_logic_vector (31 downto 0);
  signal PGen_10_TX :  std_logic_vector (31 downto 0);
  signal PGen_11_TX :  std_logic_vector (31 downto 0);
  signal PGen_12_TX :  std_logic_vector (31 downto 0);
  signal PGen_13_TX :  std_logic_vector (31 downto 0);
  signal PGen_14_TX :  std_logic_vector (31 downto 0);
  signal PGen_15_TX :  std_logic_vector (31 downto 0);


  signal PGen_0_validout  :  std_logic;
  signal PGen_1_validout  :  std_logic;
  signal PGen_2_validout  :  std_logic;
  signal PGen_3_validout  :  std_logic;
  signal PGen_4_validout  :  std_logic;
  signal PGen_5_validout  :  std_logic;
  signal PGen_6_validout  :  std_logic;
  signal PGen_7_validout  :  std_logic;
  signal PGen_8_validout  :  std_logic;
  signal PGen_9_validout  :  std_logic;
  signal PGen_10_validout :  std_logic;
  signal PGen_11_validout :  std_logic;
  signal PGen_12_validout :  std_logic;
  signal PGen_13_validout :  std_logic;
  signal PGen_14_validout :  std_logic;
  signal PGen_15_validout :  std_logic;


  signal buff_full_0  :  std_logic;
  signal buff_full_1  :  std_logic;
  signal buff_full_2  :  std_logic;
  signal buff_full_3  :  std_logic;
  signal buff_full_4  :  std_logic;
  signal buff_full_5  :  std_logic;
  signal buff_full_6  :  std_logic;
  signal buff_full_7  :  std_logic;
  signal buff_full_8  :  std_logic;
  signal buff_full_9  :  std_logic;
  signal buff_full_10 :  std_logic;
  signal buff_full_11 :  std_logic;
  signal buff_full_12 :  std_logic;
  signal buff_full_13 :  std_logic;
  signal buff_full_14 :  std_logic;
  signal buff_full_15 :  std_logic;

	signal reset, clk: std_logic :='0';

begin

   clk_process :process
   begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
   end process;

reset <= '1' after 1 ns;

-- instantiating the network
NoC: network_4x4 generic map (DATA_WIDTH  => 32, DATA_WIDTH_LV => 11)
port map (reset, clk,
	RX_L_0, credit_out_L_0, valid_out_L_0, credit_in_L_0, valid_in_L_0,  TX_L_0,
	RX_L_1, credit_out_L_1, valid_out_L_1, credit_in_L_1, valid_in_L_1,  TX_L_1,
	RX_L_2, credit_out_L_2, valid_out_L_2, credit_in_L_2, valid_in_L_2,  TX_L_2,
	RX_L_3, credit_out_L_3, valid_out_L_3, credit_in_L_3, valid_in_L_3,  TX_L_3,
	RX_L_4, credit_out_L_4, valid_out_L_4, credit_in_L_4, valid_in_L_4,  TX_L_4,
	RX_L_5, credit_out_L_5, valid_out_L_5, credit_in_L_5, valid_in_L_5,  TX_L_5,
	RX_L_6, credit_out_L_6, valid_out_L_6, credit_in_L_6, valid_in_L_6,  TX_L_6,
	RX_L_7, credit_out_L_7, valid_out_L_7, credit_in_L_7, valid_in_L_7,  TX_L_7,
	RX_L_8, credit_out_L_8, valid_out_L_8, credit_in_L_8, valid_in_L_8,  TX_L_8,
	RX_L_9, credit_out_L_9, valid_out_L_9, credit_in_L_9, valid_in_L_9,  TX_L_9,
	RX_L_10, credit_out_L_10, valid_out_L_10, credit_in_L_10, valid_in_L_10,  TX_L_10,
	RX_L_11, credit_out_L_11, valid_out_L_11, credit_in_L_11, valid_in_L_11,  TX_L_11,
	RX_L_12, credit_out_L_12, valid_out_L_12, credit_in_L_12, valid_in_L_12,  TX_L_12,
	RX_L_13, credit_out_L_13, valid_out_L_13, credit_in_L_13, valid_in_L_13,  TX_L_13,
	RX_L_14, credit_out_L_14, valid_out_L_14, credit_in_L_14, valid_in_L_14,  TX_L_14,
	RX_L_15, credit_out_L_15, valid_out_L_15, credit_in_L_15, valid_in_L_15,  TX_L_15,
	--routing table signals
	routing_table_bits_0, routing_table_bits_1, routing_table_bits_2, routing_table_bits_3,
	routing_table_bits_4, routing_table_bits_5, routing_table_bits_6, routing_table_bits_7,
	routing_table_bits_8, routing_table_bits_9, routing_table_bits_10, routing_table_bits_11,
	routing_table_bits_12, routing_table_bits_13, routing_table_bits_14, routing_table_bits_15,
	-- bypass mux select signals
	sel_N_R_0 , sel_E_R_0 , sel_W_R_0 , sel_S_R_0,
	sel_N_R_1 , sel_E_R_1 , sel_W_R_1 , sel_S_R_1,
	sel_N_R_2 , sel_E_R_2 , sel_W_R_2 , sel_S_R_2,
	sel_N_R_3 , sel_E_R_3 , sel_W_R_3 , sel_S_R_3,
	sel_N_R_4 , sel_E_R_4 , sel_W_R_4 , sel_S_R_4,
	sel_N_R_5 , sel_E_R_5 , sel_W_R_5 , sel_S_R_5,
	sel_N_R_6 , sel_E_R_6 , sel_W_R_6 , sel_S_R_6,
	sel_N_R_7 , sel_E_R_7 , sel_W_R_7 , sel_S_R_7,
	sel_N_R_8 , sel_E_R_8 , sel_W_R_8 , sel_S_R_8,
	sel_N_R_9 , sel_E_R_9 , sel_W_R_9 , sel_S_R_9,
	sel_N_R_10, sel_E_R_10, sel_W_R_10, sel_S_R_10,
	sel_N_R_11, sel_E_R_11, sel_W_R_11, sel_S_R_11,
	sel_N_R_12, sel_E_R_12, sel_W_R_12, sel_S_R_12,
	sel_N_R_13, sel_E_R_13, sel_W_R_13, sel_S_R_13,
	sel_N_R_14, sel_E_R_14, sel_W_R_14, sel_S_R_14,
	sel_N_R_15, sel_E_R_15, sel_W_R_15, sel_S_R_15
   );


-- connecting the packet generators
CC_0: credit_counter_control(clk, credit_out_L_0, valid_in_L_0, credit_counter_out_0);
PG_0: gen_crit_packet_n(NoC_size, FRAME_SIZE, 0, 15, 8, 75, 75, END_PACKET_INJ_TIME, clk, buff_full_0 ,PGen_0_validout, PGen_0_TX , SEED_00_1, SEED_00_2);
IB_0: infinite_buffer(clk, PGen_0_validout, PGen_0_TX, credit_counter_out_0, valid_in_L_0, buff_full_0, RX_L_0);

CC_1: credit_counter_control(clk, credit_out_L_1, valid_in_L_1, credit_counter_out_1);
PG_1: gen_not_crit_packet_n(NoC_size, FRAME_SIZE, 1, 50, 3, 75, END_PACKET_INJ_TIME, clk, buff_full_1 ,PGen_1_validout, PGen_1_TX , SEED_01_1, SEED_01_2);
IB_1: infinite_buffer(clk, PGen_1_validout, PGen_1_TX, credit_counter_out_1, valid_in_L_1, buff_full_1, RX_L_1);

CC_2: credit_counter_control(clk, credit_out_L_2, valid_in_L_2, credit_counter_out_2);
PG_2: gen_not_crit_packet_n(NoC_size, FRAME_SIZE, 2, 26, 3, 75, END_PACKET_INJ_TIME, clk, buff_full_2 ,PGen_2_validout, PGen_2_TX , SEED_02_1, SEED_02_2);
IB_2: infinite_buffer(clk, PGen_2_validout, PGen_2_TX, credit_counter_out_2, valid_in_L_2, buff_full_2, RX_L_2);

CC_3: credit_counter_control(clk, credit_out_L_3, valid_in_L_3, credit_counter_out_3);
PG_3: gen_not_crit_packet_n(NoC_size, FRAME_SIZE, 3, 41, 3, 75, END_PACKET_INJ_TIME, clk, buff_full_3 ,PGen_3_validout, PGen_3_TX , SEED_03_1, SEED_03_2);
IB_3: infinite_buffer(clk, PGen_3_validout, PGen_3_TX, credit_counter_out_3, valid_in_L_3, buff_full_3, RX_L_3);


CC_4: credit_counter_control(clk, credit_out_L_4, valid_in_L_4, credit_counter_out_4);
PG_4: gen_not_crit_packet_n(NoC_size, FRAME_SIZE, 4, 9, 3, 75,  END_PACKET_INJ_TIME, clk, buff_full_4 ,PGen_4_validout, PGen_4_TX , SEED_04_1, SEED_04_2);
IB_4: infinite_buffer(clk, PGen_4_validout, PGen_4_TX, credit_counter_out_4, valid_in_L_4, buff_full_4, RX_L_4);

CC_5: credit_counter_control(clk, credit_out_L_5, valid_in_L_5, credit_counter_out_5);
PG_5: gen_not_crit_packet_n(NoC_size, FRAME_SIZE, 5, 24, 3, 75, END_PACKET_INJ_TIME, clk, buff_full_5 ,PGen_5_validout, PGen_5_TX , SEED_05_1, SEED_05_2);
IB_5: infinite_buffer(clk, PGen_5_validout, PGen_5_TX, credit_counter_out_5, valid_in_L_5, buff_full_5, RX_L_5);

CC_6: credit_counter_control(clk, credit_out_L_6, valid_in_L_6, credit_counter_out_6);
PG_6: gen_not_crit_packet_n(NoC_size, FRAME_SIZE, 6, 43, 3, 75, END_PACKET_INJ_TIME, clk, buff_full_6 ,PGen_6_validout, PGen_6_TX , SEED_06_1, SEED_06_2);
IB_6: infinite_buffer(clk, PGen_6_validout, PGen_6_TX, credit_counter_out_6, valid_in_L_6, buff_full_6, RX_L_6);

CC_7: credit_counter_control(clk, credit_out_L_7, valid_in_L_7, credit_counter_out_7);
PG_7: gen_not_crit_packet_n(NoC_size, FRAME_SIZE, 7, 5, 3, 75,  END_PACKET_INJ_TIME, clk, buff_full_7 ,PGen_7_validout, PGen_7_TX , SEED_07_1, SEED_07_2);
IB_7: infinite_buffer(clk, PGen_7_validout, PGen_7_TX, credit_counter_out_7, valid_in_L_7, buff_full_7, RX_L_7);

CC_8: credit_counter_control(clk, credit_out_L_8, valid_in_L_8, credit_counter_out_8);
PG_8: gen_not_crit_packet_n(NoC_size, FRAME_SIZE, 8, 18, 3, 75, END_PACKET_INJ_TIME, clk, buff_full_8 ,PGen_8_validout, PGen_8_TX , SEED_08_1, SEED_08_2);
IB_8: infinite_buffer(clk, PGen_8_validout, PGen_8_TX, credit_counter_out_8, valid_in_L_8, buff_full_8, RX_L_8);

CC_9: credit_counter_control(clk, credit_out_L_9, valid_in_L_9, credit_counter_out_9);
PG_9: gen_not_crit_packet_n(NoC_size, FRAME_SIZE, 9, 4, 3, 75,  END_PACKET_INJ_TIME, clk, buff_full_9 ,PGen_9_validout, PGen_9_TX , SEED_09_1, SEED_09_2);
IB_9: infinite_buffer(clk, PGen_9_validout, PGen_9_TX, credit_counter_out_9, valid_in_L_9, buff_full_9, RX_L_9);

CC_10: credit_counter_control(clk, credit_out_L_10, valid_in_L_10, credit_counter_out_10);
PG_10: gen_not_crit_packet_n(NoC_size, FRAME_SIZE, 10, 43, 3, 75, END_PACKET_INJ_TIME, clk, buff_full_10, PGen_10_validout, PGen_10_TX , SEED_10_1, SEED_10_2);
IB_10: infinite_buffer(clk, PGen_10_validout, PGen_10_TX, credit_counter_out_10, valid_in_L_10, buff_full_10, RX_L_10);

CC_11: credit_counter_control(clk, credit_out_L_11, valid_in_L_11, credit_counter_out_11);
PG_11: gen_not_crit_packet_n(NoC_size, FRAME_SIZE, 11, 38, 3, 75, END_PACKET_INJ_TIME, clk, buff_full_11, PGen_11_validout, PGen_11_TX , SEED_11_1, SEED_11_2);
IB_11: infinite_buffer(clk, PGen_11_validout, PGen_11_TX, credit_counter_out_11, valid_in_L_11, buff_full_11, RX_L_11);

CC_12: credit_counter_control(clk, credit_out_L_12, valid_in_L_12, credit_counter_out_12);
PG_12: gen_not_crit_packet_n(NoC_size, FRAME_SIZE, 12, 21, 3, 75, END_PACKET_INJ_TIME, clk, buff_full_12, PGen_12_validout, PGen_12_TX , SEED_12_1, SEED_12_2);
IB_12: infinite_buffer(clk, PGen_12_validout, PGen_12_TX, credit_counter_out_12, valid_in_L_12, buff_full_12, RX_L_12);

CC_13: credit_counter_control(clk, credit_out_L_13, valid_in_L_13, credit_counter_out_13);
PG_13: gen_not_crit_packet_n(NoC_size, FRAME_SIZE, 13, 7, 3, 75, END_PACKET_INJ_TIME, clk, buff_full_13, PGen_13_validout, PGen_13_TX , SEED_13_1, SEED_13_2);
IB_13: infinite_buffer(clk, PGen_13_validout, PGen_13_TX, credit_counter_out_13, valid_in_L_13, buff_full_13, RX_L_13);

CC_14: credit_counter_control(clk, credit_out_L_14, valid_in_L_14, credit_counter_out_14);
PG_14: gen_not_crit_packet_n(NoC_size, FRAME_SIZE, 14, 43, 3, 75, END_PACKET_INJ_TIME, clk, buff_full_14, PGen_14_validout, PGen_14_TX , SEED_14_1, SEED_14_2);
IB_14: infinite_buffer(clk, PGen_14_validout, PGen_14_TX, credit_counter_out_14, valid_in_L_14, buff_full_14, RX_L_14);

CC_15: credit_counter_control(clk, credit_out_L_15, valid_in_L_15, credit_counter_out_15);
PG_15: gen_crit_packet_n(NoC_size, FRAME_SIZE, 15, 0, 14, 75, 75, END_PACKET_INJ_TIME, clk, buff_full_15,PGen_15_validout, PGen_15_TX , SEED_15_1, SEED_15_2);
IB_15: infinite_buffer(clk, PGen_15_validout, PGen_15_TX, credit_counter_out_15, valid_in_L_15, buff_full_15, RX_L_15);


-- connecting the packet receivers
get_packet(32, 5, 0, clk, credit_in_L_0, valid_out_L_0, TX_L_0);
get_packet(32, 5, 1, clk, credit_in_L_1, valid_out_L_1, TX_L_1);
get_packet(32, 5, 2, clk, credit_in_L_2, valid_out_L_2, TX_L_2);
get_packet(32, 5, 3, clk, credit_in_L_3, valid_out_L_3, TX_L_3);
get_packet(32, 5, 4, clk, credit_in_L_4, valid_out_L_4, TX_L_4);
get_packet(32, 5, 5, clk, credit_in_L_5, valid_out_L_5, TX_L_5);
get_packet(32, 5, 6, clk, credit_in_L_6, valid_out_L_6, TX_L_6);
get_packet(32, 5, 7, clk, credit_in_L_7, valid_out_L_7, TX_L_7);
get_packet(32, 5, 8, clk, credit_in_L_8, valid_out_L_8, TX_L_8);
get_packet(32, 5, 9, clk, credit_in_L_9, valid_out_L_9, TX_L_9);
get_packet(32, 5, 10, clk, credit_in_L_10, valid_out_L_10, TX_L_10);
get_packet(32, 5, 11, clk, credit_in_L_11, valid_out_L_11, TX_L_11);
get_packet(32, 5, 12, clk, credit_in_L_12, valid_out_L_12, TX_L_12);
get_packet(32, 5, 13, clk, credit_in_L_13, valid_out_L_13, TX_L_13);
get_packet(32, 5, 14, clk, credit_in_L_14, valid_out_L_14, TX_L_14);
get_packet(32, 5, 15, clk, credit_in_L_15, valid_out_L_15, TX_L_15);


end;

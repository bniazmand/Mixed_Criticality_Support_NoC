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
credit_counter_control(clk, credit_out_L_0, valid_in_L_0, credit_counter_out_0);
gen_crit_packet_n(NoC_size, FRAME_SIZE, 0, 15, 8, 75, 75, END_PACKET_INJ_TIME, clk, credit_counter_out_0, valid_in_L_0, RX_L_0, SEED_00_1, SEED_00_2);

credit_counter_control(clk, credit_out_L_1, valid_in_L_1, credit_counter_out_1);
gen_not_crit_packet_n(NoC_size, FRAME_SIZE, 1, 50, 3, 75, END_PACKET_INJ_TIME, clk, credit_counter_out_1, valid_in_L_1, RX_L_1, SEED_01_1, SEED_01_2);

credit_counter_control(clk, credit_out_L_2, valid_in_L_2, credit_counter_out_2);
gen_not_crit_packet_n(NoC_size, FRAME_SIZE, 2, 26, 3, 75, END_PACKET_INJ_TIME, clk, credit_counter_out_2, valid_in_L_2, RX_L_2, SEED_02_1, SEED_02_2);

credit_counter_control(clk, credit_out_L_3, valid_in_L_3, credit_counter_out_3);
gen_not_crit_packet_n(NoC_size, FRAME_SIZE, 3, 41, 3, 75, END_PACKET_INJ_TIME, clk, credit_counter_out_3, valid_in_L_3, RX_L_3, SEED_03_1, SEED_03_2);

credit_counter_control(clk, credit_out_L_4, valid_in_L_4, credit_counter_out_4);
gen_not_crit_packet_n(NoC_size, FRAME_SIZE, 4, 9, 3, 75, END_PACKET_INJ_TIME, clk, credit_counter_out_4, valid_in_L_4, RX_L_4, SEED_04_1, SEED_04_2);

credit_counter_control(clk, credit_out_L_5, valid_in_L_5, credit_counter_out_5);
gen_not_crit_packet_n(NoC_size, FRAME_SIZE, 5, 24, 3, 75, END_PACKET_INJ_TIME, clk, credit_counter_out_5, valid_in_L_5, RX_L_5, SEED_05_1, SEED_05_2);

credit_counter_control(clk, credit_out_L_6, valid_in_L_6, credit_counter_out_6);
gen_not_crit_packet_n(NoC_size, FRAME_SIZE, 6, 43, 3, 75, END_PACKET_INJ_TIME, clk, credit_counter_out_6, valid_in_L_6, RX_L_6, SEED_06_1, SEED_06_2);

credit_counter_control(clk, credit_out_L_7, valid_in_L_7, credit_counter_out_7);
gen_not_crit_packet_n(NoC_size, FRAME_SIZE, 7, 5, 3, 75, END_PACKET_INJ_TIME, clk, credit_counter_out_7, valid_in_L_7, RX_L_7, SEED_07_1, SEED_07_2);

credit_counter_control(clk, credit_out_L_8, valid_in_L_8, credit_counter_out_8);
gen_not_crit_packet_n(NoC_size, FRAME_SIZE, 8, 18, 3, 75, END_PACKET_INJ_TIME, clk, credit_counter_out_8, valid_in_L_8, RX_L_8, SEED_08_1, SEED_08_2);

credit_counter_control(clk, credit_out_L_9, valid_in_L_9, credit_counter_out_9);
gen_not_crit_packet_n(NoC_size, FRAME_SIZE, 9, 4, 3, 75, END_PACKET_INJ_TIME, clk, credit_counter_out_9, valid_in_L_9, RX_L_9, SEED_09_1, SEED_09_2);

credit_counter_control(clk, credit_out_L_10, valid_in_L_10, credit_counter_out_10);
gen_not_crit_packet_n(NoC_size, FRAME_SIZE, 10, 43, 3, 75, END_PACKET_INJ_TIME, clk, credit_counter_out_10, valid_in_L_10, RX_L_10, SEED_10_1, SEED_10_2);

credit_counter_control(clk, credit_out_L_11, valid_in_L_11, credit_counter_out_11);
gen_not_crit_packet_n(NoC_size, FRAME_SIZE, 11, 38, 3, 75, END_PACKET_INJ_TIME, clk, credit_counter_out_11, valid_in_L_11, RX_L_11, SEED_11_1, SEED_11_2);

credit_counter_control(clk, credit_out_L_12, valid_in_L_12, credit_counter_out_12);
gen_not_crit_packet_n(NoC_size, FRAME_SIZE, 12, 21, 3, 75, END_PACKET_INJ_TIME, clk, credit_counter_out_12, valid_in_L_12, RX_L_12, SEED_12_1, SEED_12_2);

credit_counter_control(clk, credit_out_L_13, valid_in_L_13, credit_counter_out_13);
gen_not_crit_packet_n(NoC_size, FRAME_SIZE, 13, 7, 3, 75, END_PACKET_INJ_TIME, clk, credit_counter_out_13, valid_in_L_13, RX_L_13, SEED_13_1, SEED_13_2);

credit_counter_control(clk, credit_out_L_14, valid_in_L_14, credit_counter_out_14);
gen_not_crit_packet_n(NoC_size, FRAME_SIZE, 14, 43, 3, 75, END_PACKET_INJ_TIME, clk, credit_counter_out_14, valid_in_L_14, RX_L_14, SEED_14_1, SEED_14_2);

credit_counter_control(clk, credit_out_L_15, valid_in_L_15, credit_counter_out_15);
gen_crit_packet_n(NoC_size, FRAME_SIZE, 15, 0, 14, 75, 75, END_PACKET_INJ_TIME, clk, credit_counter_out_15, valid_in_L_15, RX_L_15, SEED_15_1, SEED_15_2);


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

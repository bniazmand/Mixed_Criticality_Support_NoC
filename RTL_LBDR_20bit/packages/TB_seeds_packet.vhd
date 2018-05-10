--Copyright (C) 2017 Serhiy Avramenko

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use IEEE.NUMERIC_STD.all;
 use ieee.math_real.all;
 use std.textio.all;
 use ieee.std_logic_misc.all;



package TB_seeds_packet is

-- math_real.vhdl
	--   seed_01: [1, 2147483562]
   --   seed_02: [1, 2147483398]
	constant SEED_00_1 : positive;
	constant SEED_00_2 : positive;
	constant SEED_01_1 : positive;
	constant SEED_01_2 : positive;
	constant SEED_02_1 : positive;
	constant SEED_02_2 : positive;
	constant SEED_03_1 : positive;
	constant SEED_03_2 : positive;
	constant SEED_04_1 : positive;
	constant SEED_04_2 : positive;
	constant SEED_05_1 : positive;
	constant SEED_05_2 : positive;
	constant SEED_06_1 : positive;
	constant SEED_06_2 : positive;
	constant SEED_07_1 : positive;
	constant SEED_07_2 : positive;
	constant SEED_08_1 : positive;
	constant SEED_08_2 : positive;
	constant SEED_09_1 : positive;
	constant SEED_09_2 : positive;
	constant SEED_10_1 : positive;
	constant SEED_10_2 : positive;
	constant SEED_11_1 : positive;
	constant SEED_11_2 : positive;
	constant SEED_12_1 : positive;
	constant SEED_12_2 : positive;
	constant SEED_13_1 : positive;
	constant SEED_13_2 : positive;
	constant SEED_14_1 : positive;
	constant SEED_14_2 : positive;
	constant SEED_15_1 : positive;
	constant SEED_15_2 : positive;
end TB_seeds_packet;



package body TB_seeds_packet is
	constant SEED_00_1 : positive := 16587;
	constant SEED_00_2 : positive := 13545;
	constant SEED_01_1 : positive := 9148;
	constant SEED_01_2 : positive := 13740;
	constant SEED_02_1 : positive := 31940;
	constant SEED_02_2 : positive := 15183;
	constant SEED_03_1 : positive := 28956;
	constant SEED_03_2 : positive := 8176;
	constant SEED_04_1 : positive := 6848;
	constant SEED_04_2 : positive := 923;
	constant SEED_05_1 : positive := 13321;
	constant SEED_05_2 : positive := 32573;
	constant SEED_06_1 : positive := 27564;
	constant SEED_06_2 : positive := 10480;
	constant SEED_07_1 : positive := 3846;
	constant SEED_07_2 : positive := 26798;
	constant SEED_08_1 : positive := 24367;
	constant SEED_08_2 : positive := 4306;
	constant SEED_09_1 : positive := 11319;
	constant SEED_09_2 : positive := 17482;
	constant SEED_10_1 : positive := 23778;
	constant SEED_10_2 : positive := 1652;
	constant SEED_11_1 : positive := 30277;
	constant SEED_11_2 : positive := 18244;
	constant SEED_12_1 : positive := 19072;
	constant SEED_12_2 : positive := 21823;
	constant SEED_13_1 : positive := 11790;
	constant SEED_13_2 : positive := 21189;
	constant SEED_14_1 : positive := 32010;
	constant SEED_14_2 : positive := 21763;
	constant SEED_15_1 : positive := 23836;
	constant SEED_15_2 : positive := 15829;
	
end TB_seeds_packet;


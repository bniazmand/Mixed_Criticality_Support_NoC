--Copyright (C) 2017 Serhiy Avramenko

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use IEEE.NUMERIC_STD.all;
 use ieee.math_real.all;
 use std.textio.all;
 use ieee.std_logic_misc.all;



package TB_experiment_settings_packet is

	constant END_PACKET_INJ_TIME : time;
	constant FRAME_SIZE : integer;
	
end TB_experiment_settings_packet;



package body TB_experiment_settings_packet is

	-- the last instant a new transmission is allowed	
	constant END_PACKET_INJ_TIME : time := 10000000 ns;	
	
	-- FRAME_SIZE CCs
	constant FRAME_SIZE : integer := 100;
	
end TB_experiment_settings_packet;



--Copyright (C) 2016 Siavoosh Payandeh Azad

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use IEEE.NUMERIC_STD.all;
 use ieee.math_real.all;
 use std.textio.all;
 use ieee.std_logic_misc.all;

package type_def_pack is

  -- L-Shape critical region going through the network (nodes 0 and 14 are the nodes running critical task(s)).
  constant Cx_reconf_0:  std_logic_vector(3 downto 0) := std_logic_vector(to_unsigned(2,4));
	constant Cx_reconf_1:  std_logic_vector(3 downto 0) := std_logic_vector(to_unsigned(6,4));
	constant Cx_reconf_2:  std_logic_vector(3 downto 0) := std_logic_vector(to_unsigned(12,4));
	constant Cx_reconf_3:  std_logic_vector(3 downto 0) := std_logic_vector(to_unsigned(8,4));
	constant Cx_reconf_4:  std_logic_vector(3 downto 0) := std_logic_vector(to_unsigned(10,4));
	constant Cx_reconf_5:  std_logic_vector(3 downto 0) := std_logic_vector(to_unsigned(12,4));
	constant Cx_reconf_6:  std_logic_vector(3 downto 0) := std_logic_vector(to_unsigned(9,4));
	constant Cx_reconf_7:  std_logic_vector(3 downto 0) := std_logic_vector(to_unsigned(9,4));
	constant Cx_reconf_8:  std_logic_vector(3 downto 0) := std_logic_vector(to_unsigned(11,4));
	constant Cx_reconf_9:  std_logic_vector(3 downto 0) := std_logic_vector(to_unsigned(13,4));
	constant Cx_reconf_10: std_logic_vector(3 downto 0) := std_logic_vector(to_unsigned(9,4));
	constant Cx_reconf_11: std_logic_vector(3 downto 0) := std_logic_vector(to_unsigned(9,4));
	constant Cx_reconf_12: std_logic_vector(3 downto 0) := std_logic_vector(to_unsigned(3,4));
	constant Cx_reconf_13: std_logic_vector(3 downto 0) := std_logic_vector(to_unsigned(5,4));
	constant Cx_reconf_14: std_logic_vector(3 downto 0) := std_logic_vector(to_unsigned(1,4));
	constant Cx_reconf_15: std_logic_vector(3 downto 0) := std_logic_vector(to_unsigned(1,4));


  -- The turn model for critical region (path from node 0 to 14 and 14 to 0 : The path goes through nodes 1, 2, 6, and 10 and vice versa)
  constant Rxy_reconf_0: std_logic_vector  (7 downto 0) := "00111100"; -- XY turn model
  constant Rxy_reconf_1: std_logic_vector  (7 downto 0) := "00111100"; -- XY turn model
  constant Rxy_reconf_2: std_logic_vector  (7 downto 0) := "00111100"; -- XY turn model
  constant Rxy_reconf_6: std_logic_vector  (7 downto 0) := "11000011"; -- YX turn model
  constant Rxy_reconf_10: std_logic_vector (7 downto 0) := "11000011"; -- YX turn model
  constant Rxy_reconf_14: std_logic_vector (7 downto 0) := "11000011"; -- YX turn model

  -- The turn model for non-critical region
  constant Rxy_reconf_3: std_logic_vector  (7 downto 0) := "11111100"; -- North-Last turn model
  constant Rxy_reconf_4: std_logic_vector  (7 downto 0) := "11111100"; -- North-Last turn model
  constant Rxy_reconf_5: std_logic_vector  (7 downto 0) := "11111100"; -- North-Last turn model
  constant Rxy_reconf_7: std_logic_vector  (7 downto 0) := "11111100"; -- North-Last turn model
  constant Rxy_reconf_8: std_logic_vector  (7 downto 0) := "11111100"; -- North-Last turn model
  constant Rxy_reconf_9: std_logic_vector  (7 downto 0) := "11111100"; -- North-Last turn model
  constant Rxy_reconf_11: std_logic_vector (7 downto 0) := "11111100"; -- North-Last turn model
  constant Rxy_reconf_12: std_logic_vector (7 downto 0) := "11111100"; -- North-Last turn model
  constant Rxy_reconf_13: std_logic_vector (7 downto 0) := "11111100"; -- North-Last turn model
  constant Rxy_reconf_15: std_logic_vector (7 downto 0) := "11111100"; -- North-Last turn model

  end type_def_pack;

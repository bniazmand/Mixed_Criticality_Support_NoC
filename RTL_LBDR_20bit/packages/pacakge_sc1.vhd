--Copyright (C) 2016 Siavoosh Payandeh Azad

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use IEEE.NUMERIC_STD.all;
 use ieee.math_real.all;
 use std.textio.all;
 use ieee.std_logic_misc.all;

package type_def_pack is

      --S2E <= Rxy(0); -- Rne
      --S2W <= Rxy(1); -- Rnw
      --W2N <= Rxy(2); -- Ren
      --W2S <= Rxy(3); -- Res
      --E2N <= Rxy(4); -- Rwn
      --E2S <= Rxy(5); -- Rws
      --N2E <= Rxy(6); -- Rse
      --N2W <= Rxy(7); -- Rsw

      --N2S <= Rxy(8);  --Rss
      --S2N <= Rxy(9);  --Rnn
      --E2W <= Rxy(10); --Rww
      --W2E <= Rxy(11); --Ree
      --L2N <= Rxy(12);
      --N2L <= Rxy(13);
      --L2E <= Rxy(14);
      --E2L <= Rxy(15);
      --L2W <= Rxy(16);
      --W2L <= Rxy(17);
      --L2S <= Rxy(18);
      --S2L <= Rxy(19);

  	constant Rxy_reconf_0:  std_logic_vector(19 downto 0) := "00001100000000000000"; --0
  	constant Rxy_reconf_1:  std_logic_vector(19 downto 0) := "11000000110000000000"; --0
  	constant Rxy_reconf_2:  std_logic_vector(19 downto 0) := "11000000110000000000"; --0
  	constant Rxy_reconf_3:  std_logic_vector(19 downto 0) := "00000000000000001010"; --10
  	constant Rxy_reconf_4:  std_logic_vector(19 downto 0) := "11001100000000100000"; --32
  	constant Rxy_reconf_5:  std_logic_vector(19 downto 0) := "11111111111111111100"; --252
  	constant Rxy_reconf_6:  std_logic_vector(19 downto 0) := "11111111111111111100"; --252
  	constant Rxy_reconf_7:  std_logic_vector(19 downto 0) := "00110000001100000000"; --0
  	constant Rxy_reconf_8:  std_logic_vector(19 downto 0) := "11001111001101110000"; --112
  	constant Rxy_reconf_9:  std_logic_vector(19 downto 0) := "11111111111111111100"; --252
  	constant Rxy_reconf_10: std_logic_vector(19 downto 0) := "11111111111111111100"; --252
  	constant Rxy_reconf_11: std_logic_vector(19 downto 0) := "00110000001100000000"; --0
  	constant Rxy_reconf_12: std_logic_vector(19 downto 0) := "00001111000001010000"; --80
  	constant Rxy_reconf_13: std_logic_vector(19 downto 0) := "00111111110011010100"; --212
  	constant Rxy_reconf_14: std_logic_vector(19 downto 0) := "00110011000010000100"; --132
  	constant Rxy_reconf_15: std_logic_vector(19 downto 0) := "00000011000000000000"; --0

    constant Cx_reconf_0 : std_logic_vector(4 downto 0):= std_logic_vector(to_unsigned(26, 5));
    constant Cx_reconf_1 : std_logic_vector(4 downto 0):= std_logic_vector(to_unsigned(30, 5));
    constant Cx_reconf_2 : std_logic_vector(4 downto 0):= std_logic_vector(to_unsigned(30, 5));
    constant Cx_reconf_3 : std_logic_vector(4 downto 0):= std_logic_vector(to_unsigned(28, 5));
    constant Cx_reconf_4 : std_logic_vector(4 downto 0):= std_logic_vector(to_unsigned(27, 5));
    constant Cx_reconf_5 : std_logic_vector(4 downto 0):= std_logic_vector(to_unsigned(31, 5));
    constant Cx_reconf_6 : std_logic_vector(4 downto 0):= std_logic_vector(to_unsigned(31, 5));
    constant Cx_reconf_7 : std_logic_vector(4 downto 0):= std_logic_vector(to_unsigned(29, 5));
    constant Cx_reconf_8 : std_logic_vector(4 downto 0):= std_logic_vector(to_unsigned(27, 5));
    constant Cx_reconf_9 : std_logic_vector(4 downto 0):= std_logic_vector(to_unsigned(31, 5));
    constant Cx_reconf_10: std_logic_vector(4 downto 0):= std_logic_vector(to_unsigned(31, 5));
    constant Cx_reconf_11: std_logic_vector(4 downto 0):= std_logic_vector(to_unsigned(29, 5));
    constant Cx_reconf_12: std_logic_vector(4 downto 0):= std_logic_vector(to_unsigned(19, 5));
    constant Cx_reconf_13: std_logic_vector(4 downto 0):= std_logic_vector(to_unsigned(23, 5));
    constant Cx_reconf_14: std_logic_vector(4 downto 0):= std_logic_vector(to_unsigned(23, 5));
    constant Cx_reconf_15: std_logic_vector(4 downto 0):= std_logic_vector(to_unsigned(21, 5));
end type_def_pack;

--Copyright (C) 2016 Siavoosh Payandeh Azad

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use IEEE.NUMERIC_STD.all;
 use ieee.math_real.all;
 use std.textio.all;
 use ieee.std_logic_misc.all;

package type_def_pack is

   type t_tata IS ARRAY(0 to 15) OF STD_LOGIC_VECTOR(3 DOWNTO 0);
   type t_tata_long IS ARRAY(0 to 79) OF STD_LOGIC_VECTOR(3 DOWNTO 0);
   
end type_def_pack;

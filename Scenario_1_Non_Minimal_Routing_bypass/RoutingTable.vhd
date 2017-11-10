library ieee;
use ieee.std_logic_1164.all;
use IEEE.Numeric_Std.all;

library work;
use work.type_def_pack.all;

entity RoutingTable is
    generic (
        cur_addr_rst: integer := 8;
        NoC_size: integer := 4;

        routing_table_rst: t_tata := (
        	0 =>   	"0000",
			1 =>   	"0000",
			2 =>   	"0000",
			3 =>   	"0000",
			4 =>   	"0000",
			5 =>   	"0000",
			6 =>   	"0000",
			7 =>   	"0000",
			8 =>   	"0000",
			9 =>   	"0000",
			10 =>  	"0000",
			11 =>  	"0000",
			12 => 	"0000",
			13 => 	"0000",
			14 => 	"0000",
			15 => 	"0100"
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
end entity RoutingTable;

architecture behavioral of RoutingTable is

signal routing_table : t_tata;
  
-- Bits are in this order: NEWS

signal cur_addr:  std_logic_vector(NoC_size-1 downto 0);      
signal Req_N_in, Req_E_in, Req_W_in, Req_S_in, Req_L_in: std_logic;
signal Req_N_FF, Req_E_FF, Req_W_FF, Req_S_FF, Req_L_FF: std_logic;
signal grants: std_logic;

begin

-- Sequential part

process(clk, reset) begin

	if reset = '0' then 
		Req_N_FF <= '0';
		Req_E_FF <= '0';
		Req_W_FF <= '0';
		Req_S_FF <= '0';
		Req_L_FF <= '0';
		routing_table <= routing_table_rst;

	elsif clk'event and clk = '1' then
		Req_N_FF <= Req_N_in;
		Req_E_FF <= Req_E_in;
		Req_W_FF <= Req_W_in;
		Req_S_FF <= Req_S_in;
		Req_L_FF <= Req_L_in;

	end if;

end process;
 
-- Anything below is combinational

grants <= grant_N or grant_E or grant_W or grant_S or grant_L;

cur_addr <= std_logic_vector(to_unsigned(cur_addr_rst, cur_addr'length));

Req_N <= Req_N_FF;
Req_E <= Req_E_FF;
Req_W <= Req_W_FF;
Req_S <= Req_S_FF;
Req_L <= Req_L_FF;

process (flit_type, empty, cur_addr, dst_addr, grants, Req_N_FF, Req_E_FF, Req_W_FF, Req_S_FF, Req_L_FF, routing_table) begin

	if flit_type = "001" and empty = '0' then
		-- Header flit, perform routing, look in the routing table
		if (cur_addr = dst_addr) then 
			-- If flit has reached its destination (current node is the destination node) -> Local output request goes active.
			Req_N_in <= '0';
			Req_E_in <= '0';
			Req_W_in <= '0';
			Req_S_in <= '0';
			Req_L_in <= '1';
		else 
			-- Find appropriate candidate output port(s) based on the routing table.
  			Req_N_in <= routing_table(to_integer(unsigned(dst_addr)))(3);
  			Req_E_in <= routing_table(to_integer(unsigned(dst_addr)))(2);
  			Req_W_in <= routing_table(to_integer(unsigned(dst_addr)))(1);
  			Req_S_in <= routing_table(to_integer(unsigned(dst_addr)))(0);
			Req_L_in <= '0';
		end if;


	elsif flit_type = "100" and empty = '0' and grants = '1' then
		Req_N_in <= '0';
		Req_E_in <= '0';
		Req_W_in <= '0';
		Req_S_in <= '0';
		Req_L_in <= '0';

	else -- Body flit (or invalid flit type)
		Req_N_in <= Req_N_FF;
		Req_E_in <= Req_E_FF;
		Req_W_in <= Req_W_FF;
		Req_S_in <= Req_S_FF;
		Req_L_in <= Req_L_FF;
	end if;

end process;
  
end architecture behavioral;
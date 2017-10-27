--Copyright (C) 2016 Siavoosh Payandeh Azad Behrad Niazmand

library ieee;
use ieee.std_logic_1164.all;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.all;
use IEEE.MATH_REAL.ALL;

entity LBDR is
    generic (
        cur_addr_rst: integer := 8;

        Cx_rst: integer := 8;
        NoC_size: integer := 4
    );
    port (  reset: in  std_logic;
            clk: in  std_logic;
            
            Rxy_reconf: in  std_logic_vector(19 downto 0);
            Reconfig : in std_logic;

            empty: in  std_logic;
            flit_type: in std_logic_vector(2 downto 0);
            dst_addr: in std_logic_vector(NoC_size-1 downto 0);
	          grant_N, grant_E, grant_W, grant_S, grant_L: in std_logic;
            Req_N, Req_E, Req_W, Req_S, Req_L:out std_logic; 

            dir_in: in std_logic_vector(2 downto 0)            
            );
end LBDR;

architecture behavior of LBDR is

  signal Cx:  std_logic_vector(4 downto 0);
  signal Cn, Ce, Cw, Cs, Cl: std_logic;
  signal Rxy, Rxy_in:  std_logic_vector(19 downto 0);
  signal cur_addr:  std_logic_vector(NoC_size-1 downto 0);  
  signal N1, E1, W1, S1  :std_logic :='0';  
  signal N_prime, E_prime, W_prime, S_prime  :std_logic :='0';  
  signal Req_N_in, Req_E_in, Req_W_in, Req_S_in, Req_L_in: std_logic;
  signal Req_N_FF, Req_E_FF, Req_W_FF, Req_S_FF, Req_L_FF: std_logic;
  signal N2E, E2N, S2E, E2S, N2W, W2N, S2W, W2S, N2S, S2N, E2W, W2E: std_logic;
  signal L2N, N2L, L2E, E2L, L2W, W2L, L2S, S2L: std_logic;
  
  signal grants: std_logic;
  signal ReConf_FF_in, ReConf_FF_out: std_logic;

  CONSTANT North: std_logic_vector(2 downto 0) := "000";
  CONSTANT East:  std_logic_vector(2 downto 0) := "001";
  CONSTANT West:  std_logic_vector(2 downto 0) := "010";
  CONSTANT South: std_logic_vector(2 downto 0) := "011";
  CONSTANT Local: std_logic_vector(2 downto 0) := "100";

begin 

 grants <= grant_N or grant_E or grant_W or grant_S or grant_L;

  Cx <= std_logic_vector(to_unsigned(Cx_rst, Cx'length));
  
  cur_addr <= std_logic_vector(to_unsigned(cur_addr_rst, cur_addr'length));

  N_prime <= '1' when  dst_addr(NoC_size-1 downto NoC_size/2) < cur_addr(NoC_size-1 downto NoC_size/2) else '0';
  E_prime <= '1' when  cur_addr((NoC_size/2)-1 downto 0) < dst_addr((NoC_size/2)-1 downto 0) else '0';
  W_prime <= '1' when  dst_addr((NoC_size/2)-1 downto 0) < cur_addr((NoC_size/2)-1 downto 0) else '0';
  S_prime <= '1' when  cur_addr(NoC_size-1 downto NoC_size/2) < dst_addr(NoC_size-1 downto NoC_size/2) else '0';

  N1 <= '1' when  (dst_addr(NoC_size-1 downto NoC_size/2) < cur_addr(NoC_size-1 downto NoC_size/2) and cur_addr(NoC_size-1 downto NoC_size/2) - dst_addr(NoC_size-1 downto NoC_size/2) = 1) else '0';
  E1 <= '1' when  (cur_addr((NoC_size/2)-1 downto 0) < dst_addr((NoC_size/2)-1 downto 0) and dst_addr((NoC_size/2)-1 downto 0) - cur_addr((NoC_size/2)-1 downto 0) = 1) else '0';
  W1 <= '1' when  (dst_addr((NoC_size/2)-1 downto 0) < cur_addr((NoC_size/2)-1 downto 0) and cur_addr((NoC_size/2)-1 downto 0) - dst_addr((NoC_size/2)-1 downto 0) = 1) else '0';
  S1 <= '1' when  (cur_addr(NoC_size-1 downto NoC_size/2) < dst_addr(NoC_size-1 downto NoC_size/2) and dst_addr(NoC_size-1 downto NoC_size/2) - cur_addr(NoC_size-1 downto NoC_size/2) = 1) else '0';

  Cn <= Cx(0);
  Ce <= Cx(1);
  Cw <= Cx(2);
  Cs <= Cx(3);
  Cl <= Cx(4);

  S2E <= Rxy(0); -- Rne
  S2W <= Rxy(1); -- Rnw
  W2N <= Rxy(2); -- Ren
  W2S <= Rxy(3); -- Res
  E2N <= Rxy(4); -- Rwn
  E2S <= Rxy(5); -- Rws
  N2E <= Rxy(6); -- Rse
  N2W <= Rxy(7); -- Rsw

  N2S <= Rxy(8);  --Rss
  S2N <= Rxy(9);  --Rnn
  E2W <= Rxy(10); --Rww
  W2E <= Rxy(11); --Ree
  L2N <= Rxy(12);
  N2L <= Rxy(13);
  L2E <= Rxy(14);
  E2L <= Rxy(15);
  L2W <= Rxy(16);
  W2L <= Rxy(17);
  L2S <= Rxy(18);
  S2L <= Rxy(19);

process(clk, reset)
begin
if reset = '0' then 
  Rxy <= Rxy_reconf;
  Req_N_FF <= '0';
  Req_E_FF <= '0';
  Req_W_FF <= '0';
  Req_S_FF <= '0';
  Req_L_FF <= '0';
  ReConf_FF_out <= '0';
elsif clk'event and clk = '1' then
  Rxy <= Rxy_in;	
  Req_N_FF <= Req_N_in;
  Req_E_FF <= Req_E_in;
  Req_W_FF <= Req_W_in;
  Req_S_FF <= Req_S_in;
  Req_L_FF <= Req_L_in;
  ReConf_FF_out <= ReConf_FF_in;
end if;
end process;
 

-- The combionational part
process(Rxy_reconf, ReConf_FF_out, Rxy, Reconfig, flit_type, grants, empty)begin
  if ReConf_FF_out= '1' and flit_type = "100" and empty = '0' and grants = '1' then
	  	Rxy_in <= Rxy_reconf;
	  	ReConf_FF_in <= '0';
  else
  	Rxy_in <= Rxy;
  	if Reconfig = '1' then 
  		ReConf_FF_in <= '1';
  	else
  		ReConf_FF_in <= ReConf_FF_out;
  	end if;
  end if; 
end process;


Req_N <= Req_N_FF;
Req_E <= Req_E_FF;
Req_W <= Req_W_FF;
Req_S <= Req_S_FF;
Req_L <= Req_L_FF;

process(N_prime, E_prime, W_prime, S_prime, dir_in, N2E, E2N, S2E, E2S, N2W, W2N, S2W, W2S, N2S, S2N, E2W, W2E, L2N, N2L, L2E, E2L, L2W, W2L, L2S, S2L, Cn, Ce, Cw, Cs, flit_type, empty, Req_N_FF, Req_E_FF, Req_W_FF, Req_S_FF, Req_L_FF, grants) begin
 if flit_type = "001" and empty = '0' then
        -- Initialize all output requests to zero.
        Req_N_in <= '0';
        Req_E_in <= '0';
        Req_W_in <= '0';
        Req_S_in <= '0';
        Req_L_in <= '0';

        --if (cur_addr_rst /= 15 and cur_addr_rst /= 11 and cur_addr_rst /= 7 and cur_addr_rst /= 3) then

        --    if (dir_in = East and E2N = '1') and Cn = '1' and N_prime = '1' and E_prime = '0' and W_prime = '0' then
        --        Req_N_in <= '1';
        --    elsif (dir_in = West and W2N = '1') and Cn = '1' and N_prime = '1' and E_prime = '0' and W_prime = '0' then
        --        Req_N_in <= '1';
        --    elsif (dir_in = South and S2N = '1') and Cn = '1' and N_prime = '1' and E_prime = '0' and W_prime = '0' then
        --        Req_N_in <= '1';
        --    elsif (dir_in = Local and L2N = '1') and Cn = '1' and N_prime = '1' and E_prime = '0' and W_prime = '0' then
        --        Req_N_in <= '1';
        --    else 
        --        Req_N_in <= '0';          
        --    end if;

        --    if (dir_in = North and N2E = '1') and Ce = '1' and E_prime = '1' then
        --        Req_E_in <= '1';           
        --    elsif (dir_in = West and W2E = '1') and Ce = '1' and E_prime = '1' then
        --        Req_E_in <= '1';           
        --    elsif (dir_in = South and S2E = '1') and Ce = '1' and E_prime = '1' then
        --        Req_E_in <= '1';           
        --    elsif (dir_in = Local and L2E = '1') and Ce = '1' and E_prime = '1' then 
        --        Req_E_in <= '1';
        --    else
        --        Req_E_in <= '0';          
        --    end if;
     
        --    if (dir_in = North and N2W = '1') and Cw = '1' and W_prime = '1' then
        --        Req_W_in <= '1';
        --    elsif (dir_in = East and E2W = '1') and Cw = '1' and W_prime = '1' then
        --        Req_W_in <= '1';
        --    elsif (dir_in = South and S2W = '1') and Cw = '1' and W_prime = '1' then
        --        Req_W_in <= '1';
        --    elsif (dir_in = Local and L2W = '1') and Cw = '1' and W_prime = '1' then
        --        Req_W_in <= '1';
        --    else
        --        Req_W_in <= '0';          
        --    end if;

        --    if (dir_in = North and N2S = '1') and Cs = '1' and S_prime = '1' and E_prime = '0' and W_prime = '0' then
        --        Req_S_in <= '1';
        --    elsif (dir_in = East and E2S = '1') and Cs = '1' and S_prime = '1' and E_prime = '0' and W_prime = '0' then
        --        Req_S_in <= '1';
        --    elsif (dir_in = West and W2S = '1') and Cs = '1' and S_prime = '1' and E_prime = '0' and W_prime = '0' then
        --        Req_S_in <= '1';
        --    elsif (dir_in = Local and L2S = '1') and Cs = '1' and S_prime = '1' and E_prime = '0' and W_prime = '0' then
        --        Req_S_in <= '1';
        --    else
        --        Req_S_in <= '0';          
        --    end if;

        --    if ( ( (dir_in = North and N2L = '1') or (dir_in = East and E2L = '1') or (dir_in = West and W2L = '1') or 
        --    (dir_in = South and S2L = '1') ) and Cl = '1' and (N_prime = '0' and E_prime = '0' and W_prime = '0' and S_prime = '0') ) then -- Any LBDR (Except Local itself), Request to Local
        --      Req_L_in <= '1';
        --    else 
        --      Req_L_in <= '0';
        --    end if;

        --else 

        --------------------------------
        -- Flit coming from North input
        --------------------------------
        if (dir_in = North) then 
          if (N_prime = '1' and E_prime = '0' and W_prime = '0') then -- Destination on North direction 
            -- We cannot take North U-Turn, deroute to East, West or South
            if (N2E = '1' and Ce = '1') then 
              Req_E_in <= '1';
            elsif (N2W = '1' and Cw = '1') then
              Req_W_in <= '1';
            elsif (N2S = '1' and Cs = '1') then 
              Req_S_in <= '1';      
            end if;

          elsif (N_prime = '1' and E_prime = '1') then -- Destination on North-East quadrant
            -- We cannot take North U-Turn, deroute to East, West or South
            if (N2E = '1' and Ce = '1') then 
              Req_E_in <= '1';
            elsif (N2W = '1' and Cw = '1') then
              Req_W_in <= '1';
            elsif (N2S = '1' and Cs = '1') then 
              Req_S_in <= '1';      
            end if;

          elsif (E_prime = '1' and N_prime = '0' and S_prime = '0') then -- Destination on East direction
            -- Give priority to East output, if not, deroute to South or West
            if (N2E = '1' and Ce = '1') then 
              Req_E_in <= '1';
            elsif (N2S = '1' and Cs = '1') then
              Req_S_in <= '1';
            elsif (N2W = '1' and Cw = '1') then
              Req_W_in <= '1';
            end if;

          elsif (S_prime = '1' and E_prime = '1') then -- Destination on South-East quadrant
            -- Both East and South can be chosen, if not, deroute to West
            if (N2E = '1' and Ce = '1') then 
              Req_E_in <= '1';
            end if;
            if (N2S = '1' and Cs = '1') then
              Req_S_in <= '1';
            end if;
            if (N2E = '0' or Ce = '0') and (N2S = '0' or Cs = '0') then 
              -- Deroute to West
              if (N2W = '1' and Cw = '1') then 
                Req_W_in <= '1';
              end if;
            end if;

          elsif (S_prime = '1' and E_prime = '0' and W_prime = '0') then -- Destination on South direction
            -- Give priority to South Direction, if not, deroute to East or West
            if (N2S = '1' and Cs = '1') then
              Req_S_in <= '1';
            else
              if (N2E = '1' and Ce = '1') then 
                Req_E_in <= '1';
              end if; 
              if (N2W = '1' and Cw = '1') then 
                Req_W_in <= '1';
              end if;         
            end if;
          
          elsif (S_prime = '1' and W_prime = '1') then -- Destination on South-West quadrant
            -- Both West and South can be chosen, if not, deroute to East
            if (N2W = '1' and Cw = '1') then 
              Req_W_in <= '1';
            end if;
            if (N2S = '1' and Cs = '1') then
              Req_S_in <= '1';
            end if;
            if (N2W = '0' or Cw = '0') and (N2S = '0' or Cs = '0') then 
              -- Deroute to East
              if (N2E = '1' and Ce = '1') then 
                Req_E_in <= '1';
              end if;
            end if;

          elsif (W_prime = '1' and N_prime = '0' and S_prime = '0') then -- Destination on West direction
            -- Give priority to West output, if not, deroute to South or East
            if (N2W = '1' and Cw = '1') then 
              Req_W_in <= '1';
            elsif (N2S = '1' and Cs = '1') then
              Req_S_in <= '1';
            elsif (N2E = '1' and Ce = '1') then
              Req_E_in <= '1';
            end if;

          elsif (N_prime = '1' and W_prime = '1') then -- Destination on North-West quadrant
            -- We cannot take North U-Turn, deroute to West, East or South
            if (N2W = '1' and Cw = '1') then
              Req_W_in <= '1';
            elsif (N2E = '1' and Ce = '1') then 
              Req_E_in <= '1';
            elsif (N2S = '1' and Cs = '1') then 
              Req_S_in <= '1';      
            end if;

          elsif (cur_addr = dst_addr and N_prime = '0' and E_prime = '0' and W_prime = '0' and S_prime = '0' and Cl = '1') then -- Destination is current node
            -- Eject flit to destination node
            Req_L_in <= '1';
          end if; 

        --------------------------------
        -- Flit coming from East input
        --------------------------------
        elsif (dir_in = East) then
          if (N_prime = '1' and E_prime = '0' and W_prime = '0') then -- Destination on North direction
            -- Give priority to North, if not, deroute to West or South
            if (E2N = '1' and Cn = '1') then 
              Req_N_in <= '1';
            elsif (E2W = '1' and Cw = '1') then
              Req_W_in <= '1';
            elsif (E2S = '1' and Cs = '1') then
              Req_S_in <= '1';
            end if;

          elsif (N_prime = '1' and E_prime = '1') then -- Destination on North-East quadrant
            -- U-turn on East not possible, so send to North, if not, deroute to West or South
            if (E2N = '1' and Cn = '1') then 
              Req_N_in <= '1';
            elsif (E2W = '1' and Cw = '1') then
              Req_W_in <= '1';
            elsif (E2S = '1' and Cs = '1') then
              Req_S_in <= '1';
            end if;

          elsif (E_prime = '1' and N_prime = '0' and S_prime = '0') then -- Destination on East direction
            -- U-turn on East not possible, so deroute to North or South, if not, deroute to West
            if (E2N = '1' and Cn = '1') then 
              Req_N_in <= '1';
            end if;
            if (E2S = '1' and Cs = '1') then
              Req_S_in <= '1';
            end if;
            if (E2N = '0' or Cn = '0') and (E2S = '0' or Cs = '0') and (E2W = '1' and Cw = '1') then
              Req_W_in <= '1';
            end if;

          elsif (S_prime = '1' and E_prime = '1') then -- Destination on South-East quadrant
            -- U-turn on East not possible, give priority to South, if not, deroute to West or North
            if (E2S = '1' and Cs = '1') then 
              Req_S_in <= '1';
            else
              if (E2W = '1' and Cw = '1') then
                Req_W_in <= '1';
              end if;
              if (E2N = '1' and Cn = '1') then
                Req_N_in <= '1';
              end if;
            end if;

          elsif (S_prime = '1' and E_prime = '0' and W_prime = '0') then -- Destination on South direction
            -- Give priority to South, if not, deroute to West, if not, then deroute to North
            if (E2S = '1' and Cs = '1') then 
              Req_S_in <= '1';
            elsif (E2W = '1' and Cw = '1') then
              Req_W_in <= '1';
            elsif (E2N = '1' and Cn = '1') then
              Req_N_in <= '1';
            end if;

          elsif (S_prime = '1' and W_prime = '1') then -- Destination on South-West quadrant
            -- Send to West or South, if both not possible, deroute to North
            if (E2S = '1' and Cs = '1') then 
              Req_S_in <= '1';
            end if;
            if (E2W = '1' and Cw = '1') then
              Req_W_in <= '1';
            end if;
            if (E2S = '0' or Cs = '0') and (E2W = '0' or Cw = '0') and (E2N = '1' and Cn = '1') then
              Req_N_in <= '1';
            end if;

          elsif (W_prime = '1' and N_prime = '0' and S_prime = '0') then -- Destination on West direction
            -- Give priority to West, if not, deroute to North or South
            if (E2W = '1' and Cw = '1') then 
              Req_W_in <= '1';
            else
              if (E2N = '1' and Cn = '1') then
                Req_N_in <= '1';
              end if;
              if (E2S = '1' and Cs = '1') then
                Req_S_in <= '1';
              end if;
            end if;

          elsif (N_prime = '1' and W_prime = '1') then -- Destination on North-West quadrant
            -- Both West and North can be chosen, if not, deroute to South
            if (E2N = '1' and Cn = '1') then 
              Req_N_in <= '1';
            end if;
            if (E2W = '1' and Cw = '1') then 
              Req_W_in <= '1';
            end if;
            if (E2N = '0' or Cn = '0') and (E2W = '0' or Cw = '0') and (E2S = '1' and Cs = '1') then
              Req_S_in <= '1';
            end if;

          elsif (cur_addr = dst_addr and N_prime = '0' and E_prime = '0' and W_prime = '0' and S_prime = '0' and Cl = '1') then -- Destination is current node
            -- Eject flit to destination node
            Req_L_in <= '1';
          end if; 

        --------------------------------
        -- Flit coming from West input
        --------------------------------
        elsif (dir_in = West) then
          if (N_prime = '1' and E_prime = '0' and W_prime = '0') then -- Destination on North direction
            -- Give priority to North, if not, deroute to East or South
            if (W2N = '1' and Cn = '1') then 
              Req_N_in <= '1';
            elsif (W2E = '1' and Ce = '1') then
              Req_E_in <= '1';
            elsif (W2S = '1' and Cs = '1') then
              Req_S_in <= '1';
            end if;

          elsif (N_prime = '1' and E_prime = '1') then -- Destination on North-East quadrant
            -- Send to North or East, if not, deroute to South
            if (W2N = '1' and Cn = '1') then 
              Req_N_in <= '1';
            end if;
            if (W2E = '1' and Ce = '1') then
              Req_E_in <= '1';
            end if;
            if (W2N = '0' or Cn = '0') and (W2E = '0' or Ce = '0') and (W2S = '1' and Cs = '1') then 
              Req_S_in <= '1';
            end if;

          elsif (E_prime = '1' and N_prime = '0' and S_prime = '0') then -- Destination on East direction
            -- Give priority to East, if not, deroute to North or South
            if (W2E = '1' and Ce = '1') then
              Req_E_in <= '1';
            else
              if (W2N = '1' and Cn = '1') then 
                Req_N_in <= '1';
              end if;
              if (W2S = '1' and Cs = '1') then
                Req_S_in <= '1';
              end if;     
            end if;   

          elsif (S_prime = '1' and E_prime = '1') then -- Destination on South-East quadrant
            -- Send to East or South, if not, deroute to North
            if (W2E = '1' and Ce = '1') then 
              Req_E_in <= '1';
            end if;
            if (W2S = '1' and Cs = '1') then
              Req_S_in <= '1';
            end if;
            if (W2E = '0' or Ce = '0') and (W2S = '0' or Cs = '0') and (W2N = '1' and Cn = '1') then 
              Req_N_in <= '1';
            end if;   

          elsif (S_prime = '1' and E_prime = '0' and W_prime = '0') then -- Destination on South direction
            -- give priority to South, if not, deroute to East, if not, then deroute to North
            if (W2S = '1' and Cs = '1') then 
              Req_S_in <= '1';
            elsif (W2E = '1' and Ce = '1') then
              Req_E_in <= '1';
            elsif (W2N = '1' and Cn = '1') then
              Req_N_in <= '1';
            end if;

          elsif (S_prime = '1' and W_prime = '1') then -- Destination on South-West quadrant
            -- U-turn on West not possible, send to South, if not, deroute to East or North
            if (W2S = '1' and Cs = '1') then 
              Req_S_in <= '1';
            else 
              if (W2E = '1' and Ce = '1') then
                Req_E_in <= '1';
              end if;
              if (W2N = '1' and Cn = '1') then
                Req_N_in <= '1';
              end if;
            end if;   

          elsif (W_prime = '1' and N_prime = '0' and S_prime = '0') then -- Destination on West direction
            -- U-Turn on West not possible, deroute to North or South, if not, then deroute to East
              if (W2N = '1' and Cn = '1') then
                Req_N_in <= '1';
              end if;
              if (W2S = '1' and Cs = '1') then
                Req_S_in <= '1';
              end if;
              if (W2N = '0' or Cn = '0') and (W2S = '0' or Cs = '0') and (W2E = '1' and Ce = '1') then 
                Req_E_in <= '1';
              end if;

          elsif (N_prime = '1' and W_prime = '1') then -- Destination on North-West quadrant
            -- U-Turn on West not possible, send to North, if not, deroute to East or South
            if (W2N = '1' and Cn = '1') then 
              Req_N_in <= '1';
            else 
              if (W2E = '1' and Ce = '1') then
                Req_E_in <= '1';
              end if;
              if (W2S = '1' and Cs = '1') then
                Req_S_in <= '1';
              end if;
            end if;   

          elsif (cur_addr = dst_addr and N_prime = '0' and E_prime = '0' and W_prime = '0' and S_prime = '0' and Cl = '1') then -- Destination is current node
            -- Eject flit to destination node
            Req_L_in <= '1';
          end if; 

        --------------------------------
        -- Flit coming from South input
        --------------------------------
        elsif (dir_in = South) then
          if (N_prime = '1' and E_prime = '0' and W_prime = '0') then -- Destination on North direction
            -- Send to North, if not, deroute to East or West
            if (S2N = '1' and Cn = '1') then 
              Req_N_in <= '1';
            else 
              if (S2E = '1' and Ce = '1') then
                Req_E_in <= '1';
              end if;
              if (S2W = '1' and Cw = '1') then
                Req_W_in <= '1';
              end if;     
            end if;

          elsif (N_prime = '1' and E_prime = '1') then -- Destination on North-East quadrant
            -- Send to North or East, if not, deroute to West
            if (S2N = '1' and Cn = '1') then 
              Req_N_in <= '1';
            end if;
            if (S2E = '1' and Ce = '1') then 
              Req_E_in <= '1';
            end if;
            if (S2N = '0' or Cn = '0') and (S2E = '0' or Ce = '0') and (S2W = '1' and Cw = '1') then
              Req_W_in <= '1';      
            end if;

          elsif (E_prime = '1' and N_prime = '0' and S_prime = '0') then -- Destination on East direction
            -- Give priority to East, if not, deroute to North, if not, deroute to West
            if (S2E = '1' and Ce = '1') then 
              Req_E_in <= '1';
            elsif (S2N = '1' and Cn = '1') then 
              Req_N_in <= '1';
            elsif (S2W = '1' and Cw = '1') then
              Req_W_in <= '1';            
            end if;

          elsif (S_prime = '1' and E_prime = '1') then -- Destination on South-East quadrant
            -- U-turn on South not possible, send to East, if not, deroute to North or West
            if (S2E = '1' and Ce = '1') then 
              Req_E_in <= '1';
            else
              if (S2N = '1' and Cn = '1') then 
                Req_N_in <= '1';
              end if;
              if (S2W = '1' and Cw = '1') then
                Req_W_in <= '1';
              end if;                 
            end if; 

          elsif (S_prime = '1' and E_prime = '0' and W_prime = '0') then -- Destination on South direction
            -- U-turn on South not possible, deroute to East or West, if not, deroute to North
            if (S2E = '1' and Ce = '1') then 
              Req_E_in <= '1';
            end if;
            if (S2W = '1' and Cw = '1') then 
              Req_W_in <= '1';
            end if;
            if (S2E = '0' or Ce = '0') and (S2W = '0' or Cw = '0') and (S2N = '1' and Cn = '1') then
              Req_N_in <= '1';
            end if; 

          elsif (S_prime = '1' and W_prime = '1') then -- Destination on South-West quadrant
            -- U-turn on South not possible, send to West, if not, deroute to North or East
            if (S2W = '1' and Cw = '1') then 
              Req_W_in <= '1';
            else 
              if (S2N = '1' and Cn = '1') then 
                Req_N_in <= '1';
              end if;
              if (S2E = '1' and Ce = '1') then
                Req_E_in <= '1';
              end if;                     
            end if;

          elsif (W_prime = '1' and N_prime = '0' and S_prime = '0') then -- Destination on West direction
            -- Give priority to West, if not, deroute to North, if not, deroute to East
            if (S2W = '1' and Cw = '1') then 
              Req_W_in <= '1';
            elsif (S2N = '1' and Cn = '1') then   
              Req_N_in <= '1';
            elsif (S2E = '1' and Ce = '1') then
              Req_E_in <= '1';
            end if;

          elsif (N_prime = '1' and W_prime = '1') then -- Destination on North-West quadrant
            -- Send to North or West, if not, deroute to East
            if (S2N = '1' and Cn = '1') then 
              Req_N_in <= '1';
            end if;
            if (S2W = '1' and Cw = '1') then
              Req_W_in <= '1';    
            end if;
            if (S2N = '0' or Cn = '0') and (S2W = '0' or Cw = '0') and (S2E = '1' and Ce = '1') then
              Req_E_in <= '1';
            end if;

          elsif (cur_addr = dst_addr and N_prime = '0' and E_prime = '0' and W_prime = '0' and S_prime = '0' and Cl = '1') then -- Destination is current node
            -- Eject flit to destination node
            Req_L_in <= '1';
          end if; 

        ---------------------------------------------------------------
        -- Flit coming from Local input (Inject flit from source node)
        -- Current node is the source node.
        ---------------------------------------------------------------
        elsif (dir_in = Local) then
          if (N_prime = '1' and E_prime = '0' and W_prime = '0') then -- Destination on North direction
            -- Give priority to North, if not, deroute to East or West, if not, deroute to South
            if (L2N = '1' and Cn = '1') then 
              Req_N_in <= '1';
            else
              if (L2E = '1' and Ce = '1') then  
                Req_E_in <= '1';
              end if;       
              if (L2W = '1' and Cw = '1') then
                Req_W_in <= '1';
              end if;
              if (L2E = '0' or Ce = '0') and (L2W = '0' or Cw = '0') and (L2S = '0' or Cs = '0') then 
                Req_S_in <= '1';
              end if;
            end if;   

          elsif (N_prime = '1' and E_prime = '1') then -- Destination on North-East quadrant
            -- Send to North or East, if not, deroute to West or South
            if (L2N = '1' and Cn = '1') then 
              Req_N_in <= '1';
            end if;
            if (L2E = '1' and Ce = '1') then  
              Req_E_in <= '1';
            end if;       
            if (L2N = '0' or Cn = '0') and (L2E = '0' or Ce = '0') then
              if (L2W = '1' and Cw = '1') then
                Req_W_in <= '1';
              end if;
              if (L2S = '1' and Cs = '1') then
                Req_S_in <= '1';
              end if;
            end if;

          elsif (E_prime = '1' and N_prime = '0' and S_prime = '0') then -- Destination on East direction
            -- Give priority to East, if not, deroute to North or South, if not, deroute to West
            if (L2E = '1' and Ce = '1') then 
              Req_E_in <= '1';
            else
              if (L2N = '1' and Cn = '1') then
                Req_N_in <= '1';
              end if;
              if (L2S = '1' and Cs = '1') then
                Req_S_in <= '1';
              end if;     
              if (L2N = '0' or Cn = '0') and (L2S = '0' or Cs = '0') and (L2W = '1' and Cw = '1') then
                Req_W_in <= '1';      
              end if; 
            end if;

          elsif (S_prime = '1' and E_prime = '1') then -- Destination on South-East quadrant
            -- Send to South or East, if not, deroute to North or West
            if (L2S = '1' and Cs = '1') then 
              Req_S_in <= '1';
            end if;
            if (L2E = '1' and Ce = '1') then  
              Req_E_in <= '1';
            end if;       
            if (L2S = '0' or Cs = '0') and (L2E = '0' or Ce = '0') then
              if (L2W = '1' and Cw = '1') then
                Req_W_in <= '1';
              end if;
              if (L2N = '1' and Cn = '1') then
                Req_N_in <= '1';
              end if;
            end if;

          elsif (S_prime = '1' and E_prime = '0' and W_prime = '0') then -- Destination on South direction
            -- Give priority to South, if not, deroute to East or West, if not, deroute to North
            if (L2S = '1' and Cs = '1') then 
              Req_S_in <= '1';
            else
              if (L2E = '1' and Ce = '1') then  
                Req_E_in <= '1';
              end if;       
              if (L2W = '1' and Cw = '1') then
                Req_W_in <= '1';
              end if;
              if (L2E = '0' or Ce = '0') and (L2W = '0' or Cw = '0') and (L2N = '0' or Cn = '0') then 
                Req_N_in <= '1';
              end if;
            end if;   

          elsif (S_prime = '1' and W_prime = '1') then -- Destination on South-West quadrant
            -- Send to South or West, if not, deroute to North or East
            if (L2S = '1' and Cs = '1') then 
              Req_S_in <= '1';
            end if;
            if (L2W = '1' and Cw = '1') then  
              Req_W_in <= '1';
            end if;       
            if (L2S = '0' or Cs = '0') and (L2W = '0' or Cw = '0') then
              if (L2E = '1' and Ce = '1') then
                Req_E_in <= '1';
              end if;
              if (L2N = '1' and Cn = '1') then
                Req_N_in <= '1';
              end if;
            end if;

          elsif (W_prime = '1' and N_prime = '0' and S_prime = '0') then -- Destination on West direction
            -- Give priority to West, if not, deroute to North or South, if not, deroute to East
            if (L2W = '1' and Cw = '1') then 
              Req_W_in <= '1';
            else
              if (L2N = '1' and Cn = '1') then
                Req_N_in <= '1';
              end if;
              if (L2S = '1' and Cs = '1') then
                Req_S_in <= '1';
              end if;     
              if (L2N = '0' or Cn = '0') and (L2S = '0' or Cs = '0') and (L2E = '1' and Ce = '1') then
                Req_E_in <= '1';      
              end if; 
            end if;

          elsif (N_prime = '1' and W_prime = '1') then -- Destination on North-West quadrant
            -- Send to North or West, if not, deroute to East or South
            if (L2N = '1' and Cn = '1') then 
              Req_N_in <= '1';
            end if;
            if (L2W = '1' and Cw = '1') then  
              Req_W_in <= '1';
            end if;       
            if (L2N = '0' or Cn = '0') and (L2W = '0' or Cw = '0') then
              if (L2E = '1' and Ce = '1') then
                Req_E_in <= '1';
              end if;
              if (L2S = '1' and Cs = '1') then
                Req_S_in <= '1';
              end if;
            end if;

          -- It is not possible to send from Local input to Local output!
          elsif (cur_addr = dst_addr and N_prime = '0' and E_prime = '0' and W_prime = '0' and S_prime = '0' and Cl = '1') then -- Destination is current node
          --  All output requests must be zero!
            Req_N_in <= '0';
            Req_E_in <= '0';
            Req_W_in <= '0';
            Req_S_in <= '0';
            Req_L_in <= '0';
          end if;           

        end if;
        
        --end if;

  elsif flit_type = "100" and empty = '0' and grants = '1' then
        Req_N_in <= '0';
        Req_E_in <= '0';
        Req_W_in <= '0';
        Req_S_in <= '0';
        Req_L_in <= '0';

  else
        Req_N_in <= Req_N_FF;
        Req_E_in <= Req_E_FF;
        Req_W_in <= Req_W_FF;
        Req_S_in <= Req_S_FF;
        Req_L_in <= Req_L_FF;
  end if;
end process;
   
END;
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
        NoC_size: integer := 4
    );
    port (  reset: in  std_logic;
            clk: in  std_logic;

            Cx_reconf: in std_logic_vector(4 downto 0);
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

  signal Cx, Cx_in:  std_logic_vector(4 downto 0);
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
    Cx <= Cx_reconf;
  elsif clk'event and clk = '1' then
    Rxy <= Rxy_in;
    Req_N_FF <= Req_N_in;
    Req_E_FF <= Req_E_in;
    Req_W_FF <= Req_W_in;
    Req_S_FF <= Req_S_in;
    Req_L_FF <= Req_L_in;
    ReConf_FF_out <= ReConf_FF_in;
    Cx <= Cx_in;
  end if;
  end process;


  -- The combionational part

  grants <= grant_N or grant_E or grant_W or grant_S or grant_L;

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

Cx_in <= Cx;

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
        --Req_N_in <= Cn and ((N1 and N_prime and not E_prime and not W_prime) or (N_prime and not E_prime and not W_prime and S2N) or (N_prime and E_prime and S2E) or (N_prime and W_prime and S2W));
        --Req_E_in <= Ce and ((E1 and E_prime and not N_prime and not S_prime) or (E_prime and not N_prime and not S_prime and W2E) or (E_prime and N_prime and W2N) or (E_prime and S_prime and W2S));
        --Req_W_in <= Cw and ((W1 and W_prime and not N_prime and not S_prime) or (W_prime and not N_prime and not S_prime and E2W) or (W_prime and N_prime and E2N) or (W_prime and S_prime and E2W));
        --Req_S_in <= Cs and ((S1 and S_prime and not E_prime and not W_prime) or (S_prime and not E_prime and not W_prime and N2S) or (S_prime and E_prime and N2E) or (S_prime and W_prime and N2W));
        --Req_L_in <= Cl and (not N_prime and not E_prime and not W_prime and not S_prime and ( (not dir_in(2) and not dir_in(1) and not dir_in(0) and N2L) or (not dir_in(2) and not dir_in(1) and dir_in(0) and E2L) or (not dir_in(2) and dir_in(1) and not dir_in(0) and W2L) or (not dir_in(2) and dir_in(1) and dir_in(0) and S2L) ));
        if (cur_addr_rst /= 15 and cur_addr_rst /= 14 and cur_addr_rst /= 13 and cur_addr_rst /= 9 and cur_addr_rst /= 5 and cur_addr_rst /= 1) then

            if (dir_in = East and E2N = '1') and Cn = '1' and N_prime = '1' and E_prime = '0' and W_prime = '0' then
                Req_N_in <= '1';
            elsif (dir_in = West and W2N = '1') and Cn = '1' and N_prime = '1' and E_prime = '0' and W_prime = '0' then
                Req_N_in <= '1';
            elsif (dir_in = South and S2N = '1') and Cn = '1' and N_prime = '1' and E_prime = '0' and W_prime = '0' then
                Req_N_in <= '1';
            elsif (dir_in = Local and L2N = '1') and Cn = '1' and N_prime = '1' and E_prime = '0' and W_prime = '0' then
                Req_N_in <= '1';
            else
                Req_N_in <= '0';
            end if;


            if (dir_in = North and N2S = '1') and Cs = '1' and S_prime = '1' and E_prime = '0' and W_prime = '0' then
                Req_S_in <= '1';
            elsif (dir_in = East and E2S = '1') and Cs = '1' and S_prime = '1' and E_prime = '0' and W_prime = '0' then
                Req_S_in <= '1';
            elsif (dir_in = West and W2S = '1') and Cs = '1' and S_prime = '1' and E_prime = '0' and W_prime = '0' then
                Req_S_in <= '1';
            elsif (dir_in = Local and L2S = '1') and Cs = '1' and S_prime = '1' and E_prime = '0' and W_prime = '0' then
                Req_S_in <= '1';
            else
                Req_S_in <= '0';
            end if;

        --elsif (cur_addr_rst = 10 ) then

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


        --    if (dir_in = North and N2S = '1') and Cs = '1' and S_prime = '1' and E_prime = '0' and W_prime = '0' then
        --        Req_S_in <= '1';
        --    elsif (dir_in = East and E2S = '1') and Cs = '1' and S_prime = '1' and E_prime = '0' and W_prime = '0' then
        --        Req_S_in <= '1';
        --    elsif (dir_in = West and W2S = '1') and Cs = '1' and S_prime = '1' then
        --        Req_S_in <= '1';
        --    elsif (dir_in = Local and L2S = '1') and Cs = '1' and S_prime = '1' and E_prime = '0' and W_prime = '0' then
        --        Req_S_in <= '1';
        --    else
        --        Req_S_in <= '0';
        --    end if;

        else
            if (dir_in = East and E2N = '1') and Cn = '1' and N_prime = '1' then
                Req_N_in <= '1';
            elsif (dir_in = West and W2N = '1') and Cn = '1' and N_prime = '1' then
                Req_N_in <= '1';
            elsif (dir_in = South and S2N = '1') and Cn = '1' and N_prime = '1' then
                Req_N_in <= '1';
            elsif (dir_in = Local and L2N = '1') and Cn = '1' and N_prime = '1' then
                Req_N_in <= '1';
            else
                Req_N_in <= '0';
            end if;



            if (dir_in = North and N2S = '1') and Cs = '1' and S_prime = '1' then
                Req_S_in <= '1';
            elsif (dir_in = East and E2S = '1') and Cs = '1' and S_prime = '1' then
                Req_S_in <= '1';
            elsif (dir_in = West and W2S = '1') and Cs = '1' and S_prime = '1' then
                Req_S_in <= '1';
            elsif (dir_in = Local and L2S = '1') and Cs = '1' and S_prime = '1' then
                Req_S_in <= '1';
            else
                Req_S_in <= '0';
            end if;

        end if;

        if (dir_in = North and N2E = '1') and Ce = '1' and E_prime = '1' then
                Req_E_in <= '1';
            elsif (dir_in = West and W2E = '1') and Ce = '1' and E_prime = '1' then
                Req_E_in <= '1';
            elsif (dir_in = South and S2E = '1') and Ce = '1' and E_prime = '1' then
                Req_E_in <= '1';
            elsif (dir_in = Local and L2E = '1') and Ce = '1' and E_prime = '1' then
                Req_E_in <= '1';
            else
                Req_E_in <= '0';
            end if;

            if (dir_in = North and N2W = '1') and Cw = '1' and W_prime = '1' then
                Req_W_in <= '1';
            elsif (dir_in = East and E2W = '1') and Cw = '1' and W_prime = '1' then
                Req_W_in <= '1';
            elsif (dir_in = South and S2W = '1') and Cw = '1' and W_prime = '1' then
                Req_W_in <= '1';
            elsif (dir_in = Local and L2W = '1') and Cw = '1' and W_prime = '1' then
                Req_W_in <= '1';
            else
                Req_W_in <= '0';
            end if;

      if ( ( (dir_in = North and N2L = '1') or (dir_in = East and E2L = '1') or (dir_in = West and W2L = '1') or
            (dir_in = South and S2L = '1') ) and Cl = '1' and (N_prime = '0' and E_prime = '0' and W_prime = '0' and S_prime = '0') ) then -- Any LBDR (Except Local itself), Request to Local
              Req_L_in <= '1';
            else
              Req_L_in <= '0';
            end if;

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

--Copyright (C) 2016 Siavoosh Payandeh Azad

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use IEEE.NUMERIC_STD.all;
 use ieee.math_real.all;
 use std.textio.all;
 use ieee.std_logic_misc.all;


package TB_Package is


-- exported constants

	constant clk_period : time := 10 ns;
	constant NoC_size : integer := 4;



-- exported functions

  function Header_gen(source, destination: integer ) return std_logic_vector ;

  function Body_1_gen(Packet_length, packet_id: integer ) return std_logic_vector ;
  function Body_gen(Data: integer ) return std_logic_vector ;

  function Tail_gen(Packet_length, Data: integer ) return std_logic_vector ;



-- exported procedures

  procedure credit_counter_control(	signal clk: in std_logic;
		                              signal credit_in: in std_logic; signal valid_out: in std_logic;
		                              signal credit_counter_out: out std_logic_vector(1 downto 0));


	 procedure gen_crit_packet_n(	network_size, frame_length, source, destination_id, initial_delay, min_packet_size, max_packet_size: in integer;
											finish_time: in time;
											signal clk: in std_logic;
											signal credit_counter_in: in std_logic_vector(1 downto 0); signal valid_out: out std_logic;
											signal port_in: out std_logic_vector;
											seed_1, seed_2: in positive);


	procedure gen_not_crit_packet_n(	network_size, frame_length, source, initial_delay, min_packet_size, max_packet_size: in integer;
												finish_time: in time;
												signal clk: in std_logic;
												signal credit_counter_in: in std_logic_vector(1 downto 0); signal valid_out: out std_logic;
												signal port_in: out std_logic_vector;
												seed_1, seed_2: in positive);



  procedure get_packet(DATA_WIDTH, initial_delay, Node_ID: in integer; signal clk: in std_logic;
                     signal credit_out: out std_logic; signal valid_in: in std_logic; signal port_in: in std_logic_vector);
end TB_Package;












package body TB_Package is

	type t_crit_nodes_array is array (0 to 1) of integer;
	type t_NODE_TYPE is (critical, not_critical);

  constant Header_type : std_logic_vector := "001";
  constant Body_type : std_logic_vector := "010";
  constant Tail_type : std_logic_vector := "100";

  -- this is the max statistic collector is able to process
  constant MAX_PACKETS_PER_NODE : integer := 10000;

  constant Crit_nodes : t_crit_nodes_array := (0, 15);


	--------------------------------------
	----	nominal_time_to_tx_cc_calc  ----
	--------------------------------------
	--
	--	returns cc value
	--
	function nominal_time_to_tx_cc_calc(Packet_length: integer ) return integer is
		variable nominal_time_to_tx_cc: integer := 0;
	begin

		if (Packet_length = 3) then
			nominal_time_to_tx_cc := 4;
		else
			nominal_time_to_tx_cc := 7 + (Packet_length - 4);
		end if;

	return nominal_time_to_tx_cc;
	end function;



	-----------------------------------------
	----	nominal_latency_calc  ----
	--------------------------------
	--
	--	returns cc value
	--
	function nominal_latency_calc(Packet_length, source_id, destination_id : integer ) return integer is
		variable nominal_lat: integer := 0;
		variable source_x: integer := 0;
		variable source_y: integer := 0;
		variable destination_x: integer := 0;
		variable destination_y: integer := 0;
		variable manh_dist: integer := 0;
	begin

	source_x := source_id mod NoC_size;
	source_y := source_id / NoC_size;

	destination_x := destination_id mod NoC_size;
	destination_y := destination_id/NoC_size;

	manh_dist := abs(source_x - destination_x) + abs(source_y - destination_y);

	-- 9,5 CCs <-- 3 flits with a distance of 1
	nominal_lat := (9 + (Packet_length-3)*1 + (manh_dist-1)*3);

	return nominal_lat;
	end function;



	--------------------------------
	----	fIntToStringLeading0  ----
	--------------------------------
	--
	-- Range is limited to from 1 to 9 as 10 digit
	-- integer can already overflow in VHDL
	--
	function fIntToStringLeading0 (a : natural; d : integer range 1 to 9) return string is
	  variable vString : string(1 to d);
	begin
	  if(a >= 10**d) then
		 return integer'image(a);
	  else
		 for i in 0 to d-1 loop
		   vString(d-i to d-i) := integer'image(a/(10**i) mod 10);
		 end loop;
		 return vString;
	  end if;
	end function;





  function Header_gen(source, destination: integer)
              return std_logic_vector is
    	variable Header_flit: std_logic_vector (31 downto 0);
    	begin
    	Header_flit := Header_type &  std_logic_vector(to_unsigned(source, 14)) &
                     std_logic_vector(to_unsigned(destination, 14))  & XOR_REDUCE(Header_type &  std_logic_vector(to_unsigned(source, 14)) &
                     std_logic_vector(to_unsigned(destination, 14)));
    return Header_flit;
  end Header_gen;



  function Body_1_gen(Packet_length, packet_id: integer)
                return std_logic_vector is
    variable Body_flit: std_logic_vector (31 downto 0);
    begin
    Body_flit := Body_type &  std_logic_vector(to_unsigned(Packet_length, 14))&  std_logic_vector(to_unsigned(packet_id, 14)) &
                 XOR_REDUCE(Body_type &  std_logic_vector(to_unsigned(Packet_length, 14))&  std_logic_vector(to_unsigned(packet_id, 14)));
    return Body_flit;
  end Body_1_gen;



  function Body_gen(Data: integer)
                return std_logic_vector is
    variable Body_flit: std_logic_vector (31 downto 0);
    begin
    Body_flit := Body_type &  std_logic_vector(to_unsigned(Data, 28)) & XOR_REDUCE(Body_type & std_logic_vector(to_unsigned(Data, 28)));
    return Body_flit;
  end Body_gen;


  function Tail_gen(Packet_length, Data: integer)
                return std_logic_vector is
    variable Tail_flit: std_logic_vector (31 downto 0);
    begin
    Tail_flit := Tail_type &  std_logic_vector(to_unsigned(Data, 28)) & XOR_REDUCE(Tail_type & std_logic_vector(to_unsigned(Data, 28)));
    return Tail_flit;
  end Tail_gen;







  procedure credit_counter_control(signal clk: in std_logic;
                                   signal credit_in: in std_logic; signal valid_out: in std_logic;
                                   signal credit_counter_out: out std_logic_vector(1 downto 0)) is

    variable credit_counter: std_logic_vector (1 downto 0);

    begin
    credit_counter := "11";

    while true loop
      credit_counter_out<= credit_counter;
      wait until clk'event and clk ='1';
      if valid_out = '1' and credit_in ='1' then
        credit_counter := credit_counter;
      elsif credit_in = '1' then
        credit_counter := credit_counter + 1;
      elsif valid_out = '1' and  credit_counter > 0 then
        credit_counter := credit_counter - 1;
      else
        credit_counter := credit_counter;
      end if;
    end loop;
  end credit_counter_control;







 ----------------------------------------
 --
 --	packet_generator
 --	=================
 --
 --		This procedure is the "generation engine": it's the only procedure to generate the packets.
 --		The "interface procedures" provide the paramiters.
 --
 --

 procedure packet_generator(node_type: in t_NODE_TYPE;
										network_size, frame_length, source, destination_id_in, initial_delay, min_packet_size, max_packet_size: in integer;
						             finish_time: in time;
						             signal clk: in std_logic;
						             signal credit_counter_in: in std_logic_vector(1 downto 0); signal valid_out: out std_logic;
						          	 signal port_in: out std_logic_vector;
						             seed_1, seed_2 : in positive) is

	file VEC_FILE : text is out "sent.txt";
	file TRAFFIC_GENERATION_VERBOSE_FILE : text is out "traffic_generator_verbose.txt";
	file SETTINGS_FILE : text is out "system_settings.txt";

	variable seed_1_var :positive := seed_1+1; -- [1, 2147483562]
	variable seed_2_var :positive := seed_2+1; -- [1, 2147483398]
	variable LINEVARIABLE : line;
	variable rand : real ;
	variable destination_id: integer;
	-- sof = start of frame
	-- eof = end of frame
	variable id_counter, sof_delay, Packet_length, time_to_eof : integer:= 0;
	variable credit_counter: std_logic_vector (1 downto 0);
	variable debug_1: integer:= 0;

	variable packet_nominal_starting_time: time := 0 ns;
	variable packet_actual_starting_time: time := 0 ns;
	variable start_of_frame_time: time := 0 ns;
	variable nominal_end_of_frame_time: time := 0 ns;

	variable nom_latency: integer := 0;
	variable sof_delay_max: integer := 0;

  variable valid_dest: boolean;

    begin

--   uniform(seed_1_var, seed_2_var, rand);
--    Packet_length := integer((integer(rand*100.0)*max_packet_size)/100);
    valid_out <= '0';
    port_in <= "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX" ;
    wait until clk'event and clk ='1';
    for i in 0 to initial_delay loop
      wait until clk'event and clk ='1';
    end loop;
    port_in <= "UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU" ;


	write(LINEVARIABLE, 		"node_id: " & 					fIntToStringLeading0(source, 2) &
									";  frame_length = " &		integer'image(frame_length) &
									";  initial_delay = " & 	fIntToStringLeading0(initial_delay, 3) &
									";  min_packet_size = " &	fIntToStringLeading0(min_packet_size, 3) &
									";  max_packet_size = " & 	fIntToStringLeading0(max_packet_size, 3) & LF);
   writeline(SETTINGS_FILE, LINEVARIABLE);


    while true loop

     start_of_frame_time := now;
     nominal_end_of_frame_time := start_of_frame_time + frame_length*clk_period;

      valid_out <= '0';

      ------------
      --
      -- packet generation: the transmissing schedule is done without considering the actual possibility to start transmissing
      --

       id_counter := id_counter + 1;
		-- the statistic collector proccesses up to MAX_PACKETS_PER_NODE
     assert (id_counter<=MAX_PACKETS_PER_NODE) report "id_counter value is too hight (not supported by the statistical extractor) " severity failure;
      --------------------------------------
      uniform(seed_1_var, seed_2_var, rand);
      Packet_length := integer((integer(rand*100.0)*max_packet_size)/100);
      if (Packet_length < min_packet_size) then
          Packet_length:=min_packet_size;
      end if;
      if (Packet_length > max_packet_size) then
          Packet_length:=max_packet_size;
      end if;
      --------------------------------------



      if (node_type = critical) then -- critical
      	destination_id := destination_id_in;
      elsif (node_type = not_critical) then -- not critical
			uniform(seed_1_var, seed_2_var, rand);
			destination_id := integer(rand*real((network_size**2)-1));
      valid_dest := False;
			while ( valid_dest = False) loop
				 uniform(seed_1_var, seed_2_var, rand);
				 destination_id := integer(rand*real((network_size**2)-1));
         valid_dest:= True;

         if source = destination_id then
             valid_dest:= False;
         elsif destination_id = Crit_nodes(0) then
           valid_dest:= False;
         elsif destination_id = Crit_nodes(1) then
           valid_dest:= False;
         end if;

         if source = 4 and destination_id = 1 then
           valid_dest:= False;
         elsif source = 4 and destination_id = 2 then
           valid_dest:= False;
         elsif source = 4 and destination_id = 3 then
           valid_dest:= False;
         elsif source = 5 and destination_id = 1 then
           valid_dest:= False;
         elsif source = 5 and destination_id = 2 then
           valid_dest:= False;
         elsif source = 5 and destination_id = 3 then
           valid_dest:= False;
         elsif source = 8 and destination_id = 1 then
           valid_dest:= False;
         elsif source = 8 and destination_id = 2 then
           valid_dest:= False;
         elsif source = 8 and destination_id = 3 then
           valid_dest:= False;
         elsif source = 9 and destination_id = 1 then
           valid_dest:= False;
         elsif source = 9 and destination_id = 2 then
           valid_dest:= False;
         elsif source = 9 and destination_id = 3 then
           valid_dest:= False;
         elsif source = 9 and destination_id = 4 then
           valid_dest:= False;
         elsif source = 9 and destination_id = 5 then
           valid_dest:= False;
         elsif source = 9 and destination_id = 6 then
           valid_dest:= False;
         elsif source = 9 and destination_id = 7 then
           valid_dest:= False;
         elsif source = 12 and destination_id = 1 then
           valid_dest:= False;
         elsif source = 12 and destination_id = 2 then
           valid_dest:= False;
         elsif source = 12 and destination_id = 3 then
           valid_dest:= False;
         elsif source = 13 and destination_id = 1 then
           valid_dest:= False;
         elsif source = 13 and destination_id = 2 then
           valid_dest:= False;
         elsif source = 13 and destination_id = 3 then
           valid_dest:= False;
         elsif source = 13 and destination_id = 4 then
           valid_dest:= False;
         elsif source = 13 and destination_id = 5 then
           valid_dest:= False;
         elsif source = 13 and destination_id = 6 then
           valid_dest:= False;
         elsif source = 13 and destination_id = 7 then
           valid_dest:= False;
         elsif source = 13 and destination_id = 8 then
           valid_dest:= False;
         elsif source = 13 and destination_id = 9 then
           valid_dest:= False;
         elsif source = 13 and destination_id = 10 then
           valid_dest:= False;
         elsif source = 13 and destination_id = 11 then
           valid_dest:= False;
         elsif source = 13 and destination_id = 14 then
           valid_dest:= False;
         end if;

			end loop;
		end if;
      --------------------------------------


       --generating the frame initial delay
      nom_latency := nominal_latency_calc(Packet_length, destination_id, source);
      sof_delay_max := frame_length - nom_latency;

      uniform(seed_1_var, seed_2_var, rand);
      sof_delay := integer( ( (integer(rand*100.0))*(sof_delay_max) ) /100); -- !!! it's possible {sof_delay = 0} !!!

     assert (sof_delay>=0) report "ERROR: negative sof_delay" severity failure;
--      write(LINEVARIABLE, "From " & integer'image(source) &
--      							" Packet_length: " & integer'image(Packet_length) &
--      							" sof_delay: " & integer'image(sof_delay) &
--      							" nom_latency: " & integer'image(nom_latency));
--      writeline(TRAFFIC_GENERATION_VERBOSE_FILE, LINEVARIABLE);

      --generating the frame ending delay
      time_to_eof := frame_length - (Packet_length+sof_delay);

      packet_nominal_starting_time := now + sof_delay*clk_period;


      for k in 0 to sof_delay-1 loop
          wait until clk'event and clk ='0';
      end loop;


      --------
      --
      --	wait until the transmission is possible
      --

      while credit_counter_in = 0 loop
        wait until clk'event and clk ='0';
      end loop;

      packet_actual_starting_time := now;


      wait until clk'event and clk ='0'; -- On negative edge of clk (for syncing purposes)
      port_in <= Header_gen(source, destination_id); -- Generating the header flit of the packet (All packets have a header flit)!
      valid_out <= '1';
      wait until clk'event and clk ='0';

      for I in 0 to Packet_length-3 loop
            -- The reason for -3 is that we have packet length of Packet_length, now if you exclude header and tail
            -- it would be Packet_length-2 to enumerate them, you can count from 0 to Packet_length-3.
            if credit_counter_in = "00" then
             valid_out <= '0';
             -- Wait until next router/NI has at least enough space for one flit in its input FIFO
             wait until credit_counter_in'event and credit_counter_in > 0;
             wait until clk'event and clk ='0';
            end if;

            uniform(seed_1_var, seed_2_var, rand);
            -- Each packet can have no body flits or one or more than body flits.
            if I = 0 then
              port_in <= Body_1_gen(Packet_length, id_counter);
            else
              port_in <= Body_gen(integer(rand*1000.0));
            end if;
             valid_out <= '1';
             wait until clk'event and clk ='0';
      end loop;

      if credit_counter_in = "00" then
             valid_out <= '0';
             -- Wait until next router/NI has at least enough space for one flit in its input FIFO
             wait until credit_counter_in'event and credit_counter_in > 0;
             wait until clk'event and clk ='0';
      end if;


      uniform(seed_1_var, seed_2_var, rand);
      -- Close the packet with a tail flit (All packets have one tail flit)!
      port_in <= Tail_gen(Packet_length, integer(rand*1000.0));
      valid_out <= '1';
      wait until clk'event and clk ='0';



      -- just completed the transmission... it's time to log :)

      -- transmitted log file
		write(LINEVARIABLE,
									" packet_nominal_starting_time: " & time'image(packet_nominal_starting_time) &
      							" packet_actual_starting_time: " & time'image(packet_actual_starting_time) &
      							" packet_end_transmission_time: " & time'image(now) &
      							" start_of_frame_time: " & time'image(start_of_frame_time) &
      							" nominal_end_of_frame_time: " & time'image(nominal_end_of_frame_time) &
									" From " & integer'image(source) & " to " & integer'image(destination_id) &
									" length: " & integer'image(Packet_length) &
									" id: " & integer'image(id_counter));
		writeline(VEC_FILE, LINEVARIABLE);

      -- verbose transmitted log file
--      write(LINEVARIABLE,	" packet_nominal_starting_time: " & time'image(packet_nominal_starting_time) &
--      							" packet_actual_starting_time: " & time'image(packet_actual_starting_time) &
--      							" packet_end_transmission_time: " & time'image(now) &
--      							" start_of_frame_time: " & time'image(start_of_frame_time) &
--      							" nominal_end_of_frame_time: " & time'image(nominal_end_of_frame_time) &
--      							" From " & integer'image(source) & " to " & integer'image(destination_id) &
--      							" length: " & integer'image(Packet_length) &
--      							" id: " &integer'image(id_counter) &
--      							" sof_delay: " & integer'image(sof_delay) &
--      							" time_to_eof: " & integer'image(time_to_eof));
--      writeline(TRAFFIC_GENERATION_VERBOSE_FILE, LINEVARIABLE);


      valid_out <= '0';
      port_in <= "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ" ;

      for l in 0 to time_to_eof-1 loop
         wait until clk'event and clk ='0';
      end loop;
      port_in <= "UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU" ;

      if now > finish_time then
          wait;
      end if;
    end loop;

 end packet_generator;




 procedure gen_crit_packet_n(network_size, frame_length, source, destination_id, initial_delay, min_packet_size, max_packet_size: in integer;
				             finish_time: in time;
				             signal clk: in std_logic;
				             signal credit_counter_in: in std_logic_vector(1 downto 0); signal valid_out: out std_logic;
				          	 signal port_in: out std_logic_vector;
				             seed_1, seed_2 : in positive) is

				             variable node_type: t_NODE_TYPE;

				             begin

				             node_type := critical;


				             packet_generator(node_type,
				             						network_size, frame_length, source, destination_id, initial_delay, min_packet_size, max_packet_size, finish_time,
				             						clk, credit_counter_in, valid_out, port_in, seed_1, seed_2);

 end gen_crit_packet_n;




procedure gen_not_crit_packet_n(network_size, frame_length, source, initial_delay, min_packet_size, max_packet_size: in integer;
			             finish_time: in time;
			             signal clk: in std_logic;
			             signal credit_counter_in: in std_logic_vector(1 downto 0); signal valid_out: out std_logic;
			          	 signal port_in: out std_logic_vector;
			             seed_1, seed_2 : in positive) is

			             variable node_type: t_NODE_TYPE;
			             variable destination_id: integer; -- dummy var

			             begin

			             node_type := not_critical;
			             destination_id := source; -- dummy var

			             packet_generator(node_type,
			             						network_size, frame_length, source, destination_id, initial_delay, min_packet_size, max_packet_size, finish_time,
			             						clk, credit_counter_in, valid_out, port_in, seed_1, seed_2);

 end gen_not_crit_packet_n;






  procedure get_packet(DATA_WIDTH, initial_delay, Node_ID: in integer; signal clk: in std_logic;
                       signal credit_out: out std_logic; signal valid_in: in std_logic; signal port_in: in std_logic_vector) is
  -- initial_delay: waits for this number of clock cycles before sending the packet!
    variable source_node, destination_node, P_length, packet_id, counter: integer;
    variable LINEVARIABLE : line;
     file VEC_FILE : text is out "received.txt";
     file DIAGNOSIS_FILE : text is out "DIAGNOSIS.txt";
     variable DIAGNOSIS: std_logic;
     variable DIAGNOSIS_vector: std_logic_vector(12 downto 0);
     begin
     credit_out <= '1';
     counter := 0;
     while true loop

         wait until clk'event and clk ='1';

         if valid_in = '1' then
              if (port_in(DATA_WIDTH-1 downto DATA_WIDTH-3) = "001") then
                counter := 1;
                DIAGNOSIS := '0';
                source_node := to_integer(unsigned(port_in(28 downto 15)));
                destination_node := to_integer(unsigned(port_in(14 downto 1)));

            end if;
            if  (port_in(DATA_WIDTH-1 downto DATA_WIDTH-3) = "010")   then
               --report "flit type: " &integer'image(to_integer(unsigned(port_in(DATA_WIDTH-1 downto DATA_WIDTH-3)))) ;
               --report  "counter: " & integer'image(counter);
               if counter = 1 then
                  P_length := to_integer(unsigned(port_in(28 downto 15)));
                  packet_id := to_integer(unsigned(port_in(14 downto 1)));
               end if;
               counter := counter+1;
               if port_in(28 downto 13) = "0100011001000100" then
                  DIAGNOSIS := '1';
                  DIAGNOSIS_vector(11 downto 0) := port_in(12 downto 1);
               end if;
            end if;
            if (port_in(DATA_WIDTH-1 downto DATA_WIDTH-3) = "100") then
                counter := counter+1;
              report	"Node: " & integer'image(Node_ID) &
							" Packet received at " & time'image(now) &
							" From " & integer'image(source_node) &
							" to " & integer'image(destination_node) &
							" with length: "& integer'image(P_length) &
							" counter: "& integer'image(counter);
              assert (P_length=counter) report "wrong packet size" severity failure;
              assert (Node_ID=destination_node) report "wrong packet destination " severity failure;
              if DIAGNOSIS = '1' then
                DIAGNOSIS_vector(12) := port_in(28);
                write(LINEVARIABLE, "Packet received at " & time'image(now) &
                							" From: " & integer'image(source_node) &
                							" to: " & integer'image(destination_node) &
                							" length: "& integer'image(P_length) &
                							" actual length: "& integer'image(counter)  &
                							" id: "& integer'image(packet_id));
                writeline(DIAGNOSIS_FILE, LINEVARIABLE);
              else
                write(LINEVARIABLE, "Packet received at " & time'image(now) &
                							" From: " & integer'image(source_node) &
                							" to: " & integer'image(destination_node) &
                							" length: "& integer'image(P_length) &
                							" actual length: "& integer'image(counter)  &
                							" id: "& integer'image(packet_id));
                writeline(VEC_FILE, LINEVARIABLE);
              end if;
               counter := 0;
            end if;
         end if;

     end loop;
  end get_packet;

end TB_Package;

library ieee;
use ieee.std_logic_1164.all;

entity tb_secure_car_key is
end tb_secure_car_key;

architecture testbench of tb_secure_car_key is
  constant c_CLK_PERIOD : time := 10 ns; 
  signal w_CLK, w_A, w_R : std_logic := '0'; 

begin 
  DUT : entity work.secure_car_key
  port map ( i_CLK => w_CLK,
             i_A   => w_A,
             o_R   => w_R );
  process
  begin
      w_CLK <= '0';
      wait for c_CLK_PERIOD / 2;
      w_CLK <= '1';
      wait for c_CLK_PERIOD / 2;
  end process;
  
  process
  begin
	 for i in 1 to 2 loop
	   w_A   <= '0';
		wait for c_CLK_PERIOD;
		assert(w_R = '0') report "Unexpected output in WAIT state" severity error;

		w_A <= '1';
		wait for c_CLK_PERIOD;
		assert(w_R = '1') report "Unexpected output in K1 state" severity error;

		w_A <= '0';
		wait for c_CLK_PERIOD;
		assert(w_R = '1') report "Unexpected output in K2 state" severity error;
		
		w_A <= '1';
		wait for c_CLK_PERIOD;
		assert(w_R = '0') report "Unexpected output in K3 state" severity error;
		 
		w_A <= '1';
		wait for c_CLK_PERIOD;
		assert(w_R = '1') report "Unexpected output in K4 state" severity error;
		 
		w_A <= '0';
		wait for c_CLK_PERIOD;
		assert(w_R = '0') report "Unexpected output in WAIT state" severity error;
	 end loop;	 
    wait;
  end process;
end testbench;
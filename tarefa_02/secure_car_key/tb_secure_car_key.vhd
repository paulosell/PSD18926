library ieee;
use ieee.std_logic_1164.all;

entity tb_secure_car_key is
end tb_secure_car_key;

architecture testbench of tb_secure_car_key is
  constant CLK_PERIOD : time := 10 ns; 

  signal i_CLK, i_A, o_R : std_logic := '0'; 

begin 
  DUT : entity work.secure_car_key
  port map ( i_CLK => i_CLK,
             i_A   => i_A,
             o_R   => o_R );
  -- Clock process
  process
  begin
    while now < 1000 ns loop 
      i_CLK <= '0';
      wait for CLK_PERIOD / 2;
      i_CLK <= '1';
      wait for CLK_PERIOD / 2;
    end loop;
    wait;
  end process;
  
  -- Activation process
  process
  begin
    i_A <= '0';
    wait for 5 ns; 
    i_A <= '1';
	 wait for 5 ns; 
	 i_A <= '0';
	 wait for 5 ns; 
    i_A <= '1';
	 wait for 5 ns; 
	 i_A <= '0';
	 wait for 30 ns; 
    i_A <= '1';
	 wait for 10 ns; 
	 i_A <= '0';
    wait;
  end process;
  
  -- Stimulus process
  process
  begin
	 assert o_R = '0' report "Unexpected output in WAIT state" severity error;
	 wait until (i_A = '1');
    wait until rising_edge(i_CLK);
	 assert o_R = '1' report "Unexpected output in K1 state" severity error;
	 wait until rising_edge(i_CLK);
	 assert o_R = '1' report "Unexpected output in K2 state" severity error;
	 wait until rising_edge(i_CLK);
	 assert o_R = '0' report "Unexpected output in K3 state" severity error;
	 wait until rising_edge(i_CLK);
	 assert o_R = '1' report "Unexpected output in K4 state" severity error;
	 wait until rising_edge(i_CLK);
	 assert o_R = '0' report "Unexpected output in WAIT state" severity error;
    wait;
  end process;
end testbench;
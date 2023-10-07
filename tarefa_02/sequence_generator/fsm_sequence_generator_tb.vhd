library ieee;
use ieee.std_logic_1164.all;

entity tb_fsm_sequence_generator is
end tb_fsm_sequence_generator;

architecture testbench of tb_fsm_sequence_generator is
  constant CLK_PERIOD : time := 10 ns; 

  signal i_CLK : std_logic := '0'; 
  signal i_RST : std_logic := '0'; 
  signal o_Z : std_logic_vector(3 downto 0);

begin
   DUT : entity work.fsm_sequence_generator
   port map ( i_CLK => i_CLK,
              i_RST => i_RST,
              o_Z  => o_Z );

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

  -- Reset process
  process
  begin
    i_RST <= '1';
    wait for 20 ns; -- Apply reset for 20 ns
    i_RST <= '0';
	 wait for 10 ns; 
	 i_RST <= '1';
	 wait for 5 ns;  -- Apply reset for 5 ns
	 i_RST <= '0';
	 wait for 15 ns; 
	 i_RST <= '1';
	 wait for 5 ns;  -- Apply reset for 5 ns
	 i_RST <= '0';
	 wait for 25 ns;
	 i_RST <= '1';
	 wait for 5 ns;  -- Apply reset for 5 ns
	 i_RST <= '0';
    wait;
  end process;

  -- Stimulus process
  process
  begin
    for i in 1 to 4 loop
      wait until rising_edge(i_CLK);
      assert o_Z = "0001" report "Unexpected output in A state" severity error;
      wait until rising_edge(i_CLK);
      assert o_Z = "0011" report "Unexpected output in B state" severity error;
      wait until rising_edge(i_CLK);
      assert o_Z = "1100" report "Unexpected output in C state" severity error;
      wait until rising_edge(i_CLK);
      assert o_Z = "1000" report "Unexpected output in D state" severity error;
    end loop;
    wait;
  end process;

end testbench;

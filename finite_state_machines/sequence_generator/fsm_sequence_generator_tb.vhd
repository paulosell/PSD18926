library ieee;
use ieee.std_logic_1164.all;

entity tb_fsm_sequence_generator is
end tb_fsm_sequence_generator;

architecture testbench of tb_fsm_sequence_generator is
  constant c_CLK_PERIOD : time := 10 ns; 

  signal w_CLK : std_logic := '0'; 
  signal w_RST : std_logic := '0'; 
  signal w_Z : std_logic_vector(3 downto 0);

begin
   DUT : entity work.fsm_sequence_generator
   port map ( i_CLK => w_CLK,
              i_RST => w_RST,
              o_Z  => w_Z );
				  
  process
  begin
      w_CLK <= '0';
      wait for c_CLK_PERIOD / 2;
      w_CLK <= '1';
      wait for c_CLK_PERIOD / 2;
  end process;

 
  process
  begin

    w_RST <= '1';
    wait for c_CLK_PERIOD;
    assert(w_Z = "0001") report "Unexpected output in A state" severity error;

    w_RST <= '0';
    wait for c_CLK_PERIOD;
    assert(w_Z = "0011") report "Unexpected output in B state" severity error;
	 
	 w_RST <= '1';
	 wait for c_CLK_PERIOD;
	 assert(w_Z = "0001") report "Unexpected output in A state" severity error;
	     
	 w_RST <= '0';
    wait for c_CLK_PERIOD;
    assert(w_Z = "0011") report "Unexpected output in B state" severity error;
	 
	 wait for c_CLK_PERIOD;
	 assert(w_Z = "1100") report "Unexpected output in C state" severity error;
	 
	 w_RST <= '1';
	 wait for c_CLK_PERIOD;
	 assert(w_Z = "0001") report "Unexpected output in A state" severity error;
	 
	 w_RST <= '0';
    wait for c_CLK_PERIOD;
    assert(w_Z = "0011") report "Unexpected output in B state" severity error;
	 
	 wait for c_CLK_PERIOD;
	 assert(w_Z = "1100") report "Unexpected output in C state" severity error;
	 
	 wait for c_CLK_PERIOD;
	 assert(w_Z = "1000") report "Unexpected output in D state" severity error;
	 
	 w_RST <= '1';
	 wait for c_CLK_PERIOD;
	 assert(w_Z = "0001") report "Unexpected output in A state" severity error;
	 
	 w_RST <= '0';
	 wait for c_CLK_PERIOD;
    assert(w_Z = "0011") report "Unexpected output in B state" severity error;
	 
	 wait for c_CLK_PERIOD;
	 assert(w_Z = "1100") report "Unexpected output in C state" severity error;
	 
	 wait for c_CLK_PERIOD;
	 assert(w_Z = "1000") report "Unexpected output in D state" severity error;	 
	 wait;
	 	

  end process;
end testbench;

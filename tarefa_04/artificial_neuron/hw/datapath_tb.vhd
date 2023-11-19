library ieee;
use ieee.std_logic_1164.all;

entity datapath_tb is
end entity;

architecture testbench of datapath_tb is
signal w_CLK, w_RST, w_LOAD, w_START_MAC, w_START_RELU, w_MAC_FINISHED : std_logic := '0';
constant c_CLK_PERIOD : time := 10 ns; 

begin

  DUT : entity work.datapath
  port map (
    i_CLK => w_CLK,
	 i_RST => w_RST,
	 i_LOAD => w_LOAD,
	 i_START_MAC => w_START_MAC,
	 i_START_RELU => w_START_RELU,
	 o_MAC_FINISHED => w_MAC_FINISHED);
	 
  process
  begin
    w_CLK <= '0';
    wait for c_CLK_PERIOD / 2;
    w_CLK <= '1';
    wait for c_CLK_PERIOD / 2;
  end process;
  
  process
  begin
    w_LOAD <= '1';
	 wait for c_CLK_PERIOD;
	 w_START_MAC <= '1';
	 wait for c_CLK_PERIOD*4;
	 assert (w_MAC_FINISHED = '1') report "error @ w_MAC_FINISHED" severity error;
	 
	 w_START_RELU <= '1';
	 
	 wait;
  end process;
end architecture;
	 
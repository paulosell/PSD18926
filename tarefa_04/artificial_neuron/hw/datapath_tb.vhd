library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity datapath_tb is
end entity;

architecture testbench of datapath_tb is
signal w_CLK, w_RST, w_START_MAC, w_START_RELU, w_MAC_FINISHED, w_RELU_FINISHED : std_logic := '0';
signal w_VALUE : std_logic_vector (15 downto 0);
constant c_CLK_PERIOD : time := 10 ns; 

begin

  DUT : entity work.datapath
  port map (
    i_CLK => w_CLK,
	 i_RST => w_RST,
	 i_START_MAC => w_START_MAC,
	 i_START_RELU => w_START_RELU,
	 o_MAC_FINISHED => w_MAC_FINISHED,
	 o_RELU_FINISHED => w_RELU_FINISHED,
	 o_VALUE => w_VALUE);
	 
  process
  begin
    w_CLK <= '1';
    wait for c_CLK_PERIOD / 2;
    w_CLK <= '0';
    wait for c_CLK_PERIOD / 2;
  end process;
  
  process
  begin
	 wait for c_CLK_PERIOD*4;
	 assert (w_MAC_FINISHED = '1') report "error @ w_MAC_FINISHED" severity error;
	 
	 w_START_RELU <= '1';
	 wait for c_CLK_PERIOD;
	 assert (w_VALUE = std_logic_vector(to_signed(100, w_VALUE'length))) report "error @ w_VALUE" severity error;
	 wait;
  end process;
end architecture;
	 
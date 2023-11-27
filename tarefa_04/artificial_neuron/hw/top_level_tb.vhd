library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity top_level_tb is
end entity;

architecture testbench of top_level_tb is
signal w_CLK, w_RST, w_GO, w_RDY : std_logic := '0';
signal w_VALUE : std_logic_vector(15 downto 0);

constant c_CLK_PERIOD : time := 10 ns; 

begin

  DUT : entity work.top_level
  port map (
    i_CLK => w_CLK,
	 i_RST => w_RST,
	 i_GO => w_GO,
	 o_RDY => w_RDY,
	 o_VALUE => w_VALUE);
	 
  process
  begin
    w_CLK <= '0';
    wait for c_CLK_PERIOD / 2;
    w_CLK <= '1';
    wait for c_CLK_PERIOD / 2;
  end process;
  
  process
  begin
  
  w_GO <= '1';
  w_RST <= '1';
  wait for c_CLK_PERIOD;
  assert (w_VALUE = std_logic_vector(to_signed(0, w_VALUE'length))) report "Unexpected value @ w_VALUE" severity error;
  
  w_RST <= '0';
  wait for c_CLK_PERIOD;
  w_GO <= '0';
  wait for 4*c_CLK_PERIOD;
  assert (w_VALUE = std_logic_vector(to_signed(100, w_VALUE'length))) report "Unexpected value @ w_VALUE" severity error;
  assert (w_RDY = '1') report "Unexpected value @ w_RDY" severity error;
  wait;
  end process;
end architecture; 

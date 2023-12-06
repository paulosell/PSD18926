library ieee;
use ieee.std_logic_1164.all;

entity tb_celsius_to_fahrenheit is
end entity;

architecture testbench of tb_celsius_to_fahrenheit is
signal w_C, w_F : std_logic_vector(15 downto 0);

begin
  
  DUT : entity work.celsius_to_fahrenheit
  port map (i_C => w_C,
            o_F => w_F);
				
  process
  begin
	 w_C <= "0000000000011110";
	 wait for 10ps;
	 assert(w_F = "0000000001010101") report "Unexpected value at w_F" severity error;
	 
	 w_C <= "0000000000110100";
	 wait for 10ps;
	 assert(w_F = "0000000001111101") report "Unexpected value at w_F" severity error;
	 
	 w_C <= "0000000000001100";
	 wait for 10ps;
	 assert(w_F = "0000000000110101") report "Unexpected value at w_F" severity error;
	 
	 w_C <= "0000000000000000";
	 wait for 10ps;
	 assert(w_F = "0000000000100000") report "Unexpected value at w_F" severity error;
	 wait;
  end process;
end testbench;
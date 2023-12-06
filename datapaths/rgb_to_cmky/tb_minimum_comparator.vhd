library ieee;
use ieee.std_logic_1164.all;
entity tb_minimum_comparator is
end tb_minimum_comparator; 

architecture testbench of tb_minimum_comparator is
signal w_A, w_B, w_C : std_logic_vector(7 downto 0); 
signal w_MUX : std_logic_vector(2 downto 0);

begin
  DUT : entity work.minimum_comparator
  port map ( i_A => w_A,
             i_B => w_B,
				 o_C => w_C);
	
   process
	begin
	w_A <= "10101010";
	w_B <= "01010101";
	wait for 10ps;
	assert (w_C = "01010101") report "Unexpected value at w_C" severity error;
	
	w_A <= "00001111";
	w_B <= "11110000";
	wait for 10ps;
	assert (w_C = "00001111") report "Unexpected value at w_C" severity error;
	
	w_A <= "01010101";
	w_B <= "10101010";
	wait for 10ps;
	assert (w_C = "01010101") report "Unexpected value at w_C" severity error;
   wait;
	end process;
end testbench;
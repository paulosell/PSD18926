library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_subtractor is
end entity;

architecture testbench of tb_subtractor is
signal w_A, w_B, w_O : std_logic_vector(7 downto 0); 
begin

  DUT : entity work.subtractor
  port map ( i_A => w_A,
             i_B => w_B,
				 o_O => w_O);
   process
	begin
	  
	  w_A <= "10101010";
	  w_B <= "01010101";
	  wait for 10ps;
	  assert(w_O = "01010101") report "Unexpected value at w_0" severity error;
	  
	  w_A <= "11110000";
	  w_B <= "00001111";
	  wait for 10ps;
	  assert(w_O = "11100001") report "Unexpected value at w_0" severity error;
	  
	  w_A <= "11111111";
	  w_B <= "11111111";
	  wait for 10ps;
	  assert(w_O = "00000000") report "Unexpected value at w_0" severity error;
	  wait;  
	  
	end process;
end architecture;

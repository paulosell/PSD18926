library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_rgb_to_cmy is
end tb_rgb_to_cmy; 

architecture testbench of tb_rgb_to_cmy is
signal w_R, w_G, w_B, w_C, w_M, w_Y : std_logic_vector(7 downto 0);

begin

  DUT : entity work.rgb_to_cmy
  port map ( i_R => w_R,
             i_G => w_G,
				 i_B => w_B,
				 o_C => w_C,
				 o_M => w_M,
				 o_Y => w_Y );
            
  process
  begin
    
	 wait for 10ps;
    w_R <= "11111111";
	 w_G <= "11111111";
	 w_B <= "11111111";
	 assert(w_C = "00000000") report "Unexpected value at w_C" severity error;
	 assert(w_M = "00000000") report "Unexpected value at w_M" severity error;
	 assert(w_Y = "00000000") report "Unexpected value at w_Y" severity error;
	 wait for 10ps;

	 w_R <= "11111111";
	 w_G <= "00000000";
	 w_B <= "00000000";
	 assert(w_C = "00000000") report "Unexpected value at w_C" severity error;
	 assert(w_M = "11111111") report "Unexpected value at w_M" severity error;
	 assert(w_Y = "11111111") report "Unexpected value at w_Y" severity error;
	 wait for 10ps;
	 
	 w_R <= "00000000";
	 w_G <= "11111111";
	 w_B <= "00000000";
	 assert(w_C = "11111111") report "Unexpected value at w_C" severity error;
	 assert(w_M = "00000000") report "Unexpected value at w_M" severity error;
	 assert(w_Y = "11111111") report "Unexpected value at w_Y" severity error;
	 wait for 10ps;
	 
	 w_R <= "00000000";
	 w_G <= "00000000";
	 w_B <= "11111111";
	 assert(w_C = "11111111") report "Unexpected value at w_C" severity error;
	 assert(w_M = "11111111") report "Unexpected value at w_M" severity error;
	 assert(w_Y = "00000000") report "Unexpected value at w_Y" severity error;
	 wait for 10ps;
	 
	 w_R <= "10101010";
	 w_G <= "01010101";
	 w_B <= "00001111";
	 assert(w_C = "01010101") report "Unexpected value at w_C" severity error;
	 assert(w_M = "10101010") report "Unexpected value at w_M" severity error;
	 assert(w_Y = "11110000") report "Unexpected value at w_Y" severity error;
	 wait for 10ps;
	 wait;
	 end process;
end testbench;
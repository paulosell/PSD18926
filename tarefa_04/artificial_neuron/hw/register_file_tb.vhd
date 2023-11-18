library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity register_file_tb is
end entity;

architecture testbench of register_file_tb is
signal w_CLK, w_RST , w_LOAD:  std_logic := '0';
signal w_MUX : std_logic_vector(1 downto 0) := (others => '0');
signal w_X, w_W : std_logic_vector(7 downto 0) := (others => '0');
constant c_CLK_PERIOD : time := 10 ns; 

begin
 
 DUT : entity work.register_file
 port map (
   i_CLK => w_CLK, 
	i_RST => w_RST,
	i_LOAD => w_LOAD,
	i_MUX => w_MUX,
	o_X => w_X,
	o_W => w_W);
	
  process
  begin
    w_CLK <= '0';
    wait for c_CLK_PERIOD / 2;
    w_CLK <= '1';
    wait for c_CLK_PERIOD / 2;
  end process;
  
  process
  begin
    w_RST <= '0';
	 w_LOAD <= '1';
	 wait for c_CLK_PERIOD;
	 w_LOAD <='0';
    w_MUX <= "00";
	 wait for c_CLK_PERIOD;
	 assert (w_X = std_Logic_vector(to_signed(2, 8))) report "error @ w_X" severity error;
	 assert (w_W = std_Logic_vector(to_signed(1, 8))) report "error @ w_W" severity error;
	 
	 w_MUX <= "01";
	 wait for c_CLK_PERIOD;
	 assert (w_X = std_Logic_vector(to_signed(4, 8))) report "error @ w_X" severity error;
	 assert (w_W = std_Logic_vector(to_signed(3, 8))) report "error @ w_W" severity error;
	 
	 w_MUX <= "10";
	 wait for c_CLK_PERIOD;
	 assert (w_X = std_Logic_vector(to_signed(6, 8))) report "error @ w_X" severity error;
	 assert (w_W = std_Logic_vector(to_signed(5, 8))) report "error @ w_W" severity error;
	 
	 w_MUX <= "11";
	 wait for c_CLK_PERIOD;
	 assert (w_X = std_Logic_vector(to_signed(8, 8))) report "error @ w_X" severity error;
	 assert (w_W = std_Logic_vector(to_signed(7, 8))) report "error @ w_W" severity error;
    wait;
  end process;
end architecture;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity tb_mac is
end tb_mac;

architecture mac_testbench of tb_mac is
signal w_CLK, w_START_MAC : std_logic;
signal w_X, w_W : std_logic_vector(7 downto 0) := (others => '0');
signal w_OLD_MAC, w_NEW_MAC : std_logic_vector(15 downto 0) := (others => '0');
constant c_CLK_PERIOD : time := 10 ns; 

begin

  DUT : entity work.mac
  port map (
    i_CLK => w_CLK,
	 i_START_MAC => w_START_MAC,
	 i_X => w_X,
	 i_W => w_W,
	 i_OLD_MAC => w_OLD_MAC,
	 o_NEW_MAC => w_NEW_MAC);
	 
  process
  begin
    w_CLK <= '0';
    wait for c_CLK_PERIOD / 2;
    w_CLK <= '1';
    wait for c_CLK_PERIOD / 2;
  end process;
  
  process
  begin
    
	 w_START_MAC <= '1';
    w_X <= std_logic_vector(to_signed(1, w_X'length));
	 w_W <= std_logic_vector(to_signed(2, w_W'length));
	 w_OLD_MAC <= std_Logic_vector(to_signed(0, w_OLD_MAC'length));
	 wait for c_CLK_PERIOD;
	 assert (w_NEW_MAC = std_logic_vector(to_signed(2, w_NEW_MAC'length))) report "error @ w_NEW_MAC" severity error;
	 
	 w_X <= std_logic_vector(to_signed(3, w_X'length));
	 w_W <= std_logic_vector(to_signed(4, w_W'length));
	 w_OLD_MAC <= std_Logic_vector(to_signed(2, w_OLD_MAC'length));
	 wait for c_CLK_PERIOD;
	 assert (w_NEW_MAC = std_logic_vector(to_signed(14, w_NEW_MAC'length))) report "error @ w_NEW_MAC" severity error;
	 
	 w_X <= std_logic_vector(to_signed(5, w_X'length));
	 w_W <= std_logic_vector(to_signed(6, w_W'length));
	 w_OLD_MAC <= std_Logic_vector(to_signed(14, w_OLD_MAC'length));
	 wait for c_CLK_PERIOD;
	 assert (w_NEW_MAC = std_logic_vector(to_signed(44, w_NEW_MAC'length))) report "error @ w_NEW_MAC" severity error;
	 
	 w_X <= std_logic_vector(to_signed(7, w_X'length));
	 w_W <= std_logic_vector(to_signed(8, w_W'length));
	 w_OLD_MAC <= std_Logic_vector(to_signed(44, w_OLD_MAC'length));
	 wait for c_CLK_PERIOD;
	 assert (w_NEW_MAC = std_logic_vector(to_signed(100, w_NEW_MAC'length))) report "error @ w_NEW_MAC" severity error;
	 
	 w_START_MAC <= '0';
	 wait for c_CLK_PERIOD;
	 assert (w_NEW_MAC = std_logic_vector(to_signed(100, w_NEW_MAC'length))) report "error @ w_NEW_MAC" severity error;
	 wait;
	 
  end process;
end mac_testbench;
	 
	 
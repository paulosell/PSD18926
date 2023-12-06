library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity tb_mac is
end tb_mac;

architecture mac_testbench of tb_mac is
signal w_CLK, w_RST, w_START_MAC, w_MAC_FINISHED : std_logic := '0';
signal w_X0, w_X1, w_X2, w_X3, w_W0, w_W1, w_W2, w_W3 : std_logic_vector(7 downto 0) := (others => '0');
signal w_MAC : std_logic_vector(15 downto 0) := (others => '0');
constant c_CLK_PERIOD : time := 10 ns; 

begin

  DUT : entity work.mac
  port map (
    i_CLK => w_CLK,
	 i_RST => w_RST,
	 i_START_MAC => w_START_MAC,
	 i_X0 => w_X0,
	 i_X1 => w_X1,
	 i_X2 => w_X2,
	 i_X3 => w_X3,
	 i_W0 => w_W0,
	 i_W1 => w_W1,
	 i_W2 => w_W2,
	 i_W3 => w_W3,
    o_MAC_FINISHED => w_MAC_FINISHED,
	 o_MAC => w_MAC);
	 
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
	 w_START_MAC <= '1';
	 w_X0 <= std_logic_vector(to_signed(1, 8));
	 w_X1 <= std_logic_vector(to_signed(3, 8));
	 w_X2 <= std_logic_vector(to_signed(5, 8));
	 w_X3 <= std_logic_vector(to_signed(7, 8));
	 w_W0 <= std_logic_vector(to_signed(2, 8));
	 w_W1 <= std_logic_vector(to_signed(4, 8));
	 w_W2 <= std_logic_vector(to_signed(6, 8));
	 w_W3 <= std_logic_vector(to_signed(8, 8));
	 wait for c_CLK_PERIOD;
	 assert (w_MAC = std_logic_vector(to_signed(0, w_MAC'length))) report "error @ w_MAC" severity error;
	 assert (w_MAC_FINISHED = '0') report "error @ w_MAC_FINISHED" severity error;
	 
	 w_RST <= '0';
	 w_START_MAC <= '1';
	 w_X0 <= std_logic_vector(to_signed(1, 8));
	 w_X1 <= std_logic_vector(to_signed(3, 8));
	 w_X2 <= std_logic_vector(to_signed(5, 8));
	 w_X3 <= std_logic_vector(to_signed(7, 8));
	 w_W0 <= std_logic_vector(to_signed(2, 8));
	 w_W1 <= std_logic_vector(to_signed(4, 8));
	 w_W2 <= std_logic_vector(to_signed(6, 8));
	 w_W3 <= std_logic_vector(to_signed(8, 8));
	 wait for c_CLK_PERIOD;
	 assert (w_MAC = std_logic_vector(to_signed(100, w_MAC'length))) report "error @ w_MAC" severity error;
	 assert (w_MAC_FINISHED = '1') report "error @ w_MAC_FINISHED" severity error;
	 	 
	 w_RST <= '1';
	 wait for c_CLK_PERIOD;
	 assert (w_MAC = std_logic_vector(to_signed(0, w_MAC'length))) report "error @ w_MAC" severity error;
	 assert (w_MAC_FINISHED = '0') report "error @ w_MAC_FINISHED" severity error;
	 wait;
	 
  end process;
end mac_testbench;
	 
	 
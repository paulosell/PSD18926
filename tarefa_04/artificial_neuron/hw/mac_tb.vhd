library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity tb_mac is
end tb_mac;

architecture mac_testbench of tb_mac is
signal w_CLK, w_RST, w_START_MAC, w_MAC_FINISHED : std_logic;
signal w_MAC : std_logic_vector(15 downto 0) := (others => '0');
constant c_CLK_PERIOD : time := 10 ns; 

begin

  DUT : entity work.mac
  port map (
    i_CLK => w_CLK,
	 i_RST => w_RST,
	 i_START_MAC => w_START_MAC,
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
	 wait for c_CLK_PERIOD;
	 assert (w_MAC = std_logic_vector(to_signed(0, w_MAC'length))) report "error @ w_NEW_MAC" severity error;
	 assert (w_MAC_FINISHED = '0') report "error @ w_MAC_FINISHED" severity error;
	 
	 w_RST <= '0';
	 w_START_MAC <= '1';
	 wait for c_CLK_PERIOD;
	 assert (w_MAC = std_logic_vector(to_signed(100, w_MAC'length))) report "error @ w_NEW_MAC" severity error;
	 assert (w_MAC_FINISHED = '1') report "error @ w_MAC_FINISHED" severity error;
	 
	 w_RST <= '1';
	 w_START_MAC <= '1';
	 wait for c_CLK_PERIOD;
	 assert (w_MAC = std_logic_vector(to_signed(0, w_MAC'length))) report "error @ w_NEW_MAC" severity error;
	 assert (w_MAC_FINISHED = '0') report "error @ w_MAC_FINISHED" severity error;
	 wait;
	 
  end process;
end mac_testbench;
	 
	 
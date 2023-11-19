library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;


entity tb_relu is
end tb_relu;

architecture relu_testbench of tb_relu is
signal w_MAC, w_VALUE : std_logic_vector(15 downto 0) := (others => '0');
signal w_CLK, w_START_RELU : std_logic;

begin

  DUT : entity work.relu
  port map (
    i_MAC => w_MAC, 
	 i_CLK => w_CLK,
	 i_START_RELU => w_START_RELU,
	 o_VALUE => w_VALUE);
	 
  process
  begin
  
    w_MAC <= std_logic_vector(to_signed(16, w_MAC'length));
	 wait for 10ps;
	 assert(w_VALUE = std_logic_vector(to_signed(16, w_MAC'length))) report "Unexpected value at w_VALUE" severity error;
	 
    w_MAC <= std_logic_vector(to_signed(-5, w_MAC'length));
    wait for 10ps;
    assert(w_VALUE = std_logic_vector(to_signed(0, w_MAC'length))) report "Unexpected value at w_VALUE" severity error;
	 
	 w_MAC <= std_logic_vector(to_signed(0, w_MAC'length));
    wait for 10ps;
    assert(w_VALUE = std_logic_vector(to_signed(0, w_MAC'length))) report "Unexpected value at w_VALUE" severity error;
	 wait;
	 
  end process;
end relu_testbench;
	 
	 
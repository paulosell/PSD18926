library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;


entity tb_relu is
end tb_relu;

architecture relu_testbench of tb_relu is
signal w_MAC, w_VALUE : std_logic_vector(15 downto 0) := (others => '0');
signal w_CLK, w_RST, w_START_RELU, w_RELU_FINISHED : std_logic := '0';
constant c_CLK_PERIOD : time := 10 ns; 

begin

  DUT : entity work.relu
  port map (
    i_MAC => w_MAC, 
	 i_RST => w_RST,
	 i_CLK => w_CLK,
	 i_START_RELU => w_START_RELU,
	 o_VALUE => w_VALUE,
	 o_RELU_FINISHED => w_RELU_FINISHED);
	 
	 
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
	 w_START_RELU <= '1';
    w_MAC <= std_logic_vector(to_signed(16, w_MAC'length));
	 wait for c_CLK_PERIOD;
	 assert(w_VALUE = std_logic_vector(to_signed(0, w_MAC'length))) report "Unexpected value at w_VALUE" severity error;
	 assert(w_RELU_FINISHED = '0') report "Unexpected value at w_RELU_FINISHED" severity error;
	 
	 w_RST <= '0';
	 wait for c_CLK_PERIOD;
    assert(w_VALUE = std_logic_vector(to_signed(16, w_MAC'length))) report "Unexpected value at w_VALUE" severity error;
	 assert(w_RELU_FINISHED = '1') report "Unexpected value at w_RELU_FINISHED" severity error;
	 
	 w_START_RELU <= '0';
	 w_MAC <= std_logic_vector(to_signed(-10, w_MAC'length));
    wait for c_CLK_PERIOD;
    assert(w_VALUE = std_logic_vector(to_signed(16, w_MAC'length))) report "Unexpected value at w_VALUE" severity error;
	 
	 w_START_RELU <= '1';
	 w_MAC <= std_logic_vector(to_signed(-10, w_MAC'length));
    wait for c_CLK_PERIOD;
    assert(w_VALUE = std_logic_vector(to_signed(0, w_MAC'length))) report "Unexpected value at w_VALUE" severity error;
	 assert(w_RELU_FINISHED = '1') report "Unexpected value at w_RELU_FINISHED" severity error;
	 wait;
	 
  end process;
end relu_testbench;
	 
	 
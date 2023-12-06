
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux_1_to_2_bits_tb is
end;

architecture bench of mux_1_to_2_bits_tb is
  -- Generics
  -- Ports
  signal i_SEL : std_logic;
  signal i_A   : std_logic;
  signal o_S0  : std_logic;
  signal o_S1  : std_logic;
begin

  DUT : entity work.mux_1_to_2_bits
    port map
    (
      i_SEL => i_SEL,
      i_A   => i_A,
      o_S0  => o_S0,
      o_S1  => o_S1
    );

  stimulus_process : process
  begin
    i_A   <= '0';
    i_SEL <= '0';
    wait for 10 ns;

    -- Test case 1: Input = 0, Sel = 0
    i_A   <= '0';
    i_SEL <= '0';
    wait for 10 ns;
    assert (o_S0 = '0' and o_S1 = '0')
    report "Test case 1 failed"
      severity error;

    -- Test case 2: Input = 1, Sel = 0
    i_A   <= '1';
    i_SEL <= '0';
    wait for 10 ns;
    assert (o_S0 = '1' and o_S1 = '0')
    report "Test case 2 failed"
      severity error;

    -- Test case 3: Input = 0, Sel = 1
    i_A   <= '0';
    i_SEL <= '1';
    wait for 10 ns;
    assert (o_S0 = '0' and o_S1 = '0')
    report "Test case 3 failed"
      severity error;

    -- Test case 4: Input = 1, Sel = 1
    i_A   <= '1';
    i_SEL <= '1';
    wait for 10 ns;
    assert (o_S0 = '0' and o_S1 = '1')
    report "Test case 4 failed"
      severity error;

    assert (false)
    report "test done!"
      severity error;

  end process stimulus_process;

end;
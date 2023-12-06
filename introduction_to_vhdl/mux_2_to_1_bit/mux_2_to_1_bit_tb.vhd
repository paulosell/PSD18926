
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux_2_to_1_bit_tb is
end;

architecture bench of mux_2_to_1_bit_tb is
  -- Generics
  -- Ports
  signal i_SEL : std_logic;
  signal i_A   : std_logic;
  signal i_B   : std_logic;
  signal o_S   : std_logic;
begin

  DUT : entity work.mux_2_to_1_bit
    port map
    (
      i_SEL => i_SEL,
      i_A   => i_A,
      i_B   => i_B,
      o_S   => o_S
    );

  stimulus_process : process
  begin
    i_A   <= '0';
    i_B   <= '0';
    i_SEL <= '0';
    wait for 10 ns;

    -- Test case 1: A = 0, B = 0, Sel = 0
    i_A   <= '0';
    i_B   <= '0';
    i_SEL <= '0';
    wait for 10 ns;
    assert (o_S = '0')
    report "Test case 1 failed"
      severity error;

    -- Test case 2: A = 1, B = 0, Sel = 0
    i_A   <= '1';
    i_B   <= '0';
    i_SEL <= '0';
    wait for 10 ns;
    assert (o_S = '1')
    report "Test case 2 failed"
      severity error;

    -- Test case 3: A = 0, B = 1, Sel = 0
    i_A   <= '0';
    i_B   <= '1';
    i_SEL <= '0';
    wait for 10 ns;
    assert (o_S = '0')
    report "Test case 3 failed"
      severity error;

    -- Test case 4: A = 1, B = 1, Sel = 0
    i_A   <= '1';
    i_B   <= '1';
    i_SEL <= '0';
    wait for 10 ns;
    assert (o_S = '1')
    report "Test case 4 failed"
      severity error;

    -- Test case 5: A = 0, B = 0, Sel = 1
    i_A   <= '0';
    i_B   <= '0';
    i_SEL <= '1';
    wait for 10 ns;
    assert (o_S = '0')
    report "Test case 5 failed"
      severity error;

    -- Test case 6: A = 1, B = 0, Sel = 1
    i_A   <= '1';
    i_B   <= '0';
    i_SEL <= '1';
    wait for 10 ns;
    assert (o_S = '0')
    report "Test case 6 failed"
      severity error;

    -- Test case 7: A = 0, B = 1, Sel = 1
    i_A   <= '0';
    i_B   <= '1';
    i_SEL <= '1';
    wait for 10 ns;
    assert (o_S = '1')
    report "Test case 7 failed"
      severity error;

    -- Test case 8: A = 1, B = 1, Sel = 1
    i_A   <= '1';
    i_B   <= '1';
    i_SEL <= '1';
    wait for 10 ns;
    assert (o_S = '1')
    report "Test case 8 failed"
      severity error;

    assert (false)
    report "test done!"
      severity error;

  end process stimulus_process;
end;
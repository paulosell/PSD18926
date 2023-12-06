
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux_demux_tb is
end;

architecture bench of mux_demux_tb is
  -- Generics
  -- Ports
  signal i_A    : std_logic;
  signal i_B    : std_logic;
  signal i_SEL1 : std_logic;
  signal i_SEL2 : std_logic;
  signal o_S1   : std_logic;
  signal o_S2   : std_logic;
begin

  mux_demux_inst : entity work.mux_demux
    port map
    (
      i_A    => i_A,
      i_B    => i_B,
      i_SEL1 => i_SEL1,
      i_SEL2 => i_SEL2,
      o_S1   => o_S1,
      o_S2   => o_S2
    );

  stimulus_process : process
  begin

    -- init
    i_A    <= '0';
    i_B    <= '0';
    i_SEL1 <= '0';
    i_SEL2 <= '0';
    wait for 10 ns;

    -- Test case 1: A = 0, B = 0, Sel0 = 0, Sel1 = 0
    i_A    <= '0';
    i_B    <= '0';
    i_SEL1 <= '0';
    i_SEL2 <= '0';
    wait for 10 ns;
    assert (o_S1 = '0' and o_S2 = '0')
    report "Test case 1 failed"
      severity error;

    -- Test case 2: A = 1, B = 0, Sel0 = 0, Sel1 = 0
    i_A    <= '1';
    i_B    <= '0';
    i_SEL1 <= '0';
    i_SEL2 <= '0';
    wait for 10 ns;
    assert (o_S1 = '1' and o_S2 = '0')
    report "Test case 2 failed"
      severity error;

    -- Test case 3: A = 0, B = 1, Sel0 = 0, Sel1 = 0
    i_A    <= '0';
    i_B    <= '1';
    i_SEL1 <= '0';
    i_SEL2 <= '0';
    wait for 10 ns;
    assert (o_S1 = '0' and o_S2 = '0')
    report "Test case 3 failed"
      severity error;

    -- Test case 4: A = 1, B = 1, Sel0 = 0, Sel1 = 0
    i_A    <= '1';
    i_B    <= '1';
    i_SEL1 <= '0';
    i_SEL2 <= '0';
    wait for 10 ns;
    assert (o_S1 = '1' and o_S2 = '0')
    report "Test case 4 failed"
      severity error;

    -- Test case 5: A = 0, B = 0, Sel0 = 1, Sel1 = 0
    i_A    <= '0';
    i_B    <= '0';
    i_SEL1 <= '1';
    i_SEL2 <= '0';
    wait for 10 ns;
    assert (o_S1 = '0' and o_S2 = '0')
    report "Test case 5 failed"
      severity error;

    -- Test case 6: A = 1, B = 0, Sel0 = 1, Sel1 = 0
    i_A    <= '1';
    i_B    <= '0';
    i_SEL1 <= '1';
    i_SEL2 <= '0';
    wait for 10 ns;
    assert (o_S1 = '0' and o_S2 = '0')
    report "Test case 6 failed"
      severity error;

    -- Test case 7: A = 0, B = 1, Sel0 = 1, Sel1 = 0
    i_A    <= '0';
    i_B    <= '1';
    i_SEL1 <= '1';
    i_SEL2 <= '0';
    wait for 10 ns;
    assert (o_S1 = '1' and o_S2 = '0')
    report "Test case 7 failed"
      severity error;

    -- Test case 8: A = 1, B = 1, Sel0 = 1, Sel1 = 0
    i_A    <= '1';
    i_B    <= '1';
    i_SEL1 <= '1';
    i_SEL2 <= '0';
    wait for 10 ns;
    assert (o_S1 = '1' and o_S2 = '0')
    report "Test case 8 failed"
      severity error;

    -- Test case 1: A = 0, B = 0, Sel0 = 0, Sel1 = 1
    i_A    <= '0';
    i_B    <= '0';
    i_SEL1 <= '0';
    i_SEL2 <= '1';
    wait for 10 ns;
    assert (o_S1 = '0' and o_S2 = '0')
    report "Test case 1 failed"
      severity error;

    -- Test case 2: A = 1, B = 0, Sel0 = 0, Sel1 = 1
    i_A    <= '1';
    i_B    <= '0';
    i_SEL1 <= '0';
    i_SEL2 <= '1';
    wait for 10 ns;
    assert (o_S1 = '0' and o_S2 = '1')
    report "Test case 2 failed"
      severity error;

    -- Test case 3: A = 0, B = 1, Sel0 = 0, Sel1 = 1
    i_A    <= '0';
    i_B    <= '1';
    i_SEL1 <= '0';
    i_SEL2 <= '1';
    wait for 10 ns;
    assert (o_S1 = '0' and o_S2 = '0')
    report "Test case 3 failed"
      severity error;

    -- Test case 4: A = 1, B = 1, Sel0 = 0, Sel1 = 1
    i_A    <= '1';
    i_B    <= '1';
    i_SEL1 <= '0';
    i_SEL2 <= '1';
    wait for 10 ns;
    assert (o_S1 = '0' and o_S2 = '1')
    report "Test case 4 failed"
      severity error;

    -- Test case 5: A = 0, B = 0, Sel0 = 1, Sel1 = 1
    i_A    <= '0';
    i_B    <= '0';
    i_SEL1 <= '1';
    i_SEL2 <= '1';
    wait for 10 ns;
    assert (o_S1 = '0' and o_S2 = '0')
    report "Test case 5 failed"
      severity error;

    -- Test case 6: A = 1, B = 0, Sel0 = 1, Sel1 = 1
    i_A    <= '1';
    i_B    <= '0';
    i_SEL1 <= '1';
    i_SEL2 <= '1';
    wait for 10 ns;
    assert (o_S1 = '0' and o_S2 = '0')
    report "Test case 6 failed"
      severity error;

    -- Test case 7: A = 0, B = 1, Sel0 = 1, Sel1 = 1
    i_A    <= '0';
    i_B    <= '1';
    i_SEL1 <= '1';
    i_SEL2 <= '1';
    wait for 10 ns;
    assert (o_S1 = '0' and o_S2 = '1')
    report "Test case 7 failed"
      severity error;

    -- Test case 8: A = 1, B = 1, Sel0 = 1, Sel1 = 1
    i_A    <= '1';
    i_B    <= '1';
    i_SEL1 <= '1';
    i_SEL2 <= '1';
    wait for 10 ns;
    assert (o_S1 = '0' and o_S2 = '1')
    report "Test case 8 failed"
      severity error;

    assert (false)
    report "test done!"
      severity error;

  end process stimulus_process;

end;
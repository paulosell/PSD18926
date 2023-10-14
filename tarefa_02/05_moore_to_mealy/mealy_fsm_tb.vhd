
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mealy_fsm_tb is
end;

architecture bench of mealy_fsm_tb is
  -- Clock period
  constant clk_period : time := 10 ns;
  -- Generics
  -- Ports
  signal w_CLK : std_logic := '1';
  signal i_A   : std_logic := '0';
  signal i_B   : std_logic := '0';
  signal o_Y   : std_logic;
begin

  mealy_fsm_inst : entity work.mealy_fsm
    port map
    (
      i_CLK => w_CLK,
      i_A   => i_A,
      i_B   => i_B,
      o_Y   => o_Y
    );
  w_CLK <= not w_CLK after clk_period/2;

  p_STIMULUS : process
  begin
    i_A <= '1';
    i_B <= '0';
    wait for 2 * clk_period;

    i_A <= '1';
    i_B <= '0';
    wait for 2 * clk_period;
    assert (o_Y = '0') report "Erro assert 0" severity error; -- sA

    i_A <= '0';
    i_B <= '0';
    wait for 1.5 * clk_period;
    assert (o_Y = '1') report "Erro assert 1" severity error; -- sC
    wait for clk_period * 0.5;

    i_A <= '0';
    i_B <= '0';
    wait for 1.5 * clk_period;
    assert (o_Y = '1') report "Erro assert 2" severity error; -- sC
    wait for clk_period * 0.5;

    i_A <= '0';
    i_B <= '1';
    wait for 1.5 * clk_period;
    assert (o_Y = '0') report "Erro assert 3" severity error; -- sD
    wait for 0.5 * clk_period;

    i_A <= '0';
    i_B <= '1';
    wait for 1.5 * clk_period;
    assert (o_Y = '1') report "Erro assert 4" severity error; -- sB
    wait for clk_period * 0.5;


    i_A <= '0';
    i_B <= '1';
    wait for 1.5 * clk_period;
    assert (o_Y = '1') report "Erro assert 6" severity error; -- sB
    assert (False) report "assert 6 passed" severity note;
    wait for clk_period * 0.5;

    i_A <= '1';
    i_B <= '1';
    wait for 0.5 * clk_period;
    assert (o_Y = '1') report "Erro assert 7" severity error; -- sC
    wait for clk_period * 0.5;

    i_A <= '1';
    i_B <= '1';
    wait for 1.5 * clk_period;
    assert (o_Y = '0') report "Erro assert 8" severity error; -- sD
    wait for clk_period * 0.5;

    assert (False) report "Test done" severity note;
    wait;

  end process;

end;
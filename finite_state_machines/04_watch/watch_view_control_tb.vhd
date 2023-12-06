library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity watch_view_control_tb is
end;

architecture bench of watch_view_control_tb is
  -- Clock period
  constant clk_period : time := 5 ns;
  -- Generics
  -- Ports
  signal w_CLK : std_logic := '0';
  signal w_B_n : std_logic := '1';
  signal o_S0  : std_logic := '0';
  signal o_S1  : std_logic := '0';
begin

  watch_view_control_DUT : entity work.watch_view_control
    port map
    (
      i_CLK => w_CLK,
      i_B_n => w_B_n,
      o_S0  => o_S0,
      o_S1  => o_S1
    );
  -- generate clock
  w_CLK <= not w_CLK after clk_period/2;
  p_STIMULUS : process
  begin
    wait for 10 ns;

    -- first press
    w_B_n <= '0';
    wait for 10 ns;
    assert (o_S1 = '0' and o_S0 = '1') report "Erro na transição para o modo de exibição de alarme" severity error;
    wait for 10 ns;
    w_B_n <= '1';
    wait for 10 ns;
    assert (o_S1 = '0' and o_S0 = '1') report "Erro soltar o botão para o modo de exibição de alarme" severity error;
    wait for 20 ns;

    w_B_n <= '0';
    wait for 10 ns;
    assert (o_S1 = '1' and o_S0 = '0') report "Erro na transição para o modo de exibição de cron" severity error;
    wait for 10 ns;
    w_B_n <= '1';
    wait for 10 ns;
    assert (o_S1 = '1' and o_S0 = '0') report "Erro soltar o botão para o modo de exibição de cron" severity error;
    wait for 20 ns;

    w_B_n <= '0';
    wait for 10 ns;
    assert (o_S1 = '1' and o_S0 = '1') report "Erro na transição para o modo de exibição de data" severity error;
    wait for 10 ns;
    w_B_n <= '1';
    wait for 10 ns;
    assert (o_S1 = '1' and o_S0 = '1') report "Erro soltar o botão para o modo de exibição de data" severity error;
    wait for 20 ns;

    w_B_n <= '0';
    wait for 10 ns;
    assert (o_S1 = '0' and o_S0 = '0') report "Erro na transição para o modo de exibição de hora" severity error;
    wait for 10 ns;
    w_B_n <= '1';
    wait for 10 ns;
    assert (o_S1 = '0' and o_S0 = '0') report "Erro soltar o botão para o modo de exibição de hora" severity error;
    wait for 20 ns;

    assert (False) report "Test done" severity note;
    wait;
  end process;

end bench;
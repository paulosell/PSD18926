
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity calc_tb is
end;

architecture bench of calc_tb is
  -- Clock period
  constant clk_period : time := 5 ns;
  -- Generics
  constant N : integer := 8;
  -- Ports
  signal w_CLK : std_logic := '0';
  signal w_LD  : std_logic;
  signal w_X   : std_logic;
  signal w_Y   : std_logic;
  signal w_Z   : std_logic;
  signal w_A   : std_logic_vector(N - 1 downto 0);
  signal w_B   : std_logic_vector(N - 1 downto 0);
  signal w_O   : std_logic_vector(N - 1 downto 0);

  -- define type to use array
  type t_INT_ARR is array (0 to 7) of integer;
  type t_LOGIC_ARR is array (0 to 7) of std_logic;

  -- constants
  constant INPUT_WIDTH : integer     := 3;
  constant INPUT_X     : t_LOGIC_ARR := ('0', '0', '0', '0', '1', '1', '1', '1');
  constant INPUT_Y     : t_LOGIC_ARR := ('0', '0', '1', '1', '0', '0', '1', '1');
  constant INPUT_Z     : t_LOGIC_ARR := ('0', '1', '0', '1', '0', '1', '0', '1');
  constant INPUT_A     : t_INT_ARR   := (3, 3, 3, 3, 3, 3, 1, 0);
  constant INPUT_B     : t_INT_ARR   := (3, 3, 3, 0, 0, 255, 0, 0);
  constant OUTPUT_O    : t_INT_ARR   := (6, 0, 4, 3, 0, 255, 1, 255);

begin

  calc_inst : entity work.calc
    generic
    map (
    N => N
    )
    port map
    (
      i_CLK => w_CLK,
      i_LD  => w_LD,
      i_X   => w_X,
      i_Y   => w_Y,
      i_Z   => w_Z,
      i_A   => w_A,
      i_B   => w_B,
      o_O   => w_O
    );

  w_CLK <= not w_CLK after clk_period/2;

  p_TEST :
  process
  begin

    -- init test
    w_LD <= '1'; -- load zero on register
    w_X  <= '0';
    w_Y  <= '0';
    w_Z  <= '0';
    w_A  <= "00000000";
    w_B  <= "00000000";
    wait for (2 * clk_period);
    assert (w_O = "00000000") report "Unexpected value at init test" severity error;

    -- for inputs
    for i in 0 to 2 ** INPUT_WIDTH - 1 loop

      -- set the input signal
      w_A <= std_logic_vector(to_unsigned
        (INPUT_A(i), N));
      w_B <= std_logic_vector(to_unsigned(INPUT_B(i), N));
      w_X <= INPUT_X(i);
      w_Y <= INPUT_Y(i);
      w_Z <= INPUT_Z(i);

      wait for clk_period;

      -- Assert the correct output based on the inputs
      assert (to_integer(unsigned(w_O)) = OUTPUT_O(i))
      report "Priority falt at: XYZ(" & to_string(w_X) & ")"
        severity error;
    end loop;

    assert (false)
    report "test done!"
      severity note;

    wait;

  end process;
end;
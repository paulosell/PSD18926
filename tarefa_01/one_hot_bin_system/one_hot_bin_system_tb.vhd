
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity one_hot_bin_system_tb is
end;

architecture bench of one_hot_bin_system_tb is
  -- Generics
  -- Ports
  signal i_REQ       : std_logic_vector(3 downto 0);
  signal o_GRANT_BIT : std_logic;
  signal o_GRANT_BIN : std_logic_vector(1 downto 0);

  -- define type to use array
  type t_INT_ARR is array (0 to 15) of integer;
  type t_LOGIC_ARR is array (0 to 15) of std_logic;

  -- constants
  constant INPUT_WIDTH       : integer   := 4;
  constant O_GRANT_BIN_TRUTH : t_INT_ARR := (0, 0, 1, 0, 2, 0, 1, 0, 3, 0, 1, 0, 2, 0, 1, 0);
  constant O_GRANT_BIT_TRUTH : t_LOGIC_ARR := ('0', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1');

begin

  one_hot_bin_system_inst : entity work.one_hot_bin_system
    port map
    (
      i_REQ       => i_REQ,
      o_GRANT_BIT => o_GRANT_BIT,
      o_GRANT_BIN => o_GRANT_BIN
    );

  stimulus_process : process
  begin

    -- init
    i_REQ <= "0000";
    wait for 10 ns;

    -- for inputs
    for i in 0 to INPUT_WIDTH ** 2 - 1 loop

      -- set the input signal
      i_REQ <= std_logic_vector(to_unsigned(i, INPUT_WIDTH));
      wait for 10 ns;

      -- Assert the correct output based on the inputs
      assert (o_GRANT_BIT = O_GRANT_BIT_TRUTH(i) and
              to_integer(unsigned(o_GRANT_BIN)) = O_GRANT_BIN_TRUTH(i))
      report "Priority falt at: " & to_string(i_REQ) & " - " & to_string(o_GRANT_BIN)
        severity error;
    end loop;

    assert (false)
    report "test done!"
      severity note;

  end process stimulus_process;
end;
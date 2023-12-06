
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity one_hot_tb is
end;

architecture bench of one_hot_tb is
  -- Generics
  -- Ports
  signal i_REQ   : std_logic_vector(3 downto 0);
  signal o_GRANT : std_logic_vector(3 downto 0);

  -- constants
  constant INPUT_WIDTH : integer := 4;

  -- define type to use array
  type t_INT_ARR is array (0 to 15) of integer;

  -- constants
  constant INPUT_WIDTH   : integer   := 4;
  constant O_GRANT_TRUTH : t_INT_ARR := (0, 1, 2, 1, 4, 1, 2, 1, 8, 1, 2, 1, 4, 1, 2, 1);

begin

  DUT : entity work.one_hot
    port map
    (
      i_REQ   => i_REQ,
      o_GRANT => o_GRANT
    );

  stimulus_process : process
  begin

    -- init
    i_REQ <= "0000";
    wait for 10 ns;

    -- loop for all input variables
    for i in 0 to INPUT_WIDTH ** 2 - 1 loop

      -- set input
      i_REQ <= std_logic_vector(to_unsigned(i, INPUT_WIDTH));
      wait for 10 ns;

      -- Assert the correct output based on the inputs
      assert (to_integer(unsigned(o_GRANT)) = O_GRANT_TRUTH(i))
      report "Priority falt at: " & to_string(i_REQ) & " - " & to_string(o_GRANT)
        severity error;

    end loop;

    assert (false)
    report "test done!"
      severity note;

  end process stimulus_process;
end;
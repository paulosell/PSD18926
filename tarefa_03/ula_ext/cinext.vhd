library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity cinext is
  port
  (
    i_X   : in std_logic;
    i_Y   : in std_logic;
    i_Z   : in std_logic;
    o_CIN : out std_logic);
end entity;

architecture cinext_arch of cinext is
  signal w_XYZ : std_logic_vector(2 downto 0);
begin

  w_XYZ <= i_X & i_Y & i_Z;

  p_PROCESS :
  process (all)
  begin
    case w_XYZ is
      when "000" =>
        o_CIN <= '0';
      when "001" =>
        o_CIN <= '1';
      when "010" =>
        o_CIN <= '1';
      when "011" =>
        o_CIN <= '0';
      when "100" =>
        o_CIN <= '0';
      when "101" =>
        o_CIN <= '0';
      when "110" =>
        o_CIN <= '0';
      when "111" =>
        o_CIN <= '0';
      when others =>
        o_CIN <= '0';
    end case;

  end process;
end cinext_arch;
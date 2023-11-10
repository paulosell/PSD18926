library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity abext is
  generic
    (N : integer := 8);
  port
  (
    i_X : in std_logic;
    i_Y : in std_logic;
    i_Z : in std_logic;
    i_A : in std_logic;
    i_B : in std_logic;
    o_A : out std_logic;
    o_B : out std_logic);
end entity;

architecture abext_arch of abext is
  signal w_XYZ : std_logic_vector(2 downto 0);
begin

  w_XYZ <= i_X & i_Y & i_Z;

  p_PROCESS :
  process (all)
  begin
    case w_XYZ is
      when "000" =>
        o_A <= i_A;
        o_B <= i_B;
      when "001" =>
        o_A <= i_A;
        o_B <= not i_B;
      when "010" =>
        o_A <= i_A;
        o_B <= '0';
      when "011" =>
        o_A <= i_A;
        o_B <= '0';
      when "100" =>
        o_A <= i_A and i_B;
        o_B <= '0';
      when "101" =>
        o_A <= i_A or i_B;
        o_B <= '0';
      when "110" =>
        o_A <= i_A xor i_B;
        o_B <= '0';
      when "111" =>
        o_A <= not i_A;
        o_B <= '0';
      when others =>
        o_A <= '0';
        o_B <= '0';
    end case;
  end process;
end abext_arch;
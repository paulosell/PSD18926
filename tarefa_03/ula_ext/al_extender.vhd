library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity al_extender is
  generic
    (N : integer := 8);
  port
  (
    i_X : in std_logic;
    i_Y : in std_logic;
    i_Z : in std_logic;
    i_A : in std_logic_vector(N - 1 downto 0);
    i_B : in std_logic_vector(N - 1 downto 0);
    o_A : out std_logic_vector(N - 1 downto 0);
    o_B : out std_logic_vector(N - 1 downto 0);
    o_CIN : out std_logic);
end entity;

architecture al_extender_arch of al_extender is
  component abext
    port
    (
      i_X : in std_logic;
      i_Y : in std_logic;
      i_Z : in std_logic;
      i_A : in std_logic;
      i_B : in std_logic;
      o_A : out std_logic;
      o_B : out std_logic
    );
  end component;

  component cinext
    port
    (
      i_X   : in std_logic;
      i_Y   : in std_logic;
      i_Z   : in std_logic;
      o_CIN : out std_logic
    );
  end component;

begin

  cinext_inst : entity work.cinext
    port map
    (
      i_X   => i_X,
      i_Y   => i_Y,
      i_Z   => i_Z,
      o_CIN => o_CIN
    );

  -- Using for generate to instantiate multiple AND gates
  gen_abext_inst : for i in 0 to N-1 generate
    abext_inst : entity work.abext
      port
      map (
      i_X => i_X,
      i_Y => i_Y,
      i_Z => i_Z,
      i_A => i_A(i),
      i_B => i_B(i),
      o_A => o_A(i),
      o_B => o_B(i)
      );
  end generate gen_abext_inst;

end al_extender_arch;
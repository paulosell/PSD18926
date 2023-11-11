library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity alu is
  generic
    (N : integer := 8);
  port
  (
    i_X : in std_logic;
    i_Y : in std_logic;
    i_Z : in std_logic;
    i_A : in std_logic_vector(N - 1 downto 0);
    i_B : in std_logic_vector(N - 1 downto 0);
    o_O : out std_logic_vector(N - 1 downto 0));
end entity;

architecture alu_arch of alu is

  signal w_A, w_B : std_logic_vector(N - 1 downto 0);
  signal w_CIN    : std_logic;
  component al_extender
    generic
    (
      N : integer
    );
    port
    (
      i_X   : in std_logic;
      i_Y   : in std_logic;
      i_Z   : in std_logic;
      i_A   : in std_logic_vector(N - 1 downto 0);
      i_B   : in std_logic_vector(N - 1 downto 0);
      o_A   : out std_logic_vector(N - 1 downto 0);
      o_B   : out std_logic_vector(N - 1 downto 0);
      o_CIN : out std_logic
    );
  end component;

  component adder
    generic
    (
      N : integer
    );
    port
    (
      i_CIN : in std_logic;
      i_A   : in std_logic_vector(N - 1 downto 0);
      i_B   : in std_logic_vector(N - 1 downto 0);
      o_O   : out std_logic_vector(N - 1 downto 0)
    );
  end component;
begin
  al_extender_inst : entity work.al_extender
    generic
    map (
    N => N
    )
    port map
    (
      i_X   => i_X,
      i_Y   => i_Y,
      i_Z   => i_Z,
      i_A   => i_A,
      i_B   => i_B,
      o_A   => w_A,
      o_B   => w_B,
      o_CIN => w_CIN
    );

  adder_inst : entity work.adder
    generic
    map (
    N => N
    )
    port
    map (
    i_CIN => w_CIN,
    i_A   => w_A,
    i_B   => w_B,
    o_O   => o_O
    );

end alu_arch;
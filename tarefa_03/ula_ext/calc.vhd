library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity calc is
  generic
    (N : integer := 8);
  port
  (
    i_CLK : in std_logic;
    i_LD  : in std_logic;
    i_X   : in std_logic;
    i_Y   : in std_logic;
    i_Z   : in std_logic;
    i_A   : in std_logic_vector(N - 1 downto 0);
    i_B   : in std_logic_vector(N - 1 downto 0);
    o_O   : out std_logic_vector(N - 1 downto 0));
end entity;

architecture calc_arch of calc is

  signal w_S : std_logic_vector(N - 1 downto 0);
  component alu
    generic
    (
      N : integer
    );
    port
    (
      i_X : in std_logic;
      i_Y : in std_logic;
      i_Z : in std_logic;
      i_A : in std_logic_vector(N - 1 downto 0);
      i_B : in std_logic_vector(N - 1 downto 0);
      o_O : out std_logic_vector(N - 1 downto 0)
    );
  end component;

  component reg
    generic
    (
      BIT_WIDTH : integer
    );
    port
    (
      i_CLK   : in std_logic;
      i_RESET : in std_logic;
      i_LD    : in std_logic;
      i_D     : in std_logic_vector(BIT_WIDTH - 1 downto 0);
      o_Q     : out std_logic_vector(BIT_WIDTH - 1 downto 0)
    );
  end component;

begin
  alu_inst : entity work.alu
    generic
    map (
    N => N
    )
    port map
    (
      i_X => i_X,
      i_Y => i_Y,
      i_Z => i_Z,
      i_A => i_A,
      i_B => i_B,
      o_O => w_S
    );

  reg_inst : entity work.reg
    generic
    map (
    BIT_WIDTH => N
    )
    port
    map (
    i_CLK   => i_CLK,
    i_RESET => '0',
    i_LD    => i_LD,
    i_D     => w_S,
    o_Q     => o_O
    );
end calc_arch;
library ieee;
use ieee.std_logic_1164.all;

entity top_level is
generic ( N : integer := 8);
port (
  i_CLK : in std_logic;
  i_RST : in std_logic;
  i_GO : in std_logic;
  o_VALUE : out std_logic_vector ((N*2)-1 downto 0));
end entity;

architecture top_level_arch of top_level is
signal w_MAC_FINISHED, w_RELU_FINISHED: std_logic := '0';

component control is 
generic ( N : integer := 8);
port (
  i_CLK : in std_logic;
  i_RST : in std_logic; 
  i_GO : in std_logic;
  i_MAC_FINISHED : in std_logic;
  i_RELU_FINISHED : in std_logic;
  o_START_MAC  : out std_logic;
  o_START_RELU : out std_logic);
end component;

component datapath is
generic ( N : integer := 8);
port (
  i_CLK : in std_logic;
  i_RST : in std_logic;
  i_START_MAC : in std_logic;
  i_START_RELU : in std_logic;
  o_MAC_FINISHED : out std_logic;
  o_RELU_FINISHED : out std_logic;
  o_VALUE : out std_logic_vector((N*2) - 1 downto 0));
end component;

signal w_START_MAC, w_START_RELU : std_logic := '0';
signal w_X, w_W : std_logic_vector(N-1 downto 0) := (others => '0');

begin

  u_control : control port map (
    i_CLK => i_CLK, 
	 i_RST => i_RST, 
	 i_GO => i_GO,
	 i_MAC_FINISHED => w_MAC_FINISHED, 
	 i_RELU_FINISHED => w_RELU_FINISHED,
	 o_START_MAC => w_START_MAC,
	 o_START_RELU => w_START_RELU);
	 
  u_datapath : datapath port map (
    i_CLK => i_CLK, 
	 i_RST => i_RST, 
	 i_START_MAC => w_START_MAC, 
	 i_START_RELU => w_START_RELU, 
	 o_MAC_FINISHED => w_MAC_FINISHED,
	 o_RELU_FINISHED => w_RELU_FINISHED,	 
	 o_VALUE => o_VALUE);
  
end architecture;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity datapath is
generic ( N : integer := 8);
port (
  i_CLK : in std_logic;
  i_RST : in std_logic;
  i_START_MAC : in std_logic;
  i_START_RELU : in std_logic;
  o_MAC_FINISHED : out std_logic;
  o_RELU_FINISHED : out std_logic;
  o_VALUE : out std_logic_vector((N*2) - 1 downto 0));
end datapath;

architecture datapath_arch of datapath is

component register_file is
generic ( N : integer := 8);
port (
  i_CLK : in std_logic;
  i_RST : in std_logic;
  i_START_MAC : in std_logic;
  i_MUX : in std_logic_vector(1 downto 0);
  o_W : out std_logic_vector(N-1 downto 0);
  o_X : out std_logic_vector(N-1 downto 0));
end component;

component mac is
generic ( N : integer := 8);
port (
  i_CLK : in std_logic;
  i_RST : in std_logic;
  i_START_MAC : in std_logic;
  o_MAC_FINISHED : out  std_logic;
  o_MAC : out std_logic_vector((N*2)-1 downto 0));
end component;

component relu is
generic ( N : integer := 16);
port (
  i_CLK : in std_logic;
  i_RST : in std_logic;
  i_START_RELU : in std_logic;
  i_MAC   : in std_logic_vector(N-1 downto 0);
  o_VALUE : out std_logic_vector(N-1 downto 0);
  o_RELU_FINISHED : out std_logic);
end component;

component counter is
generic ( N : integer := 2);
port (
  i_CLK : in std_logic;
  i_COUNT : in std_logic;
  i_RST : in std_logic;
  o_FINISHED : out std_logic;
  o_OUT : out std_logic_vector( N -1 downto 0));
end component;

signal w_COUNTER_FINISHED : std_logic := '0';
signal w_MUX : std_logic_vector(1 downto 0) := (others => '0');
signal w_X, w_W : std_logic_vector(N-1 downto 0) := (others => '0');
signal w_NEW_MAC : std_logic_vector((N*2)-1 downto 0) := (others => '0');

signal w_MAC_FINISHED, w_RELU_FINISHED : std_logic := '0';
signal w_VALUE : std_logic_vector(15 downto 0);

begin
   
  u_mac : mac port map(
    i_CLK => i_CLK, 
	 i_RST => i_RST,
	 i_START_MAC => i_START_MAC,
	 o_MAC_FINISHED => w_MAC_FINISHED,
	 o_MAC => w_NEW_MAC);
  
  u_relu : relu port map( 
    i_CLK => i_CLK, 
	 i_RST => i_RST,
	 i_START_RELU => i_START_RELU, 
	 i_MAC => w_NEW_MAC, 
	 o_VALUE => w_VALUE, 
	 o_RELU_FINISHED => w_RELU_FINISHED);
  
  o_MAC_FINISHED <= w_MAC_FINISHED; 
  o_RELU_FINISHED <= w_RELU_FINISHED;
  o_VALUE <= w_VALUE;

end architecture; 

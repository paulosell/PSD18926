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

component mac is
generic ( N : integer := 8);
port (
  i_CLK : in std_logic;
  i_RST : in std_logic;
  i_START_MAC : in std_logic;
  i_X0 : in std_logic_vector(N-1 downto 0);
  i_X1 : in std_logic_vector(N-1 downto 0);
  i_X2 : in std_logic_vector(N-1 downto 0);
  i_X3 : in std_logic_vector(N-1 downto 0);
  i_W0 : in std_logic_vector(N-1 downto 0);
  i_W1 : in std_logic_vector(N-1 downto 0);
  i_W2 : in std_logic_vector(N-1 downto 0);
  i_W3 : in std_logic_vector(N-1 downto 0);
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

signal w_COUNTER_FINISHED : std_logic := '0';
signal w_MUX : std_logic_vector(1 downto 0) := (others => '0');
signal w_X, w_W : std_logic_vector(N-1 downto 0) := (others => '0');
signal w_NEW_MAC : std_logic_vector((N*2)-1 downto 0) := (others => '0');

signal w_MAC_FINISHED, w_RELU_FINISHED : std_logic := '0';
signal w_VALUE : std_logic_vector(15 downto 0);

signal w_X0 : std_logic_vector(N-1 downto 0) := std_logic_vector(to_signed(1, 8));
signal w_X1 : std_logic_vector(N-1 downto 0) := std_logic_vector(to_signed(3, 8));
signal w_X2 : std_logic_vector(N-1 downto 0) := std_logic_vector(to_signed(5, 8));
signal w_X3 : std_logic_vector(N-1 downto 0) := std_logic_vector(to_signed(7, 8));

signal w_W0 : std_logic_vector(N-1 downto 0) := std_logic_vector(to_signed(2, 8));
signal w_W1 : std_logic_vector(N-1 downto 0) := std_logic_vector(to_signed(4, 8));
signal w_W2 : std_logic_vector(N-1 downto 0) := std_logic_vector(to_signed(6, 8));
signal w_W3 : std_logic_vector(N-1 downto 0) := std_logic_vector(to_signed(8, 8));

begin
   
  u_mac : mac port map(
    i_CLK => i_CLK, 
	 i_RST => i_RST,
	 i_START_MAC => i_START_MAC,
	 i_X0 => w_X0,
	 i_X1 => w_X1,
	 i_X2 => w_X2,
	 i_X3 => w_X3,
	 i_W0 => w_W0,
	 i_W1 => w_W1,
	 i_W2 => w_W2,
	 i_W3 => w_W3,
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

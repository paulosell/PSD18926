library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity reg_file is
generic ( N : integer := 8);
port (
  i_CLK : in std_logic;
  i_RST : in std_logic;
  i_MUX : in std_logic_vector(1 downto 0);
  o_W : out std_logic_vector(N-1 downto 0);
  o_X : out std_logic_vector(N-1 downto 0));  
end entity;

architecture a of reg_file is
type t_REGISTER_ARRAY is array (0 to 3) of signed(7 downto 0);
type t_MUX is array (0 to 3) of std_logic_vector(7 downto 0);

signal w_X : t_REGISTER_ARRAY := (to_signed(2,N),to_signed(4,N),to_signed(6,N), to_signed(8,N));
signal w_W : t_REGISTER_ARRAY := (to_signed(1,N),to_signed(3,N),to_signed(5,N), to_signed(7,N));

signal w_XMUX : t_MUX;
signal w_WMUX : t_MUX;


component reg is
generic ( N : integer := 8);
port (
  i_CLK : in std_logic;
  i_RST : in std_logic;
  i_D   : in std_logic_vector(N-1 downto 0);
  o_Q   : out std_logic_vector(N-1 downto 0));
end component;

begin

  gen_x : for i in 0 to 3 generate
  u_reg_x : reg port map(i_CLK => i_CLK, i_RST => i_RST, i_D => std_logic_vector(w_X(i)), o_Q => (x_XMUX(i)));
  end generate;
  
  gen_w : for i in 0 to 3 generate
  u_reg_w : reg port map(i_CLK => i_CLK, i_RST => i_RST, i_D => std_logic_vector(w_W(i)), o_Q => (w_WMUX(i)));
  end generate;
	 
	o_X <= w_XMUX(0) when i_MUX = "00" else
	       w_XMUX(1) when i_MUX = "01" else
			 w_XMUX(2) when i_MUX = "10" else
			 w_XMUX(3) when i_MUX = "11";

  o_W <= w_WMUX(0) when i_MUX = "00" else
         w_WMUX(1) when i_MUX = "01" else
         w_WMUX(2) when i_MUX = "10" else
         w_WMUX(3) when i_MUX = "11";
end architecture;
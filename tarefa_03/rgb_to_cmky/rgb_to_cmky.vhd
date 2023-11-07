library ieee;
use ieee.std_logic_1164.all;

entity rgb_to_cmky is
generic ( N : integer := 8 );
port (  
  i_R : in std_logic_vector(N-1 downto 0);
  i_G : in std_logic_vector(N-1 downto 0);
  i_B : in std_logic_vector(N-1 downto 0);
  o_C : out std_logic_vector(N-1 downto 0);
  o_M : out std_logic_vector(N-1 downto 0);
  o_K : out std_logic_vector(N-1 downto 0);
  o_Y : out std_logic_vector(N-1 downto 0));
end rgb_to_cmky; 

architecture rgb_to_cmky_arch of rgb_to_cmky is
signal w_C, w_M, w_Y : std_logic_vector(N-1 downto 0);
signal w_MIN_CM, w_K : std_logic_vector(N-1 downto 0);

component rgb_to_cmy is
generic ( N : integer := 8 );
port (  
  i_R : in std_logic_vector(N-1 downto 0);
  i_G : in std_logic_vector(N-1 downto 0);
  i_B : in std_logic_vector(N-1 downto 0);
  o_C : out std_logic_vector(N-1 downto 0);
  o_M : out std_logic_vector(N-1 downto 0);
  o_Y : out std_logic_vector(N-1 downto 0));
end component;

component minimum_comparator is
generic ( N : integer := 8 );
port (  
  i_A : in std_logic_vector(N-1 downto 0);
  i_B : in std_logic_vector(N-1 downto 0);
  o_C : out std_logic_vector(N-1 downto 0));
end component;

component subtractor is
generic ( N : integer := 8 );
port (  
  i_A  : in std_logic_vector(N-1 downto 0);
  i_B  : in std_logic_vector(N-1 downto 0);
  o_O : out std_logic_vector(N-1 downto 0));
end component;
begin

  u_rgb_to_cmy : rgb_to_cmy port map(i_R => i_R, i_G => i_G, i_B => i_B, o_C => w_C, o_M => w_M, o_Y => w_Y);
  
  u_min_comp_1 : minimum_comparator port map(i_A => w_C, i_B => w_M, o_C => w_MIN_CM);
  
  u_min_comp_2 : minimum_comparator port map(i_A => w_MIN_CM, i_B => w_Y, o_C => w_K);
  
  u_sub_1 : subtractor port map(i_A => w_C, i_B => w_K, o_O => o_C);
  u_sub_2 : subtractor port map(i_A => w_M, i_B => w_K, o_O => o_M);
  u_sub_3 : subtractor port map(i_A => w_Y, i_B => w_K, o_O => o_Y);
  
  o_K <= w_K;

end rgb_to_cmky_arch;
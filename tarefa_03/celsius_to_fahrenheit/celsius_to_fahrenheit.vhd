library ieee;
use ieee.std_logic_1164.all;

entity celsius_to_fahrenheit is
generic ( N : integer := 16);
port ( i_C : in std_logic_vector(N-1 downto 0);
       o_F : out std_logic_vector(N-1 downto 0));
end entity;

architecture celsius_to_fahrenheit_arch of celsius_to_fahrenheit is
signal w_IC_SHIFTED_6, w_IC_SHIFTED_5, w_IC_SHIFTED_2, w_IC_SHIFTED_1 : std_logic_vector(N-1 downto 0);
signal w_SUM_SHIFTED_6_5, w_SUM_SHIFTED_2_1 : std_logic_vector(N-1 downto 0);
signal w_SUM_SHIFTED : std_logic_vector(N-1 downto 0);
signal w_SHIFTED_7 : std_logic_vector(N-1 downto 0);
signal w_SUM_IC_SHIFTED_7 : std_logic_vector(N-1 downto 0);


component bit_shifter is
generic (N      : integer := 16);
port ( i_IN        : in std_logic_vector(N-1 downto 0);
       i_PLACES    : in std_logic_vector(2 downto 0);
       i_DIRECTION : in std_logic;
       o_OUT       : out std_logic_vector(N-1 downto 0));
end component;

component adder is
generic ( N : integer := 16);
port ( i_A   : in std_logic_vector(N-1 downto 0);
       i_B   : in std_logic_vector(N-1 downto 0);
		 o_OUT : out std_logic_vector(N-1 downto 0));
end component;



begin

 u_bit_shifter_6 : bit_shifter port map (i_IN => i_C, i_DIRECTION => '1', i_PLACES => "110", o_OUT => w_IC_SHIFTED_6);
 u_bit_shifter_5 : bit_shifter port map (i_IN => i_C, i_DIRECTION => '1', i_PLACES => "101", o_OUT => w_IC_SHIFTED_5);
 u_bit_shifter_2 : bit_shifter port map (i_IN => i_C, i_DIRECTION => '1', i_PLACES => "010", o_OUT => w_IC_SHIFTED_2);
 u_bit_shifter_1 : bit_shifter port map (i_IN => i_C, i_DIRECTION => '1', i_PLACES => "001", o_OUT => w_IC_SHIFTED_1);
 
 u_adder_65 : adder port map (i_A => w_IC_SHIFTED_6, i_B => w_IC_SHIFTED_5, o_OUT => w_SUM_SHIFTED_6_5);
 u_adder_21 : adder port map (i_A => w_IC_SHIFTED_2, i_B => w_IC_SHIFTED_1, o_OUT => w_SUM_SHIFTED_2_1);
 
 u_adder_shifted : adder port map (i_A => w_SUM_SHIFTED_6_5, i_B => w_SUM_SHIFTED_2_1, o_OUT => w_SUM_SHIFTED);
 
 u_bit_shifter_7 : bit_shifter port map (i_IN => w_SUM_SHIFTED, i_DIRECTION => '0', i_PLACES => "000", o_OUT => w_SHIFTED_7);
 
 u_adder_ic_shifted_7 : adder port map (i_A => i_C, i_B => w_SHIFTED_7, o_OUT => w_SUM_IC_SHIFTED_7);
 
 u_adder_final : adder port map (i_A => w_SUM_IC_SHIFTED_7, i_B => "0000000000100000", o_OUT => o_F);

end celsius_to_fahrenheit_arch;

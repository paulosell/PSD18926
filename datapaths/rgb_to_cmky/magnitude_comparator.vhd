library ieee;
use ieee.std_logic_1164.all;

entity magnitude_comparator is
port ( 
  i_A  : in std_logic;
  i_B  : in std_logic;
  i_GT : in std_logic;
  i_EQ : in std_logic;
  i_LT : in std_logic;
  o_GT : out std_logic;
  o_EQ : out std_logic;
  o_LT : out std_logic);
end magnitude_comparator;

architecture magnitude_comparator_arch of magnitude_comparator is
begin

  o_GT <= i_GT or (i_EQ and (i_A and (not i_B)));
  o_EQ <= i_EQ and (i_A xnor i_B);
  o_LT <= i_LT or (i_EQ and ((not i_A) and i_B));
  
end magnitude_comparator_arch;	 
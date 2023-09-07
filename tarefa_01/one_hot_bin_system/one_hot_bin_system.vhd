-- Implemente um sistema digital baseado nos Circuitos 4 e 5. O sistema deve
-- possuir quatro entradas de requisição e três saídas. Uma saída deve ser acionada sempre
-- que pelo menos uma requisição for ativada. As outras duas saídas devem identificar a
-- requisição selecionada quando alguma delas for ativada, sendo que seu valor default é "00"

library ieee;
use ieee.std_logic_1164.all;

entity one_hot_bin_system is
	port(
		i_REQ       : in std_logic_vector(3 downto 0);
		o_GRANT_BIT : out std_logic;
		o_GRANT_BIN : out std_logic_vector(1 downto 0)
		);
end one_hot_bin_system;

architecture arch of one_hot_bin_system is

component one_hot_bin is
port(
    i_REQ : in std_logic_vector(3 downto 0);
	 o_GRANT : out std_logic_vector(3 downto 0);
	 o_GRANT_BIN : out std_logic_vector(1 downto 0)
	 );
end component;

signal w_GRANT : std_logic_vector(3 downto 0); 

begin
  u_1 : one_hot_bin port map( i_REQ => i_REQ, o_GRANT_BIN => o_GRANT_BIN, o_GRANT => w_GRANT);
  o_GRANT_BIT <= i_REQ(0) or i_REQ(1) or i_REQ(2) or i_REQ(3);
end arch;

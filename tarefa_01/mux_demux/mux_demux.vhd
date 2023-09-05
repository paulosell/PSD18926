-- Implemente um sistema digital baseado nos circuitos 1 e 2. O sistema deve
-- possuir duas entradas de dado conectadas ao multiplexador 2-para-1, cuja saída de dado
-- deve ser conectada à entrada de dado do demultiplexador 1-para 2. As saídas de dado do
-- demultiplexador devem ser as saídas do sistema, o qual, além das duas entradas de dado,
-- deve possuir duas entradas de controle correspondente aos seletores do multiplexador e do
-- demultiplexador. 
library ieee;
use ieee.std_logic_1164.all;

entity mux_demux is
  port (
    i_A : in std_logic;
	 i_B : in std_logic;
	 i_SEL1 : in std_logic;
	 i_SEL2 : in std_logic;
	 o_S1 : out std_logic;
	 o_S2 : out std_logic
  );
end mux_demux;

architecture arch of mux_demux is
signal w_MUX_OUTPUT   : std_logic;
signal w_DEMUX_INPUT  : std_logic;
begin
  process (i_SEL1, i_A, i_B)
  begin
   if (i_SEL1 = '0') then
     w_MUX_OUTPUT      <= i_A;
   else w_MUX_OUTPUT <= i_B;
   end if;
   end process;
   w_DEMUX_INPUT <= w_MUX_OUTPUT;
  process (i_SEL2, w_DEMUX_INPUT)
  begin
    if i_SEL2 = '0' then
      o_S1 <= w_DEMUX_INPUT;
      o_S2 <= '0';
    else
      o_S1 <= '0';
      o_S2 <= w_DEMUX_INPUT;
    end if;
    end process;
end arch;





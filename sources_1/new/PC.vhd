library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity PC is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           fromMBR: in std_logic_vector(15 downto 0);
           outMAR: out std_logic_vector(7 downto 0);
           C6: in std_logic;
C20: in std_logic;
C25: in std_logic 
           );
end PC;

architecture Behavioral of PC is
signal regPC: std_logic_vector(7 downto 0) := "00000000";
begin

process(C6,C20,C25)
begin
if(reset='1')then
regPC<= "00000000";
end if;
    if C20 = '1' then
        regPC <= fromMBR(7 downto 0);
    elsif C6 = '1' then
        regPC <= regPC + 1;
    elsif C25 = '1' then
        regPC <= "00000000";        
    end if;

end process;
outMAR <= regPC;
end Behavioral;

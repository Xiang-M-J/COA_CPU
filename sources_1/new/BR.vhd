
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity BR is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           fromMBR: in std_logic_vector(15 downto 0);
           outALU: out std_logic_vector(15 downto 0);
           C7: in std_logic
           );
end BR;

architecture Behavioral of BR is
signal regBR: std_logic_vector(15 downto 0) := "0000000000000000";
begin
process(clk)
begin
if clk'event and clk = '1' then
    if C7 = '1' then
        regBR <= fromMBR;
    end if;
    outALU <= regBR;
end if;
end process;

end Behavioral;

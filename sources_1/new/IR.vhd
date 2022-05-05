library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity IR is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           fromMBR: in std_logic_vector(7 downto 0);
           outCU: out std_logic_vector(7 downto 0);
           C4: in std_logic
           );
end IR;

architecture Behavioral of IR is
signal regIR: std_logic_vector(7 downto 0) := "00000000";
begin
process(clk)
begin
if clk'event and clk = '1' then
    if C4 = '1' then
        regIR <= fromMBR;
    end if;
end if;  
end process;
outCU <= regIR;
end Behavioral;

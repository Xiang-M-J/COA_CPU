library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MAR is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           fromPC: in std_logic_vector(7 downto 0);     -- PC --> MAR
           fromMBR: in std_logic_vector(15 downto 0);    -- BR --> MAR
           outMem: out std_logic_vector(7 downto 0);     -- MAR --> Memory
           C5:in std_logic;
           C10:in std_logic
           );
end MAR;

architecture Behavioral of MAR is
signal regMAR: std_logic_vector(7 downto 0) := "00000000";
begin
process(clk)
begin
--if reset = '1' then
--    MAROut <= "00000000";
--    prePC <= fromPC;
--    preBR <= fromBR(7 downto 0);
if clk'event and clk = '1' then
    if C5 = '1' then
        regMAR <= fromMBR(7 downto 0);
        outMem <= regMAR;
    elsif C10 = '1' then
        regMAR <= fromPC;
        outMem <= regMAR;
    end if;
end if;
end process;

end Behavioral;

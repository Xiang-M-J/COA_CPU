library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MR is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           fromALU: in std_logic_vector(15 downto 0);
           C14: in std_logic;
           outDisplay2: out std_logic_vector(15 downto 0)  -- MR -> Display
           );
end MR;

architecture Behavioral of MR is
signal regMR: std_logic_vector(15 downto 0) := "0000000000000000";
begin
process(clk)
begin
if clk'event and clk = '1' then
   if reset='1'then
   regMR<="0000000000000000";
   elsif reset='0'and C14='1'then
   regMR<=fromALU;
   end if;  
end if;
end process;
outDisplay2<=regMR; 
end Behavioral;

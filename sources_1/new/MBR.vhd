----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2022/04/12 15:09:07
-- Design Name: 
-- Module Name: MBR - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MBR is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           outRegs: out std_logic_vector(15 downto 0);      -- MBR --> PC MAR IR BR
           outMem: out std_logic_vector(15 downto 0);       -- MBR --> Memory
           fromACC: in std_logic_vector(15 downto 0);       -- ACC --> MBR
           fromMem: in std_logic_vector(15 downto 0);       -- Memory --> MBR
           C3: in std_logic;
           C11: in std_logic 
          );
end MBR;

architecture Behavioral of MBR is
--signal preACC: std_logic_vector(15 downto 0);
--signal preMem: std_logic_vector(15 downto 0);
signal regMBR: std_logic_vector(15 downto 0):= "0000000000000000";
begin
process(clk)
begin
--if reset = '1' then
--    preACC <= fromACC;
--    preMem <= fromMem;
--    MBROut <= "0000000000000000";
--    MBROutM <= "0000000000000000";
if clk'event and clk = '1' then
    if C11 = '1' then
        regMBR <= fromACC;
    elsif C3 = '1' then
        regMBR <= fromMem;
--    elsif control_signal(2) = '1' then
--         MBR <- MR £¿
    end if;
end if;
outMem <= regMBR;
outRegs <= regMBR;
end process;


end Behavioral;

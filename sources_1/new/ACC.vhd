library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ACC is
    Port ( clk : in STD_LOGIC;
           ACCout: out std_logic_vector(15 downto 0);
           fromALU: in std_logic_vector(15 downto 0)
           );
end ACC;

architecture Behavioral of ACC is
signal regACC: std_logic_vector(15 downto 0) := "0000000000000000";
begin
regACC <= fromALU;
ACCout <= regACC;
end Behavioral;

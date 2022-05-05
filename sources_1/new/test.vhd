library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
entity test is
Port (
  clk:in std_logic;
  reset: in std_logic;
  switch_MRACC:in std_logic;
  digital_enable: out std_logic_vector(7 downto 0);
  digital: out std_logic_vector(7 downto 0)
);
end test;

architecture Behavioral of test is
signal MRtoSHOW:std_logic_vector(15 downto 0):="0001101010000101";
signal ACCout:std_logic_vector(15 downto 0):="1100111111000111";
signal clk_disp: std_logic;
signal clk_work: std_logic;
COMPONENT frequency 
  Port ( 
  clk: in std_logic;
  reset: in std_logic;
  clk_disp: out std_logic;
  clk_work: out std_logic
  );
END COMPONENT;
COMPONENT Display
  Port (
   clk: in std_logic;
   fromALU: in std_logic_vector(15 downto 0);
   fromMR: in std_logic_vector(15 downto 0);
   digital_enable: out std_logic_vector(7 downto 0);
   digital: out std_logic_vector(7 downto 0);
   showMR: in std_logic
   );
END COMPONENT;
begin
u_Display1: Display 
Port MAP(
   clk=>clk_disp,
   fromALU=>ACCout,
   fromMR=>MRtoSHOW,
   digital_enable=>digital_enable,
   digital=>digital,
   showMR=>switch_MRACC
   );
Fre:frequency
Port map( 
  clk=>clk,
  reset=>reset,
  clk_disp=>clk_disp,
  clk_work=>clk_work
);
process(clk_work)
begin
if(reset='1')then
ACCout<="1100111111000111";
MRtoSHOW<="0001101010000101";
elsif(reset='0')then
ACCout<="0000111111000111";
MRtoSHOW<="0000001010000101";
end if;
end process;
end Behavioral;

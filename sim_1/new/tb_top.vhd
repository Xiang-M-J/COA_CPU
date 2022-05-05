library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_top is
end tb_top;

architecture Behavioral of tb_top is
constant clk_period : time :=10ns;
signal clk: std_logic := '0';
--signal reset: std_logic;
signal switch_MRACC: std_logic;
signal digital_enable:  std_logic_vector(7 downto 0):="00000000";
signal digital: std_logic_vector(7 downto 0):="00000000";
component main is
  Port (
  clk:in std_logic;
  --reset: in std_logic;
  switch_MRACC:in std_logic;
  digital_enable: out std_logic_vector(7 downto 0);
  digital: out std_logic_vector(7 downto 0)
   );
end component;

begin
uu: main port map(clk=>clk,switch_MRACC=>switch_MRACC,digital_enable=>digital_enable,digital=>digital);
--, reset=>reset
clk_gen: process
begin
wait for clk_period/2;    
clk<='1';      
wait for clk_period/2;    
clk<='0';  
end process;

switch_MRACC_gen:process    
begin
switch_MRACC <= '0';
wait for 10us;
switch_MRACC <= '1';
wait;
end process;

end Behavioral;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_cu is
end tb_cu;

architecture Behavioral of tb_cu is
constant clk_period : time :=2ns;
signal clk: std_logic := '0';
signal reset: std_logic;
signal FLAG: std_logic;
signal C25: std_logic;
signal C26: std_logic;
signal C27: std_logic;
signal C28: std_logic;
signal CAR: std_logic_vector(5 downto 0);
signal IR_IN: std_logic_vector(7 downto 0);
component CU is
Port (
clk:in std_logic;
reset : in std_logic;
FLAG:in std_logic;
C25:in std_logic;
C26:in std_logic;
C27:in std_logic;
C28:in std_logic;
CAR:out std_logic_vector(5 downto 0);
IR_IN:in std_logic_vector(7 downto 0)
 );
end component;

begin
u1: CU port map(clk=>clk,
reset=>reset,
FLAG=>FLAG,
C25=>C25,
C26=>C26,
C27=>C27,
C28=>C28,
CAR=>CAR,
IR_IN=>IR_IN
 );

clk_gen: process
begin
wait for clk_period/2;    
clk<='1';      
wait for clk_period/2;    
clk<='0';  
end process;

reset_gen:process    
begin
reset <= '1';
wait for 30ns;
reset <= '0';
wait;
end process;

end Behavioral;


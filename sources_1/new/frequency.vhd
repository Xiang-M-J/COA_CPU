
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity frequency is
  Port ( 
  clk: in std_logic;
  reset: in std_logic;
  clk_disp: out std_logic;
  clk_work: out std_logic
  );
end frequency;

architecture Behavioral of frequency is
signal clk1: std_logic:='0';
signal clk2: std_logic:='0';
begin
process(clk)    -- 10kHz供数码管使用
VARIABLE cnt1:INTEGER range 0 to 5000;
begin
if clk'event and clk = '1' then
    if cnt1<2499 then
        cnt1:=cnt1+1;
    else
        cnt1 :=0;
        clk1 <= not clk1;
--        clk_disp <= clk1;
    end if;
end if;
clk_disp <= clk1;
end process;


process(clk)    -- 1kHz供数码管使用
VARIABLE cnt2:INTEGER range 0 to 500000;
begin
if clk'event and clk = '1' then
    if cnt2<249999 then
        cnt2:=cnt2+1;
    else
        cnt2 :=0;
        clk2 <= not clk2;
--        clk_disp <= clk1;
    end if;
end if;
clk_work <= clk2;
end process;
end Behavioral;

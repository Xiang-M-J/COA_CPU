----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2021/07/19 09:43:25
-- Design Name: 
-- Module Name: debounce - Behavioral
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
USE IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.std_logic_unsigned.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity debounce is
  Port (
  clk:in STD_LOGIC;             -- ʱ���ź�
  sw0, sw1: in std_logic;   --���أ���������
  showMR: out std_logic;
  reset: out std_logic
   );
end debounce;

architecture Behavioral of debounce is
    SIGNAL temp1,temp2,temp3:STD_LOGIC_VECTOR(1 DOWNTO 0); ---�����ź�
begin

    process(clk)
    begin
        if clk'event and clk = '1' then
            temp2<=sw0&sw1;  -- & ��������������ϳ�һ��14λ�ı�������
            temp3<=temp2;
        end if;
    end process;

    --- ����0����
    process(clk, temp2, temp3)
    variable cnt9: integer range 0 to 1000000;     -- ȡ10ms       100M/ 1M == 100hz
    begin
       
        if clk'event and clk = '1' then
            if temp2(1)=temp3(1) then
                if cnt9=1000000 then
                    temp1(1)<= temp3(1);
                    cnt9:=cnt9;
                else
                    cnt9:=cnt9+1;
                end if;
            else cnt9:=0;
            end if ;
        end if;
    end process;

    --- ����1����
    process(clk, temp2, temp3)
    variable cnt8: integer range 0 to 1000000;     -- ȡ10ms       100M/ 1M == 100hz
    begin
        if clk'event and clk = '1' then
            if temp2(0)=temp3(0) then
                if cnt8=1000000 then
                    temp1(0)<= temp3(0);
                    cnt8:=cnt8;
                else
                    cnt8:=cnt8+1;
                end if;
            else cnt8:=0;
            end if ;
        end if;
    end process;

    process(clk, temp1)
    begin
       if clk'event and clk = '1' then
        case temp1(9 downto 0) is
            when "10" => showMR <= '1' ;
            when "01" => reset <= '1';
            when others => 
                showMR<='0';
                reset <= '0';
        end case; 
        end if;
    end process;
end Behavioral;

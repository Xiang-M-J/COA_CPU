library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_SIGNED.ALL;

entity Display is
  Port (
   clk: in std_logic;
   fromALU: in std_logic_vector(15 downto 0);
   fromMR: in std_logic_vector(15 downto 0);
   digital_enable: out std_logic_vector(7 downto 0);
   digital: out std_logic_vector(7 downto 0);
   showMR: in std_logic
   );
end Display;

architecture Behavioral of Display is	
signal i: std_logic_vector(3 downto 0) := "0000";
--signal L1,L2,L3,L4,H1,H2,H3,H4:std_logic_vector(3 downto 0);    -- L1-L4表示低四位（加减与或非时运算结果）
---- H1-H4表示MR寄存器时的内容，即乘法计算时的高四位
signal number: integer range -1 to 10;
signal acci: integer range 0 to 100000;
signal accimr: integer range 0 to 100000;
signal show: integer range 0 to 100000;
signal symbol:integer range -1 to 10;
signal symbolacc:integer range -1 to 10;
signal symbolmr:integer range -1 to 10;
--signal buff: std_logic_vector(31 downto 0) := "00000000000000000000000000000000";
--signal acciplus: integer range -2147483647 to 2147483647;
signal clk_digital:std_logic:='0';
begin
process(clk)
variable count_div:integer range 0 to 100000;
begin 
		if (clk'event and clk='1') then				
			if count_div =100000 then
				count_div:=0;
            clk_digital<=not clk_digital;
			else 
				count_div:=count_div+1;
			end if;
		end if;	
end process;

process(clk_digital)
begin
if clk_digital'event and clk_digital = '1' then
    if i < 5 then
        i<=i+1;
    else
        i<="0000";
    end if;
end if;
end process;

--process(clk)
--begin
--if showMR = '0' then
--    if fromMR = "0000000000000000" then
--        buff <= fromALU;
--        buff <= buff - 1;
--        buff <= buff(15) & not buff(14 downto 0);
--    end if;
--else
--    buff <= fromMR(15 downto 0);
--    buff <= buff - 1;
--    buff := buff(15) & not buff(14 downto 0);
--end if;
--end process;
process(clk_digital)
begin
if clk_digital'event and clk_digital = '1' then
    
--        if fromMR = "0000000000000000" then
            if fromALU(15) = '1' then
                acci <= conv_integer(65536 - fromALU);
                symbolacc<=-1;
            else
                acci <= conv_integer(fromALU(15 downto 0));
                symbolacc<=10;
            end if;
--        else
--            buff <= fromMR & fromALU;
            if fromMR(15) = '1' then
--                acciplus <= - conv_integer(buff(31 downto 0));
                  accimr <= conv_integer(65536 - fromMR);
                  symbolmr<=-1;
            else
--                acciplus <= conv_integer(buff(31 downto 0));
                  accimr <= conv_integer(fromMR(15 downto 0));
                  symbolmr<=10;
            end if;
            
--            if fromMR()
            if showMR = '1' then
--                acci <= acciplus / 100000;
               show<=accimr;
               symbol<=symbolmr;
            else
--                acci <= acciplus rem 100000;
                 show<=acci; 
                 symbol<=symbolacc;
            end if;
        end if;
               
--        else
--            acci <= conv_integer(fromALU(15 downto 0));   
--        end if;
--    else
--        acci <= conv_integer(buff(14 downto 0));
    
--end if;
end process;

PROCESS(clk_digital,i)    --根据i来片选数码管 （8选1）
variable a,b,c,d,e: integer range 0 to 9;
variable f: integer range -1 to 10;
BEGIN
--a := acci rem 10;
--b := (acci - a) rem 100 / 10;
--c := (acci - a -10*b) rem 1000 / 100;
--d := (acci - a - 10*b -100*c) rem 10000 / 1000 ;
--e := (acci - a - 10*b - 100*c - 1000*d) rem 100000 / 10000;
a := show rem 10;
b := (show - a) rem 100 / 10;
c := (show - a -10*b) rem 1000 / 100;
d := (show - a - 10*b -100*c) rem 10000 / 1000 ;
e := (show - a - 10*b - 100*c - 1000*d) rem 100000 / 10000;
f := symbol;
if clk_digital'event and clk_digital = '1' then
    case i is
    when "0001"=> number <= a; digital_enable<="01111111";
    when "0010"=> number <= b; digital_enable<="11111110";
    when "0011"=> number <= c; digital_enable<="11111101";
    when "0100"=> number <= d; digital_enable<="11111011";
    when "0101"=> number <= e; digital_enable<="11110111";
--    when "0101"=> if fromMR(15) = '1' or fromALU(15) = '1' then number <= -1; digital_enable <= "01111111"; end if;
    when "0000"=>number <= f ; digital_enable<="11101111";
--    when "110"=> number <= fromMR(11 downto 8); digital_enable<="10111111";
--    when "111"=> number <= fromMR(15 downto 12); digital_enable<="01111111";
    when others=> NULL;
    end case;
end if;
END PROCESS;

PROCESS(clk_digital,number)
BEGIN
IF clk_digital'event and clk_digital = '1' THEN
    CASE number IS ---根据number显示对应数字
    when 0 => digital<="11000000"; --0       c0 
    when 1 => digital<="11111001"; --1        f9
    when 2 => digital<="10100100"; --2         a4
    when 3 => digital<="10110000"; --3        b0
    when 4 => digital<="10011001"; --4         99
    when 5 => digital<="10010010"; --5         92
    when 6 => digital<="10000010"; --6          82
    when 7 => digital<="11111000"; --7          f8
    when 8 => digital<="10000000"; --8          80
    when 9 => digital<="10010000"; --9          90
    when -1 => digital <= "10111111"; -- 负号    bf
--    when "1010" => digital<="10001000"; --a
--    when "1011" => digital<="10000011"; --b
--    when "1100" => digital<="11000110"; --c
--    when "1101" => digital<="10100001"; --d
--    when "1110" => digital<="10000110"; --e
--    when "1111" => digital<="10001110"; --f
    when others => digital<="11111111";       
    END CASE;
END IF;
END PROCESS ;


end Behavioral;

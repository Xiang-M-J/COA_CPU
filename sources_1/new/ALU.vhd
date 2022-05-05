library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;
use ieee.std_logic_signed.all;

entity ALU is
    Port (
clk : in STD_LOGIC;
reset : in STD_LOGIC;
fromBR: in std_logic_vector(15 downto 0);
fromACC: in std_logic_vector(15 downto 0);
outACC: out std_logic_vector(15 downto 0);
outMR: out std_logic_vector(15 downto 0);
C8: in std_logic;
C9: in std_logic;
C12: in std_logic;
C13: in std_logic;
C14: in std_logic;
C16: in std_logic;
C17: in std_logic;
C18: in std_logic;
C19: in std_logic;
isOverZero: out std_logic
           );
end ALU;

architecture Behavioral of ALU is
signal regALU: std_logic_vector(15 downto 0):= "0000000000000000";
signal regMR: std_logic_vector(15 downto 0) := "0000000000000000";
--signal regDR: std_logic_vector(15 downto 0) := "0000000000000000";
--signal acci: integer range -32767 to 32767;
--signal bri: integer range -32767 to 32767;
signal res: integer range 0 to 32767;
begin
process(C8,
C9,
C12,
C13,
C14,
C16,
C17,
C18,
C19)
variable res: std_logic_vector(31 downto 0); 
--variable D: std_logic_vector(31 downto 0);
variable modNum,remNum: integer range -32767 to 32767;
--variable A: std_logic_vector(31 downto 0);
begin
    if C9 = '1' then -- ¼Ó
        regALU <= fromACC + fromBR;
        regMR <= "0000000000000000";
        if regALU < x"0000" then
            isOverZero <= '0';
        else 
            isOverZero <= '1';
        end if;
    elsif C12 = '1' then  -- ¼õ
        regALU <= fromACC - fromBR;
        regMR <= "0000000000000000";
        if regALU < x"0000" then
            isOverZero <= '0';
        else 
            isOverZero <= '1';
        end if;
    elsif C14 = '1' then  -- ³Ë
--        regALU <= fromACC(7 downto 0)*fromBR(7 downto 0);
--        regMR <= fromACC(7 downto 0)*fromBR(15 downto 8); 
--        regALU(15 downto 8) <= regALU(15 downto 8)+regMR(7 downto 0);
--        regMR <= fromACC(15 downto 8) * fromBR(7 downto 0);
--        regALU(15 downto 8) <= 
--        outACC <= regALU;
--        regALU <= fromACC(15 downto 8)*fromBR(7 downto 0);
        if (fromACC(15) xor fromBR(15))='1'then 
            if fromACC = x"0000" or fromBR = x"0000" then
                isOverZero <= '1';
            else
                isOverZero <= '0';
            end if;
            if fromACC(15)='1' then ----temp<0
                res:=(0-fromACC)*fromBR;
            else
                res:=fromACC*(0-fromBR);
            end if;
            res:=0-res;
            regALU<=res(15 downto 0);  
            regMR<=res(31 downto 16); 
        else 
            isOverZero <= '1';
            if fromACC(15)='1' then
                res:=(0-fromACC)*(0-fromBR);
            else
                res:=fromACC*fromBR;
            end if;
            regALU <= res(15 downto 0);  
            regMR  <= res(31 downto 16);
        end if; 
       
    --elsif control_signal(3) = '1' then  -- ³ý
--        D := fromBR & "0000000000000000";
--        A := "0000000000000000" & fromACC;
--        for i in 0 to 15 loop
--            A := '0' & A(31 downto 1);
--            A := A - D;
--        end loop;
        --acci <= conv_integer(fromACC);
        --bri <= conv_integer(fromBR);
        --modNum := acci mod bri;
        --remNum := acci rem bri;
        --regDR <= conv_unsigned(remNum);
--        regMR <= (acci rem 10);
--        regALU <= acci / bri;
    elsif C13 = '1' then  -- Óë
        regALU <= fromACC and fromBR;
        regMR <= "0000000000000000";
        if regALU < x"0000" then
            isOverZero <= '0';
        else 
            isOverZero <= '1';
        end if;
    elsif C16 = '1' then  -- »ò
        regALU <= fromACC or fromBR;
        regMR <= "0000000000000000";
        if regALU < x"0000" then
            isOverZero <= '0';
        else 
            isOverZero <= '1';
        end if;
    elsif C17 = '1' then  -- ·Ç
        regALU <= not fromBR;
        regMR <= "0000000000000000";
        if regALU < x"0000" then
            isOverZero <= '0';
        else 
            isOverZero <= '1';
        end if;
    elsif C18 = '1' then  -- Âß¼­×óÒÆ
        regALU <= fromACC(14 downto 0) & '0';
        regMR <= "0000000000000000";
        if regALU < x"0000" then
            isOverZero <= '0';
        else 
            isOverZero <= '1';
        end if;
    elsif C19 = '1' then  -- Âß¼­ÓÒÒÆ
        regALU <= '0' & fromACC(15 downto 1);
        regMR <= "0000000000000000";
        if regALU < x"0000" then
            isOverZero <= '0';
        else 
            isOverZero <= '1';
        end if;
    elsif C8 = '1' then  -- ACCÖÃ0
        regALU <= "0000000000000000";
    end if;
end process;
outMR<= regMR;
outACC<= regALU;
end Behavioral;

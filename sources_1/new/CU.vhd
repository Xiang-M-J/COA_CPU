library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
entity CU is
Port (
clk:in std_logic;
reset:in std_logic;
FLAG:in std_logic;
IR_IN:in std_logic_vector(7 downto 0);
control_signal: out std_logic_vector(22 downto 0)
 );
end CU;
architecture Behavioral of CU is
signal CAR:std_logic_vector(5 downto 0):="000000";
signal state_count:integer :=0;
signal control_signal_all: std_logic_vector(26 downto 0):="000000000000000000000000000";
COMPONENT control_memory_rom
  PORT (
    clka : IN STD_LOGIC;
    addra : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
    douta : OUT STD_LOGIC_VECTOR(26 DOWNTO 0)
  );
END COMPONENT;
begin
rom: control_memory_rom
  PORT MAP (
    clka => clk,
    addra => CAR,
    douta => control_signal_all
  );
process(clk)
begin
if clk'event and clk='1'then

if (state_count=2) then
state_count<=0;
else
state_count<=state_count+1;
end if;

if(reset='1')then
CAR<="000000";
state_count<=0;
elsif(state_count=0 and reset='0')then
  if(control_signal_all(1)='1')then --根据IR对CAR赋值
case IR_IN is   
when "00000001"=>CAR<="000011"; --STORE
when "00000010"=>CAR<="000101"; --LOAD
when "00000011"=>CAR<="001000"; --ADD
when "00000100"=>CAR<="001011"; --SUB
when "00001000"=>CAR<="001110"; --MPY
when "00001010"=>CAR<="010001"; --AND
when "00001011"=>CAR<="010100"; --OR
when "00001100"=>CAR<="010111"; --NOT
when "00001101"=>CAR<="011010"; --SHIFTR
when "00001110"=>CAR<="011011"; --SHIFTL
when "00000101"=>CAR<="011100"; --JMPGEZ
when "00000110"=>CAR<="011110"; --JMP
when "00000111"=>CAR<="011111"; --HALT
when  others=>CAR<="000000";
end case;
elsif(control_signal_all(0)='1')then
CAR<=CAR+1;
elsif(control_signal_all(2)='1')then
CAR<="000000";
elsif(control_signal_all(26)='1')then
  if(FLAG='1')then
  CAR<=CAR+1;
  elsif(FLAG='0')then
  CAR<="000000";
  end if;
end if;
end if;
end if;
end process;
control_signal<=control_signal_all(25 downto 3);

end Behavioral;

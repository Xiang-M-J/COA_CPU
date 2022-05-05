library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity main is
  Port (
  clk:in std_logic;
  --reset: in std_logic;
  switch_MRACC:in std_logic;
  digital_enable: out std_logic_vector(7 downto 0);
  digital: out std_logic_vector(7 downto 0)
   );
end main;

architecture Behavioral of main is
signal MBR_OUT:std_logic_vector(15 downto 0);
signal reset:std_logic:='0';
signal MEMORY_MBR:std_logic_vector(15 downto 0);
signal clk_disp: std_logic;
signal clk_work: std_logic;
signal control_signal: std_logic_vector(22 downto 0);
signal IRtoCU:std_logic_vector(7 downto 0);
signal PCtoMAR:std_logic_vector(7 downto 0);
signal MARtoMemory:std_logic_vector(7 downto 0);
signal MBRtoReg:std_logic_vector(15 downto 0);
signal MBRtoMemory:std_logic_vector(15 downto 0);
signal MemorytoMBR:std_logic_vector(15 downto 0);
signal ALUtoACC:std_logic_vector(15 downto 0);
signal BRtoALU:std_logic_vector(15 downto 0);
signal ACCout:std_logic_vector(15 downto 0);
signal ALUtoMR:std_logic_vector(15 downto 0);
signal MRtoSHOW:std_logic_vector(15 downto 0);
--signal ACC_SHOW:std_logic_vector(15 downto 0);
--signal MR_SHOW:std_logic_vector(15 downto 0);
signal flag:std_logic;

COMPONENT main_memory_ram
  PORT (
    clka : IN STD_LOGIC;
    wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    addra : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    dina : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    douta : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
  );
END COMPONENT;

--COMPONENT frequency 
--  Port ( 
--  clk: in std_logic;
--  reset: in std_logic;
--  clk_disp: out std_logic;
--  clk_work: out std_logic
--  );
--END COMPONENT;

COMPONENT IR
Port(
clk : in STD_LOGIC;
reset : in STD_LOGIC;
fromMBR: in std_logic_vector(7 downto 0);
outCU: out std_logic_vector(7 downto 0);
C4: in std_logic
);
END COMPONENT;

COMPONENT CU 
Port (
clk:in std_logic;
reset: in std_logic;
FLAG:in std_logic;
IR_IN:in std_logic_vector(7 downto 0);
control_signal: out std_logic_vector(22 downto 0)
 );
END COMPONENT;

COMPONENT ACC 
Port( 
clk : in STD_LOGIC;
ACCout: out std_logic_vector(15 downto 0);
fromALU: in std_logic_vector(15 downto 0)
);
END COMPONENT;

COMPONENT ALU
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
END COMPONENT;

COMPONENT BR
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           fromMBR: in std_logic_vector(15 downto 0);
           outALU: out std_logic_vector(15 downto 0);
           C7: in std_logic
           );
END COMPONENT;

COMPONENT MAR
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           fromPC: in std_logic_vector(7 downto 0);     -- PC --> MAR
           fromMBR: in std_logic_vector(15 downto 0);    -- BR --> MAR
           outMem: out std_logic_vector(7 downto 0);     -- MAR --> Memory
           C5: in std_logic;
           C10: in std_logic
           );
END COMPONENT;

COMPONENT MBR
Port (
clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           outRegs: out std_logic_vector(15 downto 0);      -- MBR --> PC MAR IR BR
           outMem: out std_logic_vector(15 downto 0);       -- MBR --> Memory
           fromACC: in std_logic_vector(15 downto 0);       -- ACC --> MBR
           fromMem: in std_logic_vector(15 downto 0);       -- Memory --> MBR
           C3: in std_logic;
           C11: in std_logic
);
END COMPONENT;

COMPONENT PC
Port (
clk : in STD_LOGIC;
reset : in STD_LOGIC;
fromMBR: in std_logic_vector(15 downto 0);
outMAR: out std_logic_vector(7 downto 0);
C6: in std_logic;
C20: in std_logic;
C25: in std_logic
);
END COMPONENT;

COMPONENT MR
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           fromALU: in std_logic_vector(15 downto 0);
           C14: in std_logic;
           outDisplay2: out std_logic_vector(15 downto 0)  -- MR -> Display
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

--COMPONENT DigitalSHOW is
--Port (
--CLK:in std_logic;
--RESET:in std_logic;
--From_ALUL:in std_logic_vector(15 downto 0);
--From_ALUH:in std_logic_vector(15 downto 0);
--digital:out std_logic_vector(7 downto 0);
--digital_enable:out std_logic_vector(7 downto 0)
-- );
--END COMPONENT;
begin
u_Display: Display 
Port MAP(
   clk=>clk,
   fromALU=>ACCout,
   fromMR=>MRtoSHOW,
   digital_enable=>digital_enable,
   digital=>digital,
   showMR=>switch_MRACC
   );

--u_Display: DigitalSHOW
--Port MAP(
--CLK=>clk,
--RESET=>switch_MRACC,
--From_ALUL=>ACCout,
--From_ALUH=>MRtoSHOW,
--digital=>digital,
--digital_enable=>digital_enable
-- );

--u_Fre0:frequency
--Port map( 
--  clk=>clk,
--  reset=>reset,
--  clk_disp=>clk_disp,
--  clk_work=>clk_work
--);
  
ram:main_memory_ram --ok
PORT map(
clka => clk,
    wea =>control_signal(20 downto 20),
    addra =>MARtoMemory,
    dina =>MemorytoMBR,
    douta  =>MemorytoMBR
  );

u_CU1:CU    --ok
Port MAP(
clk=>clk,
reset=>reset,
FLAG=>flag,
IR_IN=>IRtoCU,
control_signal=>control_signal
 );
 
u_IR1:IR     --ok
 Port MAP(
 clk=> clk,
 reset=>reset,
 fromMBR=>MBRtoReg(15 downto 8),
 outCU=>IRtoCU,
 C4=>control_signal(1)
 );

u_ACC: ACC   --ok
Port map(
clk=>clk,
ACCout=>ACCout,
fromALU=>ALUtoACC
);   

u_ALU1:ALU   --ok
Port map(
clk=>clk,
reset=>reset,
fromBR=>BRtoALU,
fromACC=>ACCout,
outACC=>ALUtoACC,
outMR=>ALUtoMR,
C8=>control_signal(5),
C9=>control_signal(6),
C12=>control_signal(9),
C13=>control_signal(10),
C14=>control_signal(11),
C16=>control_signal(13),
C17=>control_signal(14),
C18=>control_signal(15),
C19=>control_signal(16),
isOverZero=>flag
);
 
u_BR1:BR    --ok
Port map(
clk=>clk,
reset=>reset,
fromMBR=>MBRtoReg,
outALU=>BRtoALU,
C7=>control_signal(4)
);

u_MAR1:MAR    --ok
Port map(
clk=>clk,
reset=>reset,
fromPC=>PCtoMAR,
fromMBR=>MBRtoReg,
outMem=>MARtoMemory,
C5=>control_signal(2),
C10=>control_signal(7)
);

u_MBR1:MBR   --OK
Port map(
clk=>clk,
reset=>reset,
outRegs=>MBRtoReg,      -- MBR --> PC MAR IR BR
outMem=>MBRtoMemory,       -- MBR --> Memory
fromACC=>ACCout,       -- ACC --> MBR
fromMem=>MemorytoMBR,       -- Memory --> MBR
C3=>control_signal(0),
C11=>control_signal(8)
);

u_PC1:PC   --OK
Port map(
clk=>clk,
reset=>reset,
fromMBR=>MBRtoReg,
outMAR=>PCtOMAR,
C6=>control_signal(3),
C20=>control_signal(17),
C25=>control_signal(22)
);

u_MR1:MR   --ok
Port map(
clk=>clk,
reset=>reset,
fromALU=>ALUtoMR,
C14=>control_signal(11),
outDisplay2=> MRtoSHOW
);

--process(clk)
--begin
--if clk'event and clk='1'then
----if reset='0' and control_signal(18)='1'then
--if control_signal(18)='1'then
------if control_signal(18)='1'then
----ACC_SHOW<=ACCout;
----MR_SHOW<=MRtoSHOW;
------elsif control_signal(18)='0'then
--ACC_SHOW<="0000000000010000";
--MR_SHOW<="0000000000010001";
------end if;
--else
--ACC_SHOW<=control_signal(15 downto 0);
--MR_SHOW<="0000000000011111";
--end if;
--end if;
--end process;

end Behavioral;

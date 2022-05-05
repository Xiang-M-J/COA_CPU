library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.STD_LOGIC_UNSIGNED.all;

entity DigitalSHOW is
Port (
CLK:in std_logic;
RESET:in std_logic;
From_ALUL:in std_logic_vector(15 downto 0);
From_ALUH:in std_logic_vector(15 downto 0);
digital:out std_logic_vector(7 downto 0);
digital_enable:out std_logic_vector(7 downto 0)
 );
end DigitalSHOW;


architecture Behavioral of DigitalSHOW is
signal clk_digital:std_logic;
begin
process(CLK)
variable count_div:integer range 0 to 100000;
begin 
		if (CLK'event and CLK='1') then				
			if count_div =100000 then
				count_div:=0;
            clk_digital<=not clk_digital;
			else 
				count_div:=count_div+1;
			end if;
		end if;	
end process;

process(clk_digital)
	 variable count:integer range 0 to 7;
	 variable one,two,three,four,five,six,seven,eight:std_logic_vector(3 downto 0);
	 variable highflag:std_logic:='0';
	 begin 
	 if clk_digital'event and clk_digital='1' then	
		 one:=From_ALUL(3 downto 0);
		 two:=From_ALUL(7 downto 4);
		 three:=From_ALUL(11 downto 8);
		 four:=From_ALUL(15 downto 12);
		 five:=From_ALUH(3 downto 0);
		 six:=From_ALUH(7 downto 4);
		 seven:=From_ALUH(11 downto 8);
		 eight:=From_ALUH(15 downto 12);
		 if (From_ALUH/=X"0000") then
			highflag:='1';
		 end if;
		if count=7 then
			count:=0;
		else count:=count+1;
		end if;
		if (RESET='1') then							
	 if(count=0) then							
		   digital_enable<="11111110";							
			case one is
				when "0000" => digital<="11000000"; --0		
				when "0001" => digital<="11111001"; --1
				when "0010" => digital<="10100100"; --2
				when "0011" => digital<="10110000"; --3
				when "0100" => digital<="10011001"; --4
				when "0101" => digital<="10010010"; --5
				when "0110" => digital<="10000010"; --6
				when "0111" => digital<="11111000"; --7
				when "1000" => digital<="10000000"; --8
				when "1001" => digital<="10010000"; --9
				when "1010" => digital<="10001000"; --a
				when "1011" => digital<="10000011"; --b
				when "1100" => digital<="11000110"; --c
				when "1101" => digital<="10100001"; --d
				when "1110" => digital<="10000110"; --e
				when "1111" => digital<="10001110"; --f
				when others => digital<="11111111";
			end case;	
     elsif(count=1) then					
			digital_enable<="11111101";							
			case two is
				when "0000" => digital<="11000000"; --0		
				when "0001" => digital<="11111001"; --1
				when "0010" => digital<="10100100"; --2
				when "0011" => digital<="10110000"; --3
				when "0100" => digital<="10011001"; --4
				when "0101" => digital<="10010010"; --5
				when "0110" => digital<="10000010"; --6
				when "0111" => digital<="11111000"; --7
				when "1000" => digital<="10000000"; --8
				when "1001" => digital<="10010000"; --9
				when "1010" => digital<="10001000"; --a
				when "1011" => digital<="10000011"; --b
				when "1100" => digital<="11000110"; --c
				when "1101" => digital<="10100001"; --d
				when "1110" => digital<="10000110"; --e
				when "1111" => digital<="10001110"; --f
				when others => digital<="11111111";
			end case;
     elsif(count=2) then					
			digital_enable<="11111011";							
			case three is
				when "0000" => digital<="11000000"; --0		
				when "0001" => digital<="11111001"; --1
				when "0010" => digital<="10100100"; --2
				when "0011" => digital<="10110000"; --3
				when "0100" => digital<="10011001"; --4
				when "0101" => digital<="10010010"; --5
				when "0110" => digital<="10000010"; --6
				when "0111" => digital<="11111000"; --7
				when "1000" => digital<="10000000"; --8
				when "1001" => digital<="10010000"; --9
				when "1010" => digital<="10001000"; --a
				when "1011" => digital<="10000011"; --b
				when "1100" => digital<="11000110"; --c
				when "1101" => digital<="10100001"; --d
				when "1110" => digital<="10000110"; --e
				when "1111" => digital<="10001110"; --f
				when others => digital<="11111111";
			end case;
     elsif(count=3) then					
			digital_enable<="11110111";							
			case four is
				when "0000" => digital<="11000000"; --0		
				when "0001" => digital<="11111001"; --1
				when "0010" => digital<="10100100"; --2
				when "0011" => digital<="10110000"; --3
				when "0100" => digital<="10011001"; --4
				when "0101" => digital<="10010010"; --5
				when "0110" => digital<="10000010"; --6
				when "0111" => digital<="11111000"; --7
				when "1000" => digital<="10000000"; --8
				when "1001" => digital<="10010000"; --9
				when "1010" => digital<="10001000"; --a
				when "1011" => digital<="10000011"; --b
				when "1100" => digital<="11000110"; --c
				when "1101" => digital<="10100001"; --d
				when "1110" => digital<="10000110"; --e
				when "1111" => digital<="10001110"; --f
				when others => digital<="11111111";
			end case;	
	 elsif(count=4) then					
            digital_enable<="11101111";                            
            if highflag='1' then
            case five is
                when "0000" => digital<="11000000"; --0        
                when "0001" => digital<="11111001"; --1
                when "0010" => digital<="10100100"; --2
                when "0011" => digital<="10110000"; --3
                when "0100" => digital<="10011001"; --4
                when "0101" => digital<="10010010"; --5
                when "0110" => digital<="10000010"; --6
                when "0111" => digital<="11111000"; --7
                when "1000" => digital<="10000000"; --8
                when "1001" => digital<="10010000"; --9
                when "1010" => digital<="10001000"; --a
                when "1011" => digital<="10000011"; --b
                when "1100" => digital<="11000110"; --c
                when "1101" => digital<="10100001"; --d
                when "1110" => digital<="10000110"; --e
                when "1111" => digital<="10001110"; --f
                when others => digital<="11111111";			
            end case;	
            else digital<="11000001";--u
            end if;
     elsif(count=5) then					
            digital_enable<="11011111";                            
            if highflag='1' then
            case six is
                 when "0000" => digital<="11000000"; --0        
                 when "0001" => digital<="11111001"; --1
                 when "0010" => digital<="10100100"; --2
                 when "0011" => digital<="10110000"; --3
                 when "0100" => digital<="10011001"; --4
                 when "0101" => digital<="10010010"; --5
                 when "0110" => digital<="10000010"; --6
                 when "0111" => digital<="11111000"; --7
                 when "1000" => digital<="10000000"; --8
                 when "1001" => digital<="10010000"; --9
                 when "1010" => digital<="10001000"; --a
                 when "1011" => digital<="10000011"; --b
                 when "1100" => digital<="11000110"; --c
                 when "1101" => digital<="10100001"; --d
                 when "1110" => digital<="10000110"; --e
                 when "1111" => digital<="10001110"; --f
                 when others => digital<="11111111";            
            end case;
            else digital<="10001100";--p
            end if;
     elsif(count=6) then					
            digital_enable<="10111111";                            
            if highflag='1' then
            case seven is
               when "0000" => digital<="11000000"; --0        
               when "0001" => digital<="11111001"; --1
               when "0010" => digital<="10100100"; --2
               when "0011" => digital<="10110000"; --3
               when "0100" => digital<="10011001"; --4
               when "0101" => digital<="10010010"; --5
               when "0110" => digital<="10000010"; --6
               when "0111" => digital<="11111000"; --7
               when "1000" => digital<="10000000"; --8
               when "1001" => digital<="10010000"; --9
               when "1010" => digital<="10001000"; --a
               when "1011" => digital<="10000011"; --b
               when "1100" => digital<="11000110"; --c
               when "1101" => digital<="10100001"; --d
               when "1110" => digital<="10000110"; --e
               when "1111" => digital<="10001110"; --f
               when others => digital<="11111111";            
            end case;
            else digital<="11000110";--c
            end if;
     elsif(count=7) then					
            digital_enable<="01111111";                            
            if highflag='1' then
            case eight is
               when "0000" => digital<="11000000"; --0        
               when "0001" => digital<="11111001"; --1
               when "0010" => digital<="10100100"; --2
               when "0011" => digital<="10110000"; --3
               when "0100" => digital<="10011001"; --4
               when "0101" => digital<="10010010"; --5
               when "0110" => digital<="10000010"; --6
               when "0111" => digital<="11111000"; --7
               when "1000" => digital<="10000000"; --8
               when "1001" => digital<="10010000"; --9
               when "1010" => digital<="10001000"; --a
               when "1011" => digital<="10000011"; --b
               when "1100" => digital<="11000110"; --c
               when "1101" => digital<="10100001"; --d
               when "1110" => digital<="10000110"; --e
               when "1111" => digital<="10001110"; --f
               when others => digital<="11111111";            
            end case;   		
			else digital<="11111111";
			end if;
     end if;	 
	else 
		count:=0;
 		digital_enable<="11111111";				
	end if; 
		
    end if;
		
end process; 

end Behavioral;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity z1 is
   Port (clk : in std_logic;
	 rst : in std_logic;
         
         rt1, rdy1, start1, endd1 : out std_logic;           --zad1
	 help1_o : out std_logic;
         er2 : out std_logic;                                --zad2
         er3, rdy3: out std_logic;                           --zad3
         rdy4, start4 : out std_logic;                       --zad4
	 help4 : out std_logic;
         endd5, stop5, er5, rdy5, start5 : out std_logic;    --zad5
         endd6, stop6, er6, rdy6 : out std_logic;            --zad6
         endd7, start7, status_valid7, instartsv7 : out std_logic; --zad7
         rt8, enable8 : out std_logic;                       --zad8
         rdy9, start9, interrupt9 : out std_logic;           --zad9
         ack10, req10 : out std_logic
         );            
end z1;

architecture Behavioral of z1 is

signal count : integer range 0 to 15;
signal help1 : std_logic := '1';
signal temp1 : std_logic := '1';
signal rt1_temp : std_logic;
signal rdy1_temp : std_logic;
signal start1_temp : std_logic;
signal endd1_temp : std_logic;
signal ready_next, ready_reg : std_logic := '0';
signal help_s, help_reg, help_next : std_logic := '0';
signal flag : std_logic := '0';


begin

process(clk) is   
begin
	if(rising_edge(clk)) then
		if(rst = '1') then
			count <= 0;
			ready_reg <= '0';
			help_reg <= '0';
		else
			count <= count + 1;
			ready_reg <= ready_next;
			help_reg <= help_next;
		end if;
	end if;
end process;

---------------------------------------------------------zad1

rt1 <= '1' when (count < 4) or (count = 8) else 
       '0';      

rt1_temp <= '1' when (count < 4) and (count = 8) else 
       	    '0';    

rdy1 <= '1' when (count = 5) else 
       '0';  

rdy1_temp <= '1' when (count = 5) else 
       '0';  

start1 <= '1' when (count = 8) else 
       '0'; 

start1_temp <= '1' when (count = 8) else 
       '0'; 

endd1 <= '1' when (count = 6) else 
       '0'; 

endd1_temp <= '1' when (count = 6) else 
       '0'; 

help_proc: process(clk) is
begin

	if(rising_edge(clk)) then

		if(rst = '1') then
			help1 <= '1';
			temp1 <= '1';
		else

			if(rt1_temp = '1') then
				help1 <= not(rdy1_temp or start1_temp or endd1_temp);
			elsif(temp1 = '1' and rt1_temp = '0') then
				temp1 <= '0';
				help1 <= '1';
			else
				help1 <= help1;
			end if;
		end if;

	end if;

end process;

help1_o <= help1;

---------------------------------------------------------zad2

er2 <= '1' when (count <= 2) and (count >= 1) else 
       '1' when (count <= 9) and (count >= 6) else
       '0';  

---------------------------------------------------------zad3

er3 <= '1' when (count <= 6) and (count >= 5) else 
       '1' when (count = 1) or (count = 9) else
       '0'; 
       
rdy3 <= '1' when (count <= 2) and (count >= 1) else 
       '1' when (count = 5) or (count = 9) else
       '0'; 
       
---------------------------------------------------------zad4

rdy4 <= '1' when (count = 6) else 
       '0'; 
       
start4 <= '1' when (count = 2) else 
       '0'; 

help_next <= help_s;
help4 <= help_reg;

process (ready_reg, start4, rdy4, flag) is
begin
	ready_next <= ready_reg;
	help_s <= '0';

	if(rdy4 = '1') then
		ready_next <= '1';
	end if;

	if(start4 = '1') then
		flag <= '1';
		if((ready_reg = '1' or rdy4 = '1') and (flag = '0')) then
			help_s <= '1';
		end if;
	end if;

end process;



---------------------------------------------------------zad5

endd5 <= '1' when (count = 2) else 
       '0'; 
       
er5 <= '1' when (count = 10) else 
       '0'; 
       
start5 <= '1' when (count = 8) else 
       '0'; 
       
stop5 <= '0';

rdy5 <= '1' when (count <= 2) and (count >= 1) else 
       '1' when (count <= 10) and (count >= 8) else
       '0';  

---------------------------------------------------------zad6

endd6 <= '1' when (count = 2) else 
       '0'; 

stop6 <= '1' when (count = 5) else 
       '0'; 
       
er6 <= '1' when (count = 10) else 
       '0';

rdy6 <= '1' when (count <= 2) and (count >= 1) else 
       '1' when (count <= 6) and (count >= 4) else
       '1' when (count <= 10) and (count >= 9) else
       '0';  

---------------------------------------------------------zad7

endd7 <= '1' when (count = 3) else 
         '0'; 

start7 <= '1' when (count = 5) else 
          '0'; 

status_valid7 <= '1' when (count = 5) else 
                 '0'; 

instartsv7 <= '1' when (count <= 7) and (count >= 3) else 
              '0';  

---------------------------------------------------------zad8

rt8 <= '1' when (count <= 2) else 
       '0';  
       
enable8 <= '1' when (count = 7) else 
           '0';       

---------------------------------------------------------zad9

rdy9 <= '1' when (count <= 7) and (count >= 2) else 
              '0'; 

start9 <= '1' when (count <= 7) and (count >= 5) else 
              '0'; 

interrupt9  <= '1' when (count = 7) else 
               '0'; 

---------------------------------------------------------zad10

ack10 <= '1' when (count = 6) else 
         '0'; 
               
req10 <= '1' when (count = 1) else 
         '0';                


end Behavioral;






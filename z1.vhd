
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity z1 is
   Port (clk : in std_logic;
		 rst : in std_logic;
         
         rt1, rdy1, start1, endd1 : out std_logic;           --zad1
         er2 : out std_logic;                                --zad2
         er3, rdy3: out std_logic;                           --zad3
         rdy4, start4 : out std_logic;                       --zad4
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

begin

process(rising_edge(clk)) is   
begin
	if(rst = '1') then
		count <= (others => '0';
	else
		count <= count + 1;
	end if;
end process;

---------------------------------------------------------zad1

rt1 <= '1' when (count < 4) and (count = 8) else 
       '0';         

rdy1 <= '1' when (count = 5) else 
       '0';  

start1 <= '1' when (count = 8) else 
       '0'; 

endd1 <= '1' when (count = 6) else 
       '0'; 

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






----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/19/2020 03:40:11 PM
-- Design Name: 
-- Module Name: LFSR - Behavioral
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


entity LFSR is
    Port ( inputByte : in STD_LOGIC_VECTOR (7 downto 0);
           singleShift : in STD_LOGIC :='0';
           loadEnable : in STD_LOGIC :='0';
           OutputByte : out STD_LOGIC_VECTOR (7 downto 0));
end LFSR;

architecture Behavioral of LFSR is
signal CurrentByte,tempByte : STD_LOGIC_VECTOR(7 downto 0);

begin

    
   process(singleShift,loadEnable)
    begin
        tempByte <= CurrentByte; --store tempByte 
        if(rising_edge(singleShift)) then  --when shifting once
        tempByte <= CurrentByte; --store tempByte 
        CurrentByte(0) <= tempByte(1);
        CurrentByte(1) <= tempByte(2);
        CurrentByte(2) <= tempByte(3);
        CurrentByte(3) <= tempByte(0) XNOR tempByte(4);
        CurrentByte(4) <= tempByte(0) XNOR tempByte(5);
        CurrentByte(5) <= tempByte(0) XNOR tempByte(6);
        CurrentByte(6) <= tempByte(7);
        CurrentByte(7) <= tempByte(0);
        elsif (loadEnable = '1') then
        CurrentByte <= inputByte;
        end if;
    end process;
    
    
    OutputByte <= CurrentByte;
    
end Behavioral;

----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/17/2020 12:00:20 AM
-- Design Name: 
-- Module Name: FPGAatt2 - Behavioral
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

--Designed by Alex Lukens for ECE 742 Summer 2020 Class
--This FPGA implementation of a 4-bit adder takes the first operand from the 4 switches
--available on the Digilent Arty A7 when btn3 is on the RISING_EDGE
--and the second operand on the FALLING_EDGE
--Subtraction is implemented by holding down btn(0)
--result shown on LEDs and carry out shown on rgb_led0_blue
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity FPGAatt2 is
    Port ( sw : in STD_LOGIC_VECTOR (3 downto 0);
           btn : in STD_LOGIC_VECTOR (3 downto 0);
           led0_b : out STD_LOGIC;
           led : out STD_LOGIC_VECTOR (3 downto 0));
end FPGAatt2;

component AdderSubtracter is
    Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
           B : in STD_LOGIC_VECTOR (3 downto 0);
           sel : in STD_LOGIC;
           Sum : out STD_LOGIC_VECTOR (3 downto 0);
           Cout : out STD_LOGIC);
    end component;

architecture Behavioral of FPGAatt2 is



signal op1,op2 : STD_LOGIC_VECTOR(3 downto 0);   
signal carry1 : STD_LOGIC :='0'; --carry in is static 1 to disable subtraction mode
begin
process(btn(3))
    begin
    if(rising_edge(btn(3)))
    then op1<=sw; --set first operand on rising edge
    end if;
    if(falling_edge(btn(3)))
    then op2<=sw; --set second operand on falling edge
    end if;
end process;

A1 : AdderSubtracter port map(op1,op2,btn(0),led,carry1); --4-bit adder instance
led0_b<=carry1; --led0_blue designates carry out from adder

end Behavioral;

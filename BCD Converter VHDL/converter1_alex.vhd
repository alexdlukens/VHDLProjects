----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/14/2020 11:28:47 PM
-- Design Name: 
-- Module Name: converter1_alex - Behavioral
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
-- Designed By: Alex Lukens 
--for: ECE 742 Summer 2020 Lab 1

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity converter1_alex is
    Port    (sw : in STD_LOGIC_VECTOR(3 downto 0);
            led : out STD_LOGIC_VECTOR(3 downto 0));
end converter1_alex;

architecture Behavioral of converter1_alex is
signal A2_N,A1_N,A0_N : STD_LOGIC; 
signal A,Y : STD_LOGIC_VECTOR(3 downto 0);
begin
        A2_N <= NOT A(2);
        A1_N <= NOT A(1);
        A0_N <= NOT A(0);
        A <=sw; --set input to be the BCD value given by the 4 switches on Arty A7-35t

        Y(3) <= A(3) or (A(2) and A(1)) or (A(2) and A(0));
        Y(2) <= (A(2) and A1_N and A0_N) or (A2_N and A(0)) or (A2_N and A(1));
        Y(1) <= A(1) xnor A(0); 
        Y(0) <= A0_N;
        
        
        led <= Y; --set LED pins on Arty A7-35t to be the Excess-3 BCD value
end Behavioral;

----------------------------------------------------------------------------------
-- Company: 
-- Engineer:
-- 
-- Create Date: 06/16/2020 05:01:30 PM
-- Design Name: 
-- Module Name: RippleAdder - Behavioral
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

--Created by Alex Lukens for ECE 742 Summer 2020 class
-- this program will first design a single bit adder with carry capabilities and then use this component to
-- design a more complicated 4-bit adder that utilized 4 of the single-bit adders
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity SingleAdder is
    Port ( A_in : in STD_LOGIC;
           B_in : in STD_LOGIC;
           Carry_in : in STD_LOGIC;
           Sum_out : out STD_LOGIC;
           Carry_out : out STD_LOGIC);
end SingleAdder;

architecture Behavioral of SingleAdder is

begin
    Sum_out <= A_in XOR B_in XOR Carry_in; --logic equation to find single bit 'sum' value
    Carry_out <= (A_in AND B_in AND (NOT Carry_in)) or ((NOT A_in) AND B_in AND Carry_in) or (A_in AND (NOT B_in) AND Carry_in); --find carry bit

end Behavioral;


--Below is the 4-bit adder implementation that utilized 4 of the single-bit adders designed above
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Adder4 is
    Port ( A : in STD_LOGIC_VECTOR(3 downto 0);
           B : in STD_LOGIC_VECTOR(3 downto 0);
           Cin : in std_logic; 
           Sum : out STD_LOGIC_VECTOR(3 downto 0);
           Cout : out STD_LOGIC);
end Adder4;

component SingleAdder is
Port ( A_in : in STD_LOGIC;
           B_in : in STD_LOGIC;
           Carry_in : in STD_LOGIC;
           Sum_out : out STD_LOGIC;
           Carry_out : out STD_LOGIC);
     end component;


architecture behavioral of Adder4 is


     
signal temp0,temp1,temp2 : STD_LOGIC;

begin
Add0: SingleAdder port map(A(0),B(0),Cin,Sum(0),temp0);
Add1: SingleAdder port map(A(1),B(1),temp0,Sum(1),temp1);
Add2: SingleAdder port map(A(2),B(2),temp1,Sum(2),temp2);
Add3: SingleAdder port map(A(3),B(3),temp2,Sum(3),Cout);
end behavioral;

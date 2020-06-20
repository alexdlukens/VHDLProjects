----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/16/2020 11:06:38 PM
-- Design Name: 
-- Module Name: AdderSubtracter - Behavioral
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
--4 bit adder with subtraction capabilities (using 4x SingleAdder single-bit adder components from previous design)
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity AdderSubtracter is
    Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
           B : in STD_LOGIC_VECTOR (3 downto 0);
           sel : in STD_LOGIC;
           Sum : out STD_LOGIC_VECTOR (3 downto 0);
           Cout : out STD_LOGIC);
end AdderSubtracter;

architecture Behavioral of AdderSubtracter is

component SingleAdder is
Port ( A_in : in STD_LOGIC;
           B_in : in STD_LOGIC;
           Carry_in : in STD_LOGIC;
           Sum_out : out STD_LOGIC;
           Carry_out : out STD_LOGIC);
     end component;
     
signal temp0,temp1,temp2 : STD_LOGIC;
signal B_New : STD_LOGIC_VECTOR(3 downto 0);

begin
B_New(0) <= B(0) XOR sel;
B_New(1) <= B(1) XOR sel;
B_New(2) <= B(2) XOR sel;
B_New(3) <= B(3) XOR sel;

Add0: SingleAdder port map(A(0),B_New(0),sel,Sum(0),temp0);
Add1: SingleAdder port map(A(1),B_New(1),temp0,Sum(1),temp1);
Add2: SingleAdder port map(A(2),B_New(2),temp1,Sum(2),temp2);
Add3: SingleAdder port map(A(3),B_New(3),temp2,Sum(3),Cout);
end Behavioral;


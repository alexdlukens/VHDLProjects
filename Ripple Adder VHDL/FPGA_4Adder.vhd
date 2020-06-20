----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/16/2020 10:01:00 PM
-- Design Name: 
-- Module Name: FPGA_4Adder - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity FPGA_4Adder is
    Port ( sw : in STD_LOGIC_VECTOR (3 downto 0);
           btn : in STD_LOGIC_VECTOR (3 downto 0);
           led : out STD_LOGIC_VECTOR (3 downto 0);
           led0_b : out STD_LOGIC;
           clk : in STD_LOGIC);
end FPGA_4Adder;

architecture Behavioral of FPGA_4Adder is
Component Adder4 is
Port ( A : in STD_LOGIC_VECTOR(3 downto 0);
           B : in STD_LOGIC_VECTOR(3 downto 0);
           Cin : in std_logic; 
           Sum : out STD_LOGIC_VECTOR(3 downto 0);
           Cout : out STD_LOGIC);
end component;

signal String1,String2,OutputStr : STD_LOGIC_VECTOR(3 downto 0);
signal CarryOutSig : STD_LOGIC;

begin
Adder : Adder4 port map (String1,String2,btn(3),OutputStr,CarryOutSig);

process(btn(2))
    begin
    if rising_edge(btn(2))
    then String1<=sw;
    
    
    
     end if;
    
    if falling_edge(btn(2)) 
    then String2<=sw;
    

    end if;
    
end process;

led<=OutputStr;
led0_b <= CarryOutSig;

end Behavioral;

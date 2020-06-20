----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/15/2020 06:37:47 PM
-- Design Name: 
-- Module Name: converter2_alex - Behavioral
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
use ieee.numeric_std.all;


-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity converter2_alex is
    Port ( sw : in STD_LOGIC_VECTOR (3 downto 0);
           led : out STD_LOGIC_VECTOR (3 downto 0);
           btn : in STD_LOGIC_VECTOR (3 downto 0)); -- btn(3) is used to switch between input BCD format (natural or Excess-3)
end converter2_alex;

architecture Behavioral of converter2_alex is
signal A2_N,A1_N,A0_N : STD_LOGIC; 
signal A,Y : STD_LOGIC_VECTOR(3 downto 0);
signal clk : std_logic :='1';
begin
        A <=sw; --set input to be the BCD value given by the 4 switches on Arty A7-35t
        process(btn) --run process every time btn is altered
        begin
        case btn(3) is
            when '0' => Y <= std_logic_vector(to_unsigned(to_integer(unsigned( A )) + 3, 4)); -- when button not pressed, convert from natural to Excess-3 BCD
            when '1' => Y <= std_logic_vector(to_unsigned(to_integer(unsigned( A )) - 3, 4)); -- when btn pressed, convert from Excess-3 to natural BCD
            when others => Y <= "0000";
        
        end case;
     end process;
     led <= Y; --set LED pins on Arty A7-35t to be the Excess-3 BCD value
end Behavioral;

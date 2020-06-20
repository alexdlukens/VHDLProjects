----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/18/2020 11:19:15 PM
-- Design Name: 
-- Module Name: FPGAWithButton - Behavioral
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

entity FPGAWithButton is
    Port ( btn : in STD_LOGIC_VECTOR (3 downto 0);
           CLK100MHZ : in STD_LOGIC;
           led0_r : out STD_LOGIC;
           led0_g : out STD_LOGIC;
           led3_r : out STD_LOGIC;
           led3_g : out STD_LOGIC);
end FPGAWithButton;

architecture Behavioral of FPGAWithButton is

component TrafficButton is
    port (  clk,SensorW,SensorE : in std_logic;
            ns_r, ns_y, ns_g,
            ew_r, ew_y, ew_g : out std_logic);
    end component;

component clk_divider is
    Port ( clk : in  STD_LOGIC;
           s0 : in  STD_LOGIC;
           s1 : in  STD_LOGIC;
           clk_out : out  STD_LOGIC);
end component;        

signal ns_r, ns_y, ns_g,ew_r, ew_y, ew_g : std_logic :='0';

signal clk_s0 : std_logic :='1';
signal clk_s1,final_clk : std_logic :='0'; --s0,s1,clk_out of clock divider

begin
divider : clk_divider port map (clk => CLK100MHZ, s0 => clk_s0, s1 => clk_s1,clk_out => final_clk); 
--clk divider set to produce 1 Hz clock signal

Controller : TrafficButton port map (clk => final_clk, SensorW => btn(3), SensorE => btn(0), ns_r => ns_r,
                ns_y => ns_y, ns_g => ns_g, ew_r => ew_r, ew_y => ew_y, ew_g => ew_g);
                
            led0_r <= ns_r OR ns_y;
            led0_g <= ns_g OR ns_y;
            led3_r <= ew_r OR ew_y;
            led3_g <= ew_g OR ew_y;
            
            

end Behavioral;

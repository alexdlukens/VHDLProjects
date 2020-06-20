----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/18/2020 10:55:23 PM
-- Design Name: 
-- Module Name: TrafficButton - Behavioral
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

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity TrafficButton is
    port (  clk,SensorW,SensorE : in std_logic;
            ns_r, ns_y, ns_g,
            ew_r, ew_y, ew_g : out std_logic);
end TrafficButton;

architecture behav of TrafficButton is
-- traffic light controlled by FSM with timer
-- 10 clock cycles for green

-- 1 clock cycle for yellow
-- 1 clock cycle for both red
type state_type is (s0, s1, s2, s3, s4, s5);
signal state, next_state : state_type;
signal timer : integer range 0 to 15 := 0;
signal timer_reset : std_logic := '0';
begin
    sync_process : process (clk) is
    -- synchronize state transitions and timer with clock
    begin
        if (rising_edge(clk)) then
            state <= next_state;
            if (timer_reset = '1') then
                timer <= 0; -- reset timer
            else
                timer <= timer + 1;
            end if;
        end if;
    end process;
    
    output_decode : process (state) is
    begin
        case (state) is
            when s0 =>
                -- north/south gets green
                ns_r <= '0';
                ns_y <= '0';
                ns_g <= '1';
                -- east/west gets red
                ew_r <= '1';
                ew_y <= '0';
                ew_g <= '0';
                -- hold state for 10 seconds
            when s1 =>
                -- north/south gets yellow
                ns_r <= '0';
                ns_y <= '1';
                ns_g <= '0';               

                -- east/west gets red
                
                ew_r <= '1';
                ew_y <= '0';
                ew_g <= '0';
                
            when s2 =>
                -- north/south gets red
                ns_r <= '1';
                ns_y <= '0';
                ns_g <= '0';                 

                -- east/west gets red
                ew_r <= '1';
                ew_y <= '0';
                ew_g <= '0';

            when s3 =>
                -- north/south gets red
                ns_r <= '1';
                ns_y <= '0';
                ns_g <= '0';  

                -- east/west gets green
                ew_r <= '0';
                ew_y <= '0';
                ew_g <= '1';

            when s4 =>
                -- north/south gets red
                ns_r <= '1';
                ns_y <= '0';
                ns_g <= '0';

                -- east/west gets yellow
                ew_r <= '0';
                ew_y <= '1';
                ew_g <= '0';

            when s5 =>
                -- north/south gets red
                ns_r <= '1';
                ns_y <= '0';
                ns_g <= '0';

                -- east/west gets red
                ew_r <= '1';
                ew_y <= '0';
                ew_g <= '0';

            when others =>
                -- north/south gets unknown
                ns_r <= '1';
                ns_y <= '0'; --if unknown state, make the color red
                ns_g <= '0';

                -- east/west gets unknown
                ew_r <= '1';
                ew_y <= '0';
                ew_g <= '0';
        end case;
    end process;
    
    next_state_decode : process (state, timer) is
    begin
        next_state <= s0; -- initial state
        timer_reset <= '0'; -- negate timer reset
        case (state) is
            when s0 =>
                
                if (timer = 10) then
                next_state <= s1;
                timer_reset <= '1';
                
                elsif(SensorE ='1' OR SensorW = '1') then
                next_state <=s0; --if sensor asserted stay in s0, but do not reset timer
                timer_reset <='0';                
                else
                next_state <= s0; --if no sensor asserted stay in s0 and reset timer
                timer_reset <='1';
                end if;
                

            when s1 =>
                if (timer = 1) then
                next_state <=s2;
                timer_reset <= '1';
                else
                next_state <= s1;
                end if;
            when s2 =>
                if(timer = 1) then
                next_state <= s3;
                timer_reset <= '1';
                else
                next_state <= s2;
                end if;
            when s3 =>
                if(timer = 5) then
                next_state <= s4;
                timer_reset <= '1';
                else
                next_state <= s3;
                end if;
            when s4 =>
                if(timer = 1) then
                next_state <= s5;
                timer_reset <= '1';
                else
                next_state <= s4;
                end if;
            when s5 =>
                if(timer = 1) then
                next_state <= s0;
                timer_reset <= '1';
                else
                next_state <= s5;
                end if;
            when others =>
                next_state <= s0;
        end case;
    end process;
end behav;


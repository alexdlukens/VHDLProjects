library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



Entity FPGAController is
    port(CLK100MHZ : in STD_LOGIC;
    led3_r,led3_g,led0_r,led0_g : out STD_LOGIC);
    end FPGAController;
    
    architecture Behavioral of FPGAController is
    
    Component TrafficController is
  port (    clk: in std_logic;
            ns_r, ns_y, ns_g,
            ew_r, ew_y, ew_g : out std_logic);
end component;

    component Clock_Divider is
        port ( clk,reset: in std_logic;
        clock_out: out std_logic);
    end component;

    signal
            S_R, S_Y, S_G,
            W_R, W_Y, W_G : std_logic :='0';
    signal  config_clk,rst : std_logic:='0';
    
    begin
    clockgen : Clock_Divider port map(clk => CLK100MHZ, reset => rst, clock_out => config_clk);
    light : TrafficController port map( clk =>config_clk, ns_r=> S_R, ns_y =>S_Y, ns_g =>S_G, ew_r=> W_R,ew_y => W_Y, ew_g=>W_G);
                led3_r <= S_R OR S_Y;
                led3_g <= S_G OR S_Y;
                led0_r <= W_R OR W_Y;
                led0_g <= W_G OR W_Y;           
            
     end Behavioral;
----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.11.2019 10:46:28
-- Design Name: 
-- Module Name: audio_interface - Behavioral
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

entity audio_interface is
    Port ( clk_12megas : in STD_LOGIC;
           reset : in STD_LOGIC;
           record_enable : in STD_LOGIC;
           sample_out : out STD_LOGIC_VECTOR (8 downto 0);
           sample_out_ready : out STD_LOGIC;
           micro_clk : out STD_LOGIC;
           micro_data : in STD_LOGIC;
           micro_LR : out STD_LOGIC;
           play_enable : in STD_LOGIC;
           sample_in : in STD_LOGIC_VECTOR (8 downto 0);
           sample_request : out STD_LOGIC;
           jack_sd : out STD_LOGIC;
           jack_pwm : out STD_LOGIC);
end audio_interface;

architecture Behavioral of audio_interface is

component pwm is Port(
    clk_12megas : in STD_LOGIC;
    reset : in STD_LOGIC;
    en_2_cycles: in STD_LOGIC;
    sample_in : in STD_LOGIC_VECTOR (8 downto 0);
    sample_request : out STD_LOGIC;
    pwm_pulse : out STD_LOGIC);
end component;

component en_4_cycles is
    Port ( clk_12megas : in STD_LOGIC;
           reset : in STD_LOGIC;
           clk_3megas : out STD_LOGIC;
           en_2_cycles : out STD_LOGIC;
           en_4_cycles : out STD_LOGIC);
end component;

component FSMD_microphone is
    Port ( clk_12megas : in STD_LOGIC;
           reset : in STD_LOGIC;
           enable_4_cycles : in STD_LOGIC;
           micro_data : in STD_LOGIC;
           sample_out : out STD_LOGIC_VECTOR (8 downto 0);
           sample_out_ready : out STD_LOGIC);
end component;

signal clk_3megas,en_2_cycles,enable_fsmd,enable_pwm, enable_4_cycles: std_logic;

begin
UUT: pwm port map(
    clk_12megas => clk_12megas,
    reset=>reset,
    en_2_cycles=>enable_pwm,
    sample_in=>sample_in,
    sample_request=>sample_request,
    pwm_pulse=>jack_pwm
);

UUT2: FSMD_microphone port map
(          clk_12megas =>clk_12megas,
           reset => reset,
           enable_4_cycles =>enable_fsmd,
           micro_data=>micro_data,
           sample_out =>sample_out,
           sample_out_ready =>sample_out_ready
           ); 

UUT3:en_4_cycles port map
(       clk_12megas=>clk_12megas,
        reset=>reset,
        clk_3megas=>micro_clk,
        en_2_cycles=>en_2_cycles,
        en_4_cycles=>enable_4_cycles
        );

enable_fsmd <= record_enable and enable_4_cycles;
enable_pwm<= play_enable and en_2_cycles;
micro_LR<='1';
jack_sd<='1';

end Behavioral;

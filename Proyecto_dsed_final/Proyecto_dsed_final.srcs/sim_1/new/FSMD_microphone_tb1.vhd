----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.11.2019 12:01:30
-- Design Name: 
-- Module Name: FSMD_microphone_tb1 - Behavioral
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

entity FSMD_microphone_tb1 is
--  Port ( );
end FSMD_microphone_tb1;

architecture Behavioral of FSMD_microphone_tb1 is
component FSMD_microphone is
    Port ( clk_12megas : in STD_LOGIC;
           reset : in STD_LOGIC;
           enable_4_cycles : in STD_LOGIC;
           micro_data : in STD_LOGIC;
           sample_out : out STD_LOGIC_VECTOR (8 downto 0);
           sample_out_ready : out STD_LOGIC);
end component;

component en_4_cycles is
    Port ( clk_12megas : in STD_LOGIC;
           reset : in STD_LOGIC;
           clk_3megas : out STD_LOGIC;
           en_2_cycles : out STD_LOGIC;
           en_4_cycles : out STD_LOGIC);
end component;

signal clk_12megas,reset,enable_4_cycles,micro_data,sample_out_ready ,clk_3megas,en_2_cycles: std_logic;
signal sample_out : std_logic_vector (8 downto 0);
constant clk_period : time := 84 ns; 

begin

UUT: FSMD_microphone port map
(          clk_12megas =>clk_12megas,
           reset => reset,
           enable_4_cycles =>enable_4_cycles,
           micro_data=>micro_data,
           sample_out =>sample_out,
           sample_out_ready =>sample_out_ready
           );

UUT2:en_4_cycles port map
(       clk_12megas=>clk_12megas,
        reset=>reset,
        clk_3megas=>clk_3megas,
        en_2_cycles=>en_2_cycles,
        en_4_cycles=>enable_4_cycles
        );


clk_process :process 
begin
    clk_12megas <= '0';
    wait for clk_period/2;
    clk_12megas <= '1';
    wait for clk_period/2;
end process;

process
begin
micro_data<='1';
reset<='0';
wait;
end process;
end Behavioral;

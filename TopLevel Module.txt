----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:27:11 11/20/2022 
-- Design Name: 
-- Module Name:    TopLevel - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity TopLevel is
    Port ( debouncebutton : in  STD_LOGIC;
           X : in  STD_LOGIC;
           Y : out  STD_LOGIC;
           reset : in  STD_LOGIC;
			  clk: in STD_LOGIC);
end TopLevel;

architecture Behavioral of TopLevel is

component dbounce is
port ( push_bt : in  STD_LOGIC;

           cclk : in  STD_LOGIC;

           debounce_out : out  STD_LOGIC);
end component;

component Statemachine is



Port ( clk : in STD_LOGIC;



switch : in STD_LOGIC;



rst : in STD_LOGIC;



led : out STD_LOGIC);



end component;

signal output:std_logic;

begin 

deb: dbounce port map (debouncebutton,clk,output);

state: Statemachine port map (output,X,reset,Y);

end Behavioral;


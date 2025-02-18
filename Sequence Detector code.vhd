------------------------------
DEBOUNCE CODE
------------------------------

----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:50:52 11/15/2022 
-- Design Name: 
-- Module Name:    lab6_debounce - Behavioral 
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

entity lab6_debounce is
    Port ( push_button : in  STD_LOGIC;
           clock : in  STD_LOGIC;
           debounce_out : out  STD_LOGIC);
end lab6_debounce;

architecture Behavioral of lab6_debounce is

signal d1, d2, reset, cout : std_logic;
signal count : std_logic_vector (20 downto 0);

begin

reset <= d1 xor d2;
FF: process(cclk)

begin

if(cclk'event and cclk = '1') then
	d1 <= push_bt;
	d2 <= d1;

if(cout = '1') then
	debounce_out <= d2;
	end if;
	end if;
end process;

CNTR: process(cclk, reset)

begin
	if(reset='1') then
	count <= (others=>'0');
	elsif (cclk'event and cclk='1') then
	if (cout = '0') then
	count <= count + 1;
	end if;
	end if;
end process;

cout <= count(20);

end Behavioral;


--------------------------------------------------------
3 IMPLEMENTATION STATE MACHINE 
--------------------------------------------------------

entity state_machine is
port (reset, clk, x: in std_logic;
      z: out std_logic);
end entity state_machine;

architecture behavioral of state_machine is
    type statetype is (state0, state1, state2, state3,state4);
    signal present_state, next_state: statetype:= state0;

begin

output_process: process(present_state) is
begin
   case present_state is               -- depending upon the current state only 
      when state0 =>                   -- set output signals 
         z <= '1';
      when state1 =>
         z <= '1';
      when state2 =>
         z <= '0';
      when state3 =>
         z <= '1';
      when state4 =>
	 z <= '0';
   end case; 
end process output_process;

next_state_process: process(present_state,x) is
begin
   case present_state is               -- depending upon the current state and input
      when state0 =>                   -- set next state
         if x = '1' then
            next_state <= state1;
         else
            next_state <= state0;
         end if;
      when state1 =>
         if x = '1' then
            next_state <= state2;
         else
            next_state <= state0;
         end if;
      when state2 =>
         if x = '1' then
            next_state <= state2;
         else
            next_state <= state3;
         end if;
      when state3 =>
         if x = '1' then
            next_state <= state4;
         else
            next_state <= state0;
         end if;
      when state4 =>
	 if x='1' then
	    next_state<=state2;
	 else
	    next_state<=state0;	
   end case; 
end process next_state_process;

clk_process: process is
begin
    wait until (rising_edge(clk));       -- wait until the rising edge
    if reset = '1' then                  -- check for reset and initialize state
      present_state <= statetype'left;
    else
      present_state <= next_state;
    end if;
end process clk_process;
end architecture behavioral;

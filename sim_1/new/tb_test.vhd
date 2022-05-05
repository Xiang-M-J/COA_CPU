library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
entity tb_test is
end tb_test;

architecture test of tb_test is
component test
port(
  clk:in std_logic;
  reset: in std_logic;
  switch_MRACC:in std_logic;
  digital_enable: out std_logic_vector(7 downto 0);
  digital: out std_logic_vector(7 downto 0)
);
end component;
signal  clk: std_logic;
signal  reset: std_logic:='0';
signal  switch_MRACC: std_logic;
signal  digital_enable:  std_logic_vector(7 downto 0);
signal  digital: std_logic_vector(7 downto 0);
begin
instant:test port map(clk=>clk,reset=>reset,switch_MRACC=>switch_MRACC,
digital_enable=>digital_enable,digital=>digital);
clk_gen:process
begin
clk<='0';
wait for 50ns;
clk<='1';
wait for 50ns;
end process;

switch_MRACC_gen:process
begin
switch_MRACC<='1';
wait for 20ms;
switch_MRACC<='0';
wait for 20ms;
end process;
end test;

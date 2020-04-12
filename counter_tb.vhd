library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library pck_lib;
use pck_lib.sim.all;
use pck_lib.types.all;

library counter_lib;

entity counter_tb is
end counter_tb; 

architecture sim of counter_tb is

  constant clk_counter_max : integer := 100;

  signal clk : std_logic := '1';
  signal rst : std_logic := '1';
  signal value : value_type;

begin

  clk <= not clk after sim_clk_period / 2;

  DUT : entity counter_lib.counter(rtl)
    generic map (
      clk_counter_max => clk_counter_max
    )
    port map (
      clk => clk,
      rst => rst,
      value => value
    );

  SEQUENCER_PROC : process
  begin
    wait for sim_clk_period * 2;
    rst <= '0';

    wait for sim_clk_period * 10;

    for i in 0 to 99 loop
      
      report "Checking value = " & integer'image(i);
      assert value = i
        report "value = " & integer'image(value) &
          ", should have been " & integer'image(i)
          severity failure;

      wait for clk_counter_max * sim_clk_period;

    end loop;

    report "Checking wrap value = 0";
    assert value = 0
      report "value = " & integer'image(value) & ", should have been 0"
      severity failure; 

    print_ok_and_finish;
  end process;

end architecture;
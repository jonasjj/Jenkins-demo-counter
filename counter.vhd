library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library pck_lib;
use pck_lib.constants.all;
use pck_lib.types.all;

entity counter is
  generic (
    clk_counter_max : integer := value_clk_counter_max
  );
  port (
    clk : in std_logic;
    rst : in std_logic;
    value : out value_type
  );
end counter; 

architecture rtl of counter is

  signal cnt : integer range 0 to clk_counter_max - 1;
  signal value_i : value_type;

begin

  value <= value_i;

  COUNTER : process(clk)
  begin
    if rising_edge(clk) then
      if rst = '1' then
        cnt <= 0;
        value_i <= 0;
        
      else

        if cnt = clk_counter_max - 1 then
          cnt <= 0;

          if value_i = value_type'high then
            value_i <= 0;
          else
            value_i <= value_i + 1;
          end if;
        
        else
          cnt <= cnt + 1;
        end if;
        
      end if;
    end if;
  end process;

end architecture;
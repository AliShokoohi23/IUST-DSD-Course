----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:08:58 10/31/2023 
-- Design Name: 
-- Module Name:    ex4 - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ex4 is
    Port ( START : in  STD_LOGIC;
           STOP : in  STD_LOGIC;
           RESTART : in  STD_LOGIC;
           GCLK : in  STD_LOGIC;
           LED : out  STD_LOGIC_VECTOR (15 downto 0);
           SEG_DATA : out  STD_LOGIC_VECTOR (7 downto 0);
           SEG_SEL : out  STD_LOGIC_VECTOR (4 downto 0);
           BUZZER : out  STD_LOGIC);
end ex4;

architecture Behavioral of ex4 is
	signal CLK10MS, CLK1S : STD_LOGIC;
	signal SEG_DATA_reg1, SEG_DATA_reg2, SEG_DATA_reg3, SEG_DATA_reg4 : STD_LOGIC_VECTOR (7 downto 0);
	signal COUNTER2, COUNTER3, COUNTER4 : STD_LOGIC;
	signal BCD1, BCD2, BCD3, BCD4 : STD_LOGIC_VECTOR (3 downto 0);
	signal COUNT_ENABLE : STD_LOGIC;
	signal ALARM : STD_LOGIC;
begin

-- start, stop counter
process(GCLK, START, STOP)
	variable state : boolean;
begin
	if (rising_edge(GCLK)) then
		if (START = '0') then
			state := true;
		elsif (STOP = '0') then
			state := false;
		end if;

		if state then
			COUNT_ENABLE <= '1';
		else
			COUNT_ENABLE <= '0';
		end if;
	end if;
end process;

-- 10 millisecond delay signal
process(GCLK)
	variable count_div : integer range 0 to 100000 :=0;
begin
	if (rising_edge(GCLK)) then
		if count_div < 80000 then
			count_div := count_div + 1 ;
		else
			count_div := 0;
			CLK10MS <= not CLK10MS;
		end if;
	end if;
end process;

-- 1 second delay signal
process(CLK10MS)
	variable count_div : integer range 0 to 125 :=0;
begin
	if (rising_edge(CLK10MS)) then
		if count_div < 125 then
			count_div := count_div + 1 ;
		else
			count_div := 0;
			CLK1S <= not CLK1S;
		end if;
	end if;
end process;

-- BCD counters
process (CLK1S, RESTART)
	variable counter : integer range 0 to 10 := 0;
begin
	if (RESTART = '0') then
		counter := 0;
	elsif (rising_edge(CLK1S)) then
		if (COUNT_ENABLE = '1') then
			if counter < 9 then
				counter := counter + 1;
				COUNTER2 <= '0';
			else
				counter := 0;
				COUNTER2 <= '1';
			end if;
		end if;
	end if;
	BCD1 <=  std_logic_vector (to_unsigned(counter, 4));
end process;

process (COUNTER2, RESTART)
	variable counter : integer range 0 to 6 := 0;
begin
	if (RESTART = '0') then
		counter := 0;
	elsif (rising_edge(COUNTER2)) then
		if (COUNT_ENABLE = '1') then
			if counter < 5 then
				counter := counter + 1;
				COUNTER3 <= '0';
			else
				counter := 0;
				COUNTER3 <= '1';
			end if;
		end if;
	end if;
	BCD2 <=  std_logic_vector (to_unsigned(counter, 4));
end process;

process (COUNTER3, RESTART)
	variable counter : integer range 0 to 10 := 0;
begin
	if (RESTART = '0') then
		counter := 0;
	elsif (rising_edge(COUNTER3)) then
		if (COUNT_ENABLE = '1') then
			if counter < 9 then
				counter := counter + 1;
				COUNTER4 <= '0';
			else
				counter := 0;
				COUNTER4 <= '1';
			end if;
		end if;
	end if;
	BCD3 <=  std_logic_vector (to_unsigned(counter, 4));
end process;

process (COUNTER4, RESTART)
	variable counter : integer range 0 to 6 := 0;
begin
	if (RESTART = '0') then
		counter := 0;
	elsif (rising_edge(COUNTER4)) then
		if (COUNT_ENABLE = '1') then
			if counter < 5 then
				counter := counter + 1;
			else
				counter := 0;
			end if;
		end if;
	end if;
	BCD4 <=  std_logic_vector (to_unsigned(counter, 4));
end process;

-- BCD to 7 segment convertors
process(BCD1)
begin
	case BCD1 is
		when "0000" => SEG_DATA_reg1 <= "00111111";
		when "0001" => SEG_DATA_reg1 <= "00000110";
		when "0010" => SEG_DATA_reg1 <= "01011011";
		when "0011" => SEG_DATA_reg1 <= "01001111";
		when "0100" => SEG_DATA_reg1 <= "01100110";
		when "0101" => SEG_DATA_reg1 <= "01101101";
		when "0110" => SEG_DATA_reg1 <= "01111101";
		when "0111" => SEG_DATA_reg1 <= "00000111";
		when "1000" => SEG_DATA_reg1 <= "01111111";
		when "1001" => SEG_DATA_reg1 <= "01101111";
		when others => SEG_DATA_reg1 <= "00000000";
	end case;
end process;

process(BCD2)
begin
	case BCD2 is
		when "0000" => SEG_DATA_reg2 <= "00111111";
		when "0001" => SEG_DATA_reg2 <= "00000110";
		when "0010" => SEG_DATA_reg2 <= "01011011";
		when "0011" => SEG_DATA_reg2 <= "01001111";
		when "0100" => SEG_DATA_reg2 <= "01100110";
		when "0101" => SEG_DATA_reg2 <= "01101101";
		when "0110" => SEG_DATA_reg2 <= "01111101";
		when "0111" => SEG_DATA_reg2 <= "00000111";
		when "1000" => SEG_DATA_reg2 <= "01111111";
		when "1001" => SEG_DATA_reg2 <= "01101111";
		when others => SEG_DATA_reg2 <= "00000000";
	end case;
end process;

process(BCD3)
begin
	case BCD3 is
		when "0000" => SEG_DATA_reg3 <= "00111111";
		when "0001" => SEG_DATA_reg3 <= "00000110";
		when "0010" => SEG_DATA_reg3 <= "01011011";
		when "0011" => SEG_DATA_reg3 <= "01001111";
		when "0100" => SEG_DATA_reg3 <= "01100110";
		when "0101" => SEG_DATA_reg3 <= "01101101";
		when "0110" => SEG_DATA_reg3 <= "01111101";
		when "0111" => SEG_DATA_reg3 <= "00000111";
		when "1000" => SEG_DATA_reg3 <= "01111111";
		when "1001" => SEG_DATA_reg3 <= "01101111";
		when others => SEG_DATA_reg3 <= "00000000";
	end case;
end process;

process(BCD4)
begin
	case BCD4 is
		when "0000" => SEG_DATA_reg4 <= "00111111";
		when "0001" => SEG_DATA_reg4 <= "00000110";
		when "0010" => SEG_DATA_reg4 <= "01011011";
		when "0011" => SEG_DATA_reg4 <= "01001111";
		when "0100" => SEG_DATA_reg4 <= "01100110";
		when "0101" => SEG_DATA_reg4 <= "01101101";
		when "0110" => SEG_DATA_reg4 <= "01111101";
		when "0111" => SEG_DATA_reg4 <= "00000111";
		when "1000" => SEG_DATA_reg4 <= "01111111";
		when "1001" => SEG_DATA_reg4 <= "01101111";
		when others => SEG_DATA_reg4 <= "00000000";
	end case;
end process;

-- LED Assignment
LED(3 downto 0) <= BCD1;
LED(7 downto 4) <= BCD2;
LED(11 downto 8) <= BCD3;
LED(15 downto 12) <= BCD4;

-- Alarm signal
process (BCD1, BCD2, BCD3, BCD4)
begin
	if (BCD4 = "0000" and BCD3 = "0000" and BCD2 = "0000" and BCD1 = "1001") then
		ALARM <= '1';
	else
		ALARM <= '0';
	end if;
end process;

-- display refresher
process(CLK10MS)
	variable RefreshSEG : integer range 0 to 4 := 0;
begin
	if (rising_edge(CLK10MS)) then
		if RefreshSEG < 4 then
			RefreshSEG := RefreshSEG + 1 ;
		else RefreshSEG := 0;
		end if;
		case RefreshSEG is
			when 0 =>
				SEG_SEL(4) <='0';
				SEG_SEL(0) <='1';
				SEG_DATA <= SEG_DATA_reg1;
			when 1 =>
				SEG_SEL(0) <='0';
				SEG_SEL(1) <='1';
				SEG_DATA <= SEG_DATA_reg2;
			when 2 =>
				SEG_SEL(1) <='0';
				SEG_SEL(2) <='1';
				SEG_DATA <= SEG_DATA_reg3;
			when 3 =>
				SEG_SEL(2) <='0';
				SEG_SEL(3) <='1';
				SEG_DATA <= SEG_DATA_reg4;
			when 4 =>
				SEG_SEL(3) <='0';
				SEG_SEL(4) <='1';
				-- assign double dot
				SEG_DATA(0) <= BCD1(0);
				SEG_DATA(1) <= BCD1(0);
				SEG_DATA(7 downto 2) <= "000000";
			when others => null;
		end case;
	end if;
end process;

-- buzzer controller
process(CLK1S)
   variable idle : boolean;
begin
   if rising_edge(CLK1S) then
      BUZZER <= '0';
      if idle then
         if ALARM = '1' then
            BUZZER <= '1';
            idle := false;
         end if;
      else
         if ALARM = '0' then
            idle := true;
         end if;
      end if;
  end if;
end process;

end Behavioral;



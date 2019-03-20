


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_soclw_fsm is
end tb_soclw_fsm;

architecture Behavioral of tb_soclw_fsm is
component soclw_fsm is
    Port ( 
        clock           :   in std_logic;
        reset           :   in std_logic;
        key_gen_start   :   out std_logic; -- 2 signal for key generator
        key_gen_done    :   in  std_logic;
        key_exch_start  :   out std_logic; -- 2 signal for key exchange
        key_exch_done   :   in  std_logic;
        key_mem_start   :   out std_logic;-- 2 signal for key memory
        key_mem_done    :   in  std_logic;
        enc_start       :   out std_logic;-- 2 signal for encryption process 
        enc_done        :   in  std_logic   
    );
end component;

        signal clock            :   std_logic;
        signal reset            :   std_logic;
        signal key_gen_start    :   std_logic; -- 2 signal for key generator
        signal key_gen_done     :   std_logic;
        signal key_exch_start   :   std_logic; -- 2 signal for key exchange
        signal key_exch_done    :   std_logic;
        signal key_mem_start    :   std_logic;-- 2 signal for key memory
        signal key_mem_done     :   std_logic;
        signal enc_start        :   std_logic;-- 2 signal for encryption process 
        signal enc_done         :   std_logic;  
        
        constant clk_period : time := 100 ns;

begin
    fsm:soclw_fsm port map(clock,reset,key_gen_start,key_gen_done,key_exch_start,key_exch_done,key_mem_start,key_mem_done,enc_start,enc_done);

clock_in:process
begin    
        clock <= '0';
        wait for clk_period/2;  
        clock <= '1';
        wait for clk_period/2;  
end process;

pump_input:process
begin
        wait for 100ns;
        key_gen_done    <= '1';
        key_exch_done   <= '0';
        key_mem_done    <= '0';
        enc_done        <= '0';   

        wait for 100ns;
        key_gen_done    <= '0';
        key_exch_done   <= '1';
        key_mem_done    <= '0';
        enc_done        <= '0';   

        wait for 100ns;
        key_gen_done    <= '0';
        key_exch_done   <= '0';
        key_mem_done    <= '1';
        enc_done        <= '0';   

        wait for 100ns;
        key_gen_done    <= '0';
        key_exch_done   <= '0';
        key_mem_done    <= '0';
        enc_done        <= '1';   

        wait;
end process;

end Behavioral;

-- muhammad saufy rohmad
-- phd code for soclw
-- uitm mac 2019

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity soclw_fsm is
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
end soclw_fsm;

architecture Behavioral of soclw_fsm is
    type state_soclw    is (idle,key_gen,key_exch,key_mem,enc);
    signal  soclw_state:state_soclw;
    
begin
    process(reset,clock,key_gen_done,key_exch_done,key_mem_done,enc_done)
    begin
        if reset='0' then
            soclw_state<=idle;
        elsif(clock'event and clock='1')then
            case soclw_state is
                when idle =>
                    key_gen_start <= '1';
                    soclw_state <= key_gen;
                when key_gen =>
                    if key_gen_done = '1' then
                        soclw_state <= key_exch;
                        key_exch_start <= '1';
                    else
                        soclw_state <= key_gen;
                    end if;                   
                when key_exch =>
                    if key_exch_done = '1' then
                        soclw_state <= key_mem;
                        key_mem_start <= '1';
                    else
                        soclw_state <= key_exch;
                    end if;
                when key_mem =>
                    if key_mem_done = '1' then
                        soclw_state <= enc;
                        enc_start <= '1';
                    else
                        soclw_state <= key_mem;
                    end if;
                when enc =>
                    if enc_done = '1' then
                        soclw_state <= idle;
                    else
                        soclw_state <=enc;
                    end if;
             end case;
        end if;
    end process; 
                
    
end Behavioral;

--Legal Notice: (C)2010 Altera Corporation. All rights reserved.  Your
--use of Altera Corporation's design tools, logic functions and other
--software and tools, and its AMPP partner logic functions, and any
--output files any of the foregoing (including device programming or
--simulation files), and any associated documentation or information are
--expressly subject to the terms and conditions of the Altera Program
--License Subscription Agreement or other applicable license agreement,
--including, without limitation, that your use is for the sole purpose
--of programming logic devices manufactured by Altera and sold by Altera
--or its authorized distributors.  Please refer to the applicable
--agreement for further details.


-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity porta is 
        port (
              -- inputs:
                 signal address : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
                 signal chipselect : IN STD_LOGIC;
                 signal clk : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;
                 signal write_n : IN STD_LOGIC;
                 signal writedata : IN STD_LOGIC_VECTOR (7 DOWNTO 0);

              -- outputs:
                 signal bidir_port : INOUT STD_LOGIC_VECTOR (7 DOWNTO 0);
                 signal irq : OUT STD_LOGIC;
                 signal readdata : OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
              );
end entity porta;


architecture europa of porta is
                signal clk_en :  STD_LOGIC;
                signal data_dir :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal data_in :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal data_out :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal irq_mask :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal out_clear_wr_strobe :  STD_LOGIC;
                signal read_mux_out :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal wr_strobe :  STD_LOGIC;

begin

  clk_en <= std_logic'('1');
  --s1, which is an e_avalon_slave
  read_mux_out <= (((A_REP(to_std_logic((((std_logic_vector'("00000000000000000000000000000") & (address)) = std_logic_vector'("00000000000000000000000000000000")))), 8) AND data_in)) OR ((A_REP(to_std_logic((((std_logic_vector'("00000000000000000000000000000") & (address)) = std_logic_vector'("00000000000000000000000000000001")))), 8) AND data_dir))) OR ((A_REP(to_std_logic((((std_logic_vector'("00000000000000000000000000000") & (address)) = std_logic_vector'("00000000000000000000000000000010")))), 8) AND irq_mask));
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      readdata <= std_logic_vector'("00000000");
    elsif clk'event and clk = '1' then
      if std_logic'(clk_en) = '1' then 
        readdata <= read_mux_out;
      end if;
    end if;

  end process;

  out_clear_wr_strobe <= (chipselect AND NOT write_n) AND to_std_logic((((std_logic_vector'("00000000000000000000000000000") & (address)) = std_logic_vector'("00000000000000000000000000000101"))));
  wr_strobe <= chipselect AND NOT write_n;
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      data_out(0) <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(clk_en) = '1' then 
        if std_logic'((out_clear_wr_strobe AND writedata(0))) = '1' then 
          data_out(0) <= std_logic'('0');
        elsif std_logic'(wr_strobe) = '1' then 
          data_out(0) <= Vector_To_Std_Logic(A_WE_StdLogicVector((((((std_logic_vector'("00000000000000000000000000000") & (address)) = std_logic_vector'("00000000000000000000000000000100"))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(writedata(0)))) = std_logic_vector'("00000000000000000000000000000001"))))), std_logic_vector'("00000000000000000000000000000001"), (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(A_WE_StdLogic((((std_logic_vector'("00000000000000000000000000000") & (address)) = std_logic_vector'("00000000000000000000000000000000"))), writedata(0), data_out(0)))))));
        end if;
      end if;
    end if;

  end process;

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      data_out(1) <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(clk_en) = '1' then 
        if std_logic'((out_clear_wr_strobe AND writedata(1))) = '1' then 
          data_out(1) <= std_logic'('0');
        elsif std_logic'(wr_strobe) = '1' then 
          data_out(1) <= Vector_To_Std_Logic(A_WE_StdLogicVector((((((std_logic_vector'("00000000000000000000000000000") & (address)) = std_logic_vector'("00000000000000000000000000000100"))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(writedata(1)))) = std_logic_vector'("00000000000000000000000000000001"))))), std_logic_vector'("00000000000000000000000000000001"), (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(A_WE_StdLogic((((std_logic_vector'("00000000000000000000000000000") & (address)) = std_logic_vector'("00000000000000000000000000000000"))), writedata(1), data_out(1)))))));
        end if;
      end if;
    end if;

  end process;

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      data_out(2) <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(clk_en) = '1' then 
        if std_logic'((out_clear_wr_strobe AND writedata(2))) = '1' then 
          data_out(2) <= std_logic'('0');
        elsif std_logic'(wr_strobe) = '1' then 
          data_out(2) <= Vector_To_Std_Logic(A_WE_StdLogicVector((((((std_logic_vector'("00000000000000000000000000000") & (address)) = std_logic_vector'("00000000000000000000000000000100"))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(writedata(2)))) = std_logic_vector'("00000000000000000000000000000001"))))), std_logic_vector'("00000000000000000000000000000001"), (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(A_WE_StdLogic((((std_logic_vector'("00000000000000000000000000000") & (address)) = std_logic_vector'("00000000000000000000000000000000"))), writedata(2), data_out(2)))))));
        end if;
      end if;
    end if;

  end process;

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      data_out(3) <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(clk_en) = '1' then 
        if std_logic'((out_clear_wr_strobe AND writedata(3))) = '1' then 
          data_out(3) <= std_logic'('0');
        elsif std_logic'(wr_strobe) = '1' then 
          data_out(3) <= Vector_To_Std_Logic(A_WE_StdLogicVector((((((std_logic_vector'("00000000000000000000000000000") & (address)) = std_logic_vector'("00000000000000000000000000000100"))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(writedata(3)))) = std_logic_vector'("00000000000000000000000000000001"))))), std_logic_vector'("00000000000000000000000000000001"), (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(A_WE_StdLogic((((std_logic_vector'("00000000000000000000000000000") & (address)) = std_logic_vector'("00000000000000000000000000000000"))), writedata(3), data_out(3)))))));
        end if;
      end if;
    end if;

  end process;

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      data_out(4) <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(clk_en) = '1' then 
        if std_logic'((out_clear_wr_strobe AND writedata(4))) = '1' then 
          data_out(4) <= std_logic'('0');
        elsif std_logic'(wr_strobe) = '1' then 
          data_out(4) <= Vector_To_Std_Logic(A_WE_StdLogicVector((((((std_logic_vector'("00000000000000000000000000000") & (address)) = std_logic_vector'("00000000000000000000000000000100"))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(writedata(4)))) = std_logic_vector'("00000000000000000000000000000001"))))), std_logic_vector'("00000000000000000000000000000001"), (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(A_WE_StdLogic((((std_logic_vector'("00000000000000000000000000000") & (address)) = std_logic_vector'("00000000000000000000000000000000"))), writedata(4), data_out(4)))))));
        end if;
      end if;
    end if;

  end process;

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      data_out(5) <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(clk_en) = '1' then 
        if std_logic'((out_clear_wr_strobe AND writedata(5))) = '1' then 
          data_out(5) <= std_logic'('0');
        elsif std_logic'(wr_strobe) = '1' then 
          data_out(5) <= Vector_To_Std_Logic(A_WE_StdLogicVector((((((std_logic_vector'("00000000000000000000000000000") & (address)) = std_logic_vector'("00000000000000000000000000000100"))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(writedata(5)))) = std_logic_vector'("00000000000000000000000000000001"))))), std_logic_vector'("00000000000000000000000000000001"), (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(A_WE_StdLogic((((std_logic_vector'("00000000000000000000000000000") & (address)) = std_logic_vector'("00000000000000000000000000000000"))), writedata(5), data_out(5)))))));
        end if;
      end if;
    end if;

  end process;

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      data_out(6) <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(clk_en) = '1' then 
        if std_logic'((out_clear_wr_strobe AND writedata(6))) = '1' then 
          data_out(6) <= std_logic'('0');
        elsif std_logic'(wr_strobe) = '1' then 
          data_out(6) <= Vector_To_Std_Logic(A_WE_StdLogicVector((((((std_logic_vector'("00000000000000000000000000000") & (address)) = std_logic_vector'("00000000000000000000000000000100"))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(writedata(6)))) = std_logic_vector'("00000000000000000000000000000001"))))), std_logic_vector'("00000000000000000000000000000001"), (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(A_WE_StdLogic((((std_logic_vector'("00000000000000000000000000000") & (address)) = std_logic_vector'("00000000000000000000000000000000"))), writedata(6), data_out(6)))))));
        end if;
      end if;
    end if;

  end process;

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      data_out(7) <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(clk_en) = '1' then 
        if std_logic'((out_clear_wr_strobe AND writedata(7))) = '1' then 
          data_out(7) <= std_logic'('0');
        elsif std_logic'(wr_strobe) = '1' then 
          data_out(7) <= Vector_To_Std_Logic(A_WE_StdLogicVector((((((std_logic_vector'("00000000000000000000000000000") & (address)) = std_logic_vector'("00000000000000000000000000000100"))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(writedata(7)))) = std_logic_vector'("00000000000000000000000000000001"))))), std_logic_vector'("00000000000000000000000000000001"), (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(A_WE_StdLogic((((std_logic_vector'("00000000000000000000000000000") & (address)) = std_logic_vector'("00000000000000000000000000000000"))), writedata(7), data_out(7)))))));
        end if;
      end if;
    end if;

  end process;

  bidir_port(0) <= A_WE_StdLogic((std_logic'(data_dir(0)) = '1'), data_out(0), std_logic'('Z'));
  bidir_port(1) <= A_WE_StdLogic((std_logic'(data_dir(1)) = '1'), data_out(1), std_logic'('Z'));
  bidir_port(2) <= A_WE_StdLogic((std_logic'(data_dir(2)) = '1'), data_out(2), std_logic'('Z'));
  bidir_port(3) <= A_WE_StdLogic((std_logic'(data_dir(3)) = '1'), data_out(3), std_logic'('Z'));
  bidir_port(4) <= A_WE_StdLogic((std_logic'(data_dir(4)) = '1'), data_out(4), std_logic'('Z'));
  bidir_port(5) <= A_WE_StdLogic((std_logic'(data_dir(5)) = '1'), data_out(5), std_logic'('Z'));
  bidir_port(6) <= A_WE_StdLogic((std_logic'(data_dir(6)) = '1'), data_out(6), std_logic'('Z'));
  bidir_port(7) <= A_WE_StdLogic((std_logic'(data_dir(7)) = '1'), data_out(7), std_logic'('Z'));
  data_in <= bidir_port;
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      data_dir <= std_logic_vector'("00000000");
    elsif clk'event and clk = '1' then
      if std_logic'(((chipselect AND NOT write_n) AND to_std_logic((((std_logic_vector'("00000000000000000000000000000") & (address)) = std_logic_vector'("00000000000000000000000000000001")))))) = '1' then 
        data_dir <= writedata(7 DOWNTO 0);
      end if;
    end if;

  end process;

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      irq_mask <= std_logic_vector'("00000000");
    elsif clk'event and clk = '1' then
      if std_logic'(((chipselect AND NOT write_n) AND to_std_logic((((std_logic_vector'("00000000000000000000000000000") & (address)) = std_logic_vector'("00000000000000000000000000000010")))))) = '1' then 
        irq_mask <= writedata(7 DOWNTO 0);
      end if;
    end if;

  end process;

  irq <= or_reduce(((data_in AND irq_mask)));

end europa;

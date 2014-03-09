library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity test is
port(
		clkin_50  :in std_logic;
		reset : in std_logic;
		button: in std_logic_vector(7 downto 0);
		led		:out std_logic_vector(7 downto 0)
--		porta : inout std_logic_vector(7 downto 0);
--		hsmb_gnds:out std_logic_vector(19 downto 0);
--		lcd_en: out std_logic;
--		lcd_rs: out std_logic;
--		lcd_rw: out std_logic;
--		lcd_data: inout std_logic_vector(7 downto 0);
--		miso :in std_logic;
--		mosi,sclk,ss_n:out std_logic
		);
end entity;

architecture arch_test of test is
--component my_processor is 
--           port (
--                 -- 1) global signals:
--                    signal clk_0 : IN STD_LOGIC;
--                    signal reset_n : IN STD_LOGIC;
--
--                 -- the_button
--                    signal in_port_to_the_button : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
--
--                 -- the_lcd_0
--                    signal LCD_E_from_the_lcd_0 : OUT STD_LOGIC;
--                    signal LCD_RS_from_the_lcd_0 : OUT STD_LOGIC;
--                    signal LCD_RW_from_the_lcd_0 : OUT STD_LOGIC;
--                    signal LCD_data_to_and_from_the_lcd_0 : INOUT STD_LOGIC_VECTOR (7 DOWNTO 0);
--
--                 -- the_porta
--                    signal bidir_port_to_and_from_the_porta : INOUT STD_LOGIC_VECTOR (7 DOWNTO 0);
--
--                 -- the_spi_0
--                    signal MISO_to_the_spi_0 : IN STD_LOGIC;
--                    signal MOSI_from_the_spi_0 : OUT STD_LOGIC;
--                    signal SCLK_from_the_spi_0 : OUT STD_LOGIC;
--                    signal SS_n_from_the_spi_0 : OUT STD_LOGIC
--                 );
--end component my_processor;
component alpha_blender
port(button : in std_logic_vector(7 downto 0);
		led : out std_logic_vector(7 downto 0));
end component;
begin
--ints_processor:my_processor port map(clkin_50,reset,button,lcd_en,lcd_rs,lcd_rw,lcd_data,porta,miso,mosi,sclk,ss_n);
inst_blender:alpha_blender port map(button => button, led => led);
end architecture;
-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2022.2 (win64) Build 3671981 Fri Oct 14 05:00:03 MDT 2022
-- Date        : Mon May 22 17:06:50 2023
-- Host        : FIRST-MICROSOFT running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               e:/Computer_Organization/FeatherCPU/src/FeatherCPU.gen/sources_1/ip/upg_clk_wiz/upg_clk_wiz_stub.vhdl
-- Design      : upg_clk_wiz
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a35tfgg484-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity upg_clk_wiz is
  Port ( 
    upg_clk_i : out STD_LOGIC;
    reset : in STD_LOGIC;
    locked : out STD_LOGIC;
    clk_in1 : in STD_LOGIC
  );

end upg_clk_wiz;

architecture stub of upg_clk_wiz is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "upg_clk_i,reset,locked,clk_in1";
begin
end;

// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.2 (win64) Build 3671981 Fri Oct 14 05:00:03 MDT 2022
// Date        : Tue May 23 01:19:46 2023
// Host        : FIRST-MICROSOFT running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               e:/Computer_Organization/FeatherCPU/src/FeatherCPU.gen/sources_1/ip/upg_clk_wiz/upg_clk_wiz_stub.v
// Design      : upg_clk_wiz
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a35tfgg484-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module upg_clk_wiz(upg_clk_o, reset, locked, clk_in1)
/* synthesis syn_black_box black_box_pad_pin="upg_clk_o,reset,locked,clk_in1" */;
  output upg_clk_o;
  input reset;
  output locked;
  input clk_in1;
endmodule

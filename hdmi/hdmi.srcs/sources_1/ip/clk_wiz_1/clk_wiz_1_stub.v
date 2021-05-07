// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.2 (win64) Build 3064766 Wed Nov 18 09:12:45 MST 2020
// Date        : Fri May  7 09:40:18 2021
// Host        : LAPTOP-POK8F54O running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub d:/hdmi_fpga/hdmi/hdmi.srcs/sources_1/ip/clk_wiz_1/clk_wiz_1_stub.v
// Design      : clk_wiz_1
// Purpose     : Stub declaration of top-level module interface
// Device      : xcku040-ffva1156-2-i
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module clk_wiz_1(clk_out5x, reset, locked, clk_in1)
/* synthesis syn_black_box black_box_pad_pin="clk_out5x,reset,locked,clk_in1" */;
  output clk_out5x;
  input reset;
  output locked;
  input clk_in1;
endmodule

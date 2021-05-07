`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/01/14 15:05:11
// Design Name: 
// Module Name: top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module top(
input rstn_i,
input clk_i,
input clk_i_1,
output HDMI_CLK_P,
output HDMI_CLK_N,
output [2:0]HDMI_TX_P,
output [2:0]HDMI_TX_N
    );
wire locked;
wire locked5x;
wire clk_out, clk_out2_5x, clk_out5x;

wire vtc_vs_o,vtc_hs_o,vtc_de_o;  
 vtc#
(
.H_ACTIVE  (1024),
.H_BP      (160),
.H_SYNC    (136),
.H_FP      (24), 
.V_ACTIVE  (768),
.V_BP      (29),
.V_SYNC    (6),
.V_FP      (3 )
)
vtc_inst
(
.vtc_clk_i     (clk_out),
.vtc_rstn_i    (locked | locked5x),
.vtc_hs_o      (vtc_hs_o),
.vtc_vs_o      (vtc_vs_o),
.vtc_de_o      (vtc_de_o)
    );
    
wire tpg_hs_o, tpg_vs_o, tpg_de_o;
wire [23:0] tpg_data_o;

tpg tpg_inst(
.tpg_clk_i       (clk_out),
.tpg_rstn_i      (locked | locked5x),
.tpg_hs_i        (vtc_hs_o),
.tpg_vs_i        (vtc_vs_o),
.tpg_de_i        (vtc_de_o),
.tpg_hs_o        (tpg_hs_o),
.tpg_vs_o        (tpg_vs_o),
.tpg_de_o        (tpg_de_o),
.tpg_data_o      (tpg_data_o)
    );
uihdmitx uihdmitx_inst
(
.RSTn_i(locked | locked5x),
.HS_i(vtc_hs_o),
.VS_i(vtc_vs_o),
.VDE_i(vtc_de_o),
.RGB_i(tpg_data_o),
.PCLKX1_i(clk_out),
.PCLKX2_5_i(clk_out2_5x),
.PCLKX5_i(clk_out5x),
.TMDS_TX_CLK_P(HDMI_CLK_P),
.TMDS_TX_CLK_N(HDMI_CLK_N),
.TMDS_TX_P(HDMI_TX_P),
.TMDS_TX_N(HDMI_TX_N)
);
       
  clk_wiz_0 instance_name
   (
    // Clock out ports
    .clk_out(clk_out),     // output clk_out
    .clk_out2_5x(clk_out2_5x),     // output clk_out2_5x
    // Status and control signals
    .resetn(rstn_i), // input resetn
    .locked(locked),       // output locked
   // Clock in ports
    .clk_in1(clk_i));      // input clk_in1
    
    clk_wiz_1 clk1
   (
    // Clock out ports
    .clk_out5x(clk_out5x),     // output clk_out5x
    // Status and control signals
    .reset(~rstn_i), // input reset
    .locked(locked5x),       // output locked
   // Clock in ports
    .clk_in1(clk_i_1));      // input clk_in1
endmodule

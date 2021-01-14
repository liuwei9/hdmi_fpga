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
input clk_i
    );



wire vs_o,hs_o,de_o;  
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
.vtc_clk_i     (clk_out1),
.vtc_rstn_i    (rstn_i),
.vtc_hs_o      (hs_o),
.vtc_vs_o      (vs_o),
.vtc_de_o      (de_o)
    );
    


       
     clk_wiz_0 clk_inst
   (
    // Clock out ports
    .clk_out1(clk_out1),     // output clk_out1
    // Status and control signals
    .resetn(resetn), // input resetn
    .locked(locked),       // output locked
   // Clock in ports
    .clk_in1(clk_i));      // input clk_in1
endmodule

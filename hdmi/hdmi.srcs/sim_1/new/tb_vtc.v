`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/01/14 16:40:14
// Design Name: 
// Module Name: tb_vtc
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


module tb_vtc(

    );
reg vtc_rstn_i;
reg vtc_clk_i;
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
.vtc_clk_i     (clk_out1),
.vtc_rstn_i    (vtc_rstn_i),
.vtc_hs_o      (vtc_hs_o),
.vtc_vs_o      (vtc_vs_o),
.vtc_de_o      (vtc_de_o)
    );
    
initial begin
    vtc_rstn_i = 0;
    vtc_clk_i  = 0;
    #100
    vtc_rstn_i = 1;
    
end

always #5 vtc_clk_i = !vtc_clk_i;

  clk_wiz_0 instance_name
   (
    // Clock out ports
    .clk_out1(clk_out1),     // output clk_out1
    // Status and control signals
    .resetn(vtc_rstn_i), // input resetn
    .locked(),       // output locked
   // Clock in ports
    .clk_in1(vtc_clk_i));      // input clk_in1
endmodule

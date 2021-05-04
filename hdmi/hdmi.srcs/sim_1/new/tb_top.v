`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/03 20:52:16
// Design Name: 
// Module Name: tb_top
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


module tb_top(

    );
    
wire [2:0]HDMI_TX_P;
wire [2:0]HDMI_TX_N;
  reg rstn_i;
  reg clk_i;
wire HDMI_CLK_P;
wire HDMI_CLK_N;

initial begin
    rstn_i = 1'b0;
    clk_i = 1'b0;
    #20
    rstn_i = 1'b1;


end  
always #5 clk_i = ~clk_i;
    
    
    top top_inst(
.rstn_i             (rstn_i),
.clk_i              (clk_i),
.HDMI_CLK_P         (HDMI_CLK_P),
.HDMI_CLK_N         (HDMI_CLK_N),
.HDMI_TX_P          (HDMI_TX_P),
.HDMI_TX_N          (HDMI_TX_N)
    );
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/01/17 15:17:10
// Design Name: 
// Module Name: tpg
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


module tpg(
input           tpg_clk_i,
input           tpg_rstn_i,
input           tpg_hs_i,
input           tpg_vs_i,
input           tpg_de_i,
output          tpg_hs_o,
output          tpg_vs_o,
output          tpg_de_o,
output [23:0]   tpg_data_o
    );
    
reg [11:0] h_cnt;
reg [10:0] v_cnt;
always @(posedge tpg_clk_i or negedge tpg_rstn_i)begin
    if(!tpg_rstn_i)
        h_cnt <= 12'd0;
    else if(tpg_de_i == 1'b1)
        h_cnt <= h_cnt + 1'b1;
    else
        h_cnt <= 12'd0;
end
reg tpg_hs_d;
reg tpg_vs_d;
always @(posedge tpg_clk_i)begin
    tpg_hs_d <= tpg_hs_i;
    tpg_vs_d <= tpg_vs_i;
end

always @(posedge tpg_clk_i or negedge tpg_rstn_i) begin
    if(!tpg_rstn_i)
        v_cnt <= 11'd0;
    else if(tpg_vs_i == 1'b1)
        v_cnt <= 11'd0;
    else if(tpg_vs_d && (~tpg_vs_i))
        v_cnt <= v_cnt + 1'b1;
    else
        v_cnt <= v_cnt;
end

reg [7:0] red;
reg [7:0] blue;
reg [7:0] green;
always @(posedge tpg_clk_i or negedge tpg_rstn_i)begin
    if(!tpg_rstn_i)begin
        red <= 8'b0000_0000;
        green <= 8'b0000_0000;
        blue <= 8'b0000_0000;
    end else begin
        red <= 8'b1111_1111;
        green <= 8'b0000_0000;
        blue <= 8'b0000_0000;
    end
end
assign tpg_data_o = {red, green, blue};
assign tpg_hs_o = tpg_hs_i;
assign tpg_vs_o = tpg_vs_i;
assign tpg_de_o = tpg_de_i;
endmodule

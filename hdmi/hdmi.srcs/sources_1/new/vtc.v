`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/01/14 15:06:50
// Design Name: 
// Module Name: vtc
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


module vtc#
(
parameter H_ACTIVE  =   1024,
parameter H_BP      =   160,
parameter H_SYNC    =   136,
parameter H_FP      =   24, 
parameter V_ACTIVE  =   768,
parameter V_BP      =   29,
parameter V_SYNC    =   6,
parameter V_FP      =   3  
)
(
input vtc_clk_i,
input vtc_rstn_i,
output reg vtc_hs_o,
output reg vtc_vs_o,
output reg vtc_de_o
    );
`define H_TOTAL  (H_ACTIVE + H_BP + H_SYNC + H_FP)
`define V_TOTAL  (V_ACTIVE + V_BP + V_SYNC + V_FP)

reg [11:0] h_cnt;
reg [10:0] v_cnt;

always @(posedge vtc_clk_i or negedge vtc_rstn_i)begin
    if(!vtc_rstn_i)
        h_cnt <= 12'b0;
    else if(h_cnt == `H_TOTAL - 1'b1)
        h_cnt <= 12'b0;
    else
        h_cnt <= h_cnt + 1'b1;
end

always @(posedge vtc_clk_i or negedge vtc_rstn_i)begin
    if(!vtc_rstn_i)
        v_cnt <= 11'b0;
    else if(h_cnt == `H_TOTAL - 1'b1)begin
        if(v_cnt == `V_TOTAL - 1'b1)
            v_cnt <= 11'b0;
        else
            v_cnt <= v_cnt + 1'b1;
    end else
        v_cnt <= v_cnt;      
end

wire hs_valid = (h_cnt >= 1'b0 && h_cnt <= (H_ACTIVE - 1'b1)) ? 1'b1 : 1'b0;
wire vs_valid = (v_cnt >= 1'b0 && v_cnt <= (V_ACTIVE - 1'b1)) ? 1'b1 : 1'b0;
wire vtc_hs = ((h_cnt >= 1'b0 && h_cnt <= (H_ACTIVE + H_FP - 1'b1)) || (h_cnt >= (H_ACTIVE + H_FP + H_SYNC) && h_cnt <= (`H_TOTAL - 1'b1))) ? 1'b1 : 1'b0;
wire vtc_vs = ((v_cnt >= 1'b0 && v_cnt <= (V_ACTIVE + V_FP - 1'b1)) || (v_cnt >= (V_ACTIVE + V_FP + V_SYNC) && v_cnt <= (`V_TOTAL - 1'b1))) ? 1'b1 : 1'b0;
wire vtc_de = hs_valid & vs_valid;


always @(posedge vtc_clk_i or negedge vtc_rstn_i)begin
    if(!vtc_rstn_i)begin 
        vtc_hs_o <= 1'b0;
        vtc_vs_o <= 1'b0;
        vtc_de_o <= 1'b0;
    end else begin
        vtc_hs_o <= vtc_hs;
        vtc_vs_o <= vtc_vs;
        vtc_de_o <= vtc_de;
    end
end

endmodule

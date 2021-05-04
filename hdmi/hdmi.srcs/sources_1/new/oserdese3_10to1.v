`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
/*
Company : Liyang Milian Electronic Technology Co., Ltd.
Brand: Ã×Áª¿Í(msxbo)
Technical forum£ºuisrc.com
taobao: osrc.taobao.com
Create Date: 2019/12/17
Module Name: oserdese3_10to1
Description: 
10: 1 serial transceiver
Copyright: Copyright (c) msxbo
Revision: 1.0
Signal description£º
1) _i input
2) _o output
3) _n activ low
4) _dg debug signal 
5) _r delay or register
6) _s state mechine
*/
////////////////////////////////////////////////////////////////////////////////


module oserdese3_10to1(
input [9:0] txdata,    // 7-bit pixel data
input       txrst,      // Reset for pixel logic synchronus to pclk
input       pclk,       // Pixel clock running at 1/7 transmit rate
input       clkdiv2,    // Transmit clock running at 1/2 transmit rate
input       clkdiv4,    // Transmit clock running at 1/4 transmit rate
output      tx_p,      // Transmit output P-side
output      tx_n       // Transmit output N-side
);
reg  [3:0]  tx_data;
wire        oserdes_out;   
reg flag;
reg [9:0] data_1;
reg [9:0] data_2;
always @(posedge pclk)begin
    if(txrst)begin
        flag <= 1'b0;
    end  else begin 
        flag <= ~flag;
    end
end 

always @(posedge pclk)begin 
    if(flag == 1'b0)begin 
        data_1 <= txdata;
    end else begin 
        data_2 <= txdata;
    end
end
reg rstq,rstqq;
always @(posedge pclk)begin
    rstq <= txrst;
    rstqq <= rstq;
end

reg [3:0] count;
always @(posedge clkdiv4)begin
    if(rstqq)begin
        count <= 4'd0;
    end else if(count == 4'd4)begin 
        count <= 4'd0;
    end else begin
        count <= count + 1'b1;
    end
end

always @(posedge clkdiv4)begin
    case(count)
        4'd0:begin
            tx_data <= data_1[3:0];
        end
        4'd1:begin
            tx_data <= data_1[7:4];
        end
        4'd2:begin
            tx_data <= {data_2[1:0],data_1[9:8]};
        end
        4'd3:begin
            tx_data <= data_2[5:2];
        end
        4'd4:begin
            tx_data <= data_2[9:6];
        end
        default:begin 
            tx_data <= tx_data;
        end
    endcase
end

OSERDESE3 #(
      .DATA_WIDTH(4),            // Parallel Data Width (4-8)
      .INIT(1'b0),               // Initialization value of the OSERDES flip-flops
      .IS_CLKDIV_INVERTED(1'b0), // Optional inversion for CLKDIV
      .IS_CLK_INVERTED(1'b0),    // Optional inversion for CLK
      .IS_RST_INVERTED(1'b0),    // Optional inversion for RST
      .SIM_DEVICE("ULTRASCALE")  // Set the device version for simulation functionality (ULTRASCALE)
   )
   OSERDESE3_inst (
      .OQ(oserdes_out),         // 1-bit output: Serial Output Data
      .T_OUT(),   // 1-bit output: 3-state control output to IOB
      .CLK(clkdiv2),       // 1-bit input: High-speed clock
      .CLKDIV(clkdiv4), // 1-bit input: Divided Clock
      .D({4'd0,tx_data}),           // 8-bit input: Parallel Data Input
      .RST(rstqq),       // 1-bit input: Asynchronous Reset
      .T(1'b0)            // 1-bit input: Tristate input from fabric
   );
 
OBUFDS io_clk_out (
    .I        (oserdes_out),
    .O        (tx_p),
    .OB       (tx_n));

endmodule
  

`timescale 1ns / 1ps


module oserdese3_10to1(
input [9:0] txdata,    
input       txrst,     
input       pclk,      
input       pclk5x,    
input       pclk2_5x,   
output      tx_p,     
output      tx_n       
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
reg [9:0] data_1_q;
reg [9:0] data_1_qq;
reg [9:0] data_2_q;
reg [9:0] data_2_qq;
always @(posedge pclk2_5x)begin 
    data_1_q <= data_1;
    data_1_qq <= data_1_q;
    data_2_q <= data_2;
    data_2_qq <= data_2_q;
end
reg rstq,rstqq;
always @(posedge pclk2_5x)begin
    rstq <= txrst;
    rstqq <= rstq;
end

reg [3:0] count;
always @(posedge pclk2_5x)begin
    if(rstqq)begin
        count <= 4'd0;
    end else if(count == 4'd4)begin 
        count <= 4'd0;
    end else begin
        count <= count + 1'b1;
    end
end

always @(posedge pclk2_5x)begin
    case(count)
        4'd0:begin
            tx_data <= data_1_qq[3:0];
        end
        4'd1:begin
            tx_data <= data_1_qq[7:4];
        end
        4'd2:begin
            tx_data <= {data_2_qq[1:0],data_1_qq[9:8]};
        end
        4'd3:begin
            tx_data <= data_2_qq[5:2];
        end
        4'd4:begin
            tx_data <= data_2_qq[9:6];
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
      .CLK(pclk5x),       // 1-bit input: High-speed clock
      .CLKDIV(pclk2_5x), // 1-bit input: Divided Clock
      .D({4'd0,tx_data}),           // 8-bit input: Parallel Data Input
      .RST(rstqq),       // 1-bit input: Asynchronous Reset
      .T(1'b0)            // 1-bit input: Tristate input from fabric
   );
 
OBUFDS io_clk_out (
    .I        (oserdes_out),
    .O        (tx_p),
    .OB       (tx_n));
//ila_0 your_instance_name (
//	.clk(pclk), // input wire clk


//	.probe0(txdata), // input wire [9:0]  probe0  
//	.probe1(tx_data) // input wire [4:0]  probe1 
//	.probe2(rstqq), // input wire [0:0]  probe2 
//	.probe3(txrst), // input wire [0:0]  probe3 
//	.probe4(flag) // input wire [0:0]  probe4
//);
endmodule
  

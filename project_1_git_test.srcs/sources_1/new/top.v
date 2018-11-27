`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/20/2018 05:55:03 PM
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
    input   adc4clk_p,
    input   adc4clk_n,
    input   [15:0] adc4d_p,
    input   [15:0] adc4d_n,
    output  reg adcshdn,
    output  reg adcdith,
    output  reg adcpga,
    output  reg adcrand
    );
    
    wire adc4clk, clk_120, clk_80;
    reg [1:0] state = 2'b00;
    
always@(posedge clk_120)
begin
        state <= state + 1;
        case (state)
            2'b00 : begin
                adcshdn <= 1;
                adcdith <= 0;
                adcpga  <= 0;
                adcrand <= 0;
            end
            2'b01 : begin
                adcshdn <= 1;
                adcdith <= 1;
                adcpga  <= 0;
                adcrand <= 0;
            end
            2'b10 : begin
                adcshdn <= 1;
                adcdith <= 1;
                adcpga  <= 1;
                adcrand <= 0;
            end
            2'b11 : begin
                adcshdn <= 0;
                adcdith <= 1;
                adcpga  <= 1;
                adcrand <= 1;
            end
         endcase							
    
end
    
clk_wiz_0 clock_wizard
 (
  .clk_out1(clk_120),
  .clk_out2(clk_80),
  .clk_in1(adc4clk)
 );
    
    
IBUFDS #(
    .DIFF_TERM("TRUE"), 
    .IOSTANDARD("LVDS_25")
    ) IBUFDS_1inst (
        .O(adc4clk), 
        .I(adc4clk_p),
        .IB(adc4clk_n)
    );
    
endmodule

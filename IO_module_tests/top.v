`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/20 11:42:34
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
    input clk,
    input rst,
    input upg_rx,
    output upg_tx,
    input [23:0] sw,
    output [7:0] seg_cho,
    output [7:0] seg_lit,
    output [23:0] led,
    input [3:0] row,
    output [3:0] col
);

reg [31:0] data;
reg [31:0] my_data;
wire [3:0] dt;
wire ena;

Keyboard kb(.clk(clk), .rst(rst), .row(row), .col(col), .data(dt), .enable(ena));

always @(posedge ena) begin
    my_data = {my_data[27:0], dt};
    if(my_data[19:16] == 4'h1) begin
        data = my_data;
        my_data = 0;
    end
end

segtube sg(
    .clk(clk),
    .dat(my_data),
    .seg_cho(seg_cho),
    .seg_lit(seg_lit)
);

wire oo_clk;
clk_wiz_0 cw0(.reset(rst), .clk_in1(clk), .clk_out1(oo_clk));

wire uart_ena;
wire [14:0] uart_addr;
wire [31:0] uart_data;
wire uart_done;
uart1 muart(
    .upg_clk_i(oo_clk),
    .upg_rst_i(rst),
    .upg_rx_i(upg_rx),
    .upg_clk_o(uart_clk),
    .upg_wen_o(uart_ena),
    .upg_adr_o(uart_addr),
    .upg_dat_o(uart_data),
    .upg_done_o(uart_done),
    .upg_tx_o(upg_tx)
);
//assign led = {uart_done,uart_addr,4'h0,row[3:0]};
assign led = data;

endmodule

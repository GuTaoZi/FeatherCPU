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
    input [23:0] sw,
    output [7:0] seg_cho,
    output [7:0] seg_lit,
    output [23:0] led,
    input [3:0] row,
    output [3:0] col
);

wire k_flg;
wire [3:0]data;
wire [31:0]dat = {4'b0000,data[3:0],sw[23:0]};

keyboard ukeyboard(
    .clk(clk),
    .rst(rst),
    .row(row),
    .col(col),
    .data(data)
);

segtube seg(
    .clk(clk),
    .dat(dat),
    .seg_cho(seg_cho),
    .seg_lit(seg_lit)
);
assign led = {20'h00000,row[3:0]};
//assign led = sw;

endmodule

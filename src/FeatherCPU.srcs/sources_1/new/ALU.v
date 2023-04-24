`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/24 13:42:54
// Design Name: 
// Module Name: ALU
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
`include "ParamDef.vh"

module ALU(
input [`REG_WIDTH]    src1,
input [`REG_WIDTH]    src2,
input [5:0]     ALU_op,
output [`REG_WIDTH]   opt
    );
wire [`REG_WIDTH] sum;
wire [`REG_WIDTH] mul;
wire [`REG_WIDTH] shift;
wire [`REG_WIDTH] binary;

assign 
endmodule

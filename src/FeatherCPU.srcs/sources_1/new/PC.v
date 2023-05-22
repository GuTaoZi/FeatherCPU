`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/28 16:40:46
// Design Name: 
// Module Name: PC
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

module PC(
input clk,
input rst,
input J,
input Jal,
input branch,
input [`REG_WIDTH] J_val,   // from instruction
input [`REG_WIDTH] Jal_val, // from register
input [`REG_WIDTH] branch_val, // from ALU
output [`REG_WIDTH] pc
    );
reg [`REG_WIDTH] now_pc;
wire [`REG_WIDTH] next_pc;
assign pc = now_pc;

always @(negedge clk)
begin
    now_pc = next_pc;
end

assign next_pc =
rst     ?   0                                   :
J       ?   {now_pc[31:20], J_val[19:0]} + 4    :
Jal     ?   Jal_val + 4                         :
branch  ?   now_pc + branch_val                 :
            now_pc + 4;

//TODO: $ra
endmodule

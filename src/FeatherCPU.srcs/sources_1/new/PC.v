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
input Jal,
input Jalr,
input pc_en,
input branch,
input [`REG_WIDTH] Jal_imm,
input [`REG_WIDTH] alu_val,
output [`REG_WIDTH] pc,
output reg [`REG_WIDTH] pc_rb
    );
reg [`REG_WIDTH] now_pc;
wire [`REG_WIDTH] next_pc;
assign pc = now_pc;

always @(posedge clk, posedge rst)
begin
    if(rst) begin
        now_pc = 0;
    end else begin
        if(pc_en) begin
            pc_rb = now_pc + 4;
            now_pc = next_pc;
        end
    end
end

assign next_pc =
rst     ?   0                           :
Jalr    ?   alu_val                     :
Jal     ?   now_pc + Jal_imm            :
branch  ?   now_pc + alu_val            :
            now_pc + 4;
//TODO: $ra
endmodule

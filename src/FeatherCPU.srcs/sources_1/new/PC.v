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
    input i_clk,
    input i_rst,
    input i_Jal,
    input i_Jalr,
    input i_pc_en,
    input i_branch,
    input [`REG_WIDTH] i_Jal_imm,
    input [`REG_WIDTH] i_alu_val,
    output [`REG_WIDTH] o_pc,
    output [`REG_WIDTH] o_next_pc,
    output reg [`REG_WIDTH] o_pc_rb
);
reg [`REG_WIDTH] now_pc = 0;
wire [`REG_WIDTH] next_pc;
assign o_pc = now_pc;
assign o_next_pc = next_pc;

always @(negedge i_clk, posedge i_rst)
begin
    if(i_rst) begin
        now_pc = 0;
        o_pc_rb = 0;
    end else begin
        if(i_pc_en) begin
            o_pc_rb = now_pc + 4;
            now_pc = next_pc;
        end
    end
end

assign next_pc =
i_rst     ?   0                           :
i_Jalr    ?   i_alu_val                     :
i_Jal     ?   now_pc + i_Jal_imm            :
i_branch  ?   now_pc + i_alu_val            :
            now_pc + 4;

endmodule

`timescale 1ns / 1ps
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

/****************************************************************
 port           I/O     Src/Dst     Description
 i_clk           I        Top       CPU clock signal
 i_rst           I      H'ware      Reset signal
 i_Jal           I        ID        Jal instruction enable
 i_Jalr          I        ID        Jalr instruction enable
 i_pc_en         I        Top       PC update enable
 i_branch        I        ID        Branch instruction enable
 i_Jal_imm       I        ID        Jal immediate
 i_alu_val       I        ID        Result of ALU for updating PC
 o_pc            O        Top       Current PC
 o_next_pc       O        Top       Next PC, for debugging
 o_pc_rb         O        Top       PC to write back for Jal(r)
****************************************************************/

reg [`REG_WIDTH] now_pc = 0;
wire [`REG_WIDTH] next_pc;
reg [`REG_WIDTH] pc_tmp;
assign o_pc = now_pc;
assign o_next_pc = next_pc;

always @(posedge i_pc_en, posedge i_rst)
begin
    if(i_rst) begin
        now_pc = 0;
        o_pc_rb = 4;
    end else if(i_pc_en) begin
        o_pc_rb = now_pc + 4;
        pc_tmp = next_pc;
        now_pc = pc_tmp;
    end
end

assign next_pc =
i_rst     ?   0                             :
i_Jalr    ?   i_alu_val                     :
i_Jal     ?   now_pc + i_Jal_imm            :
i_branch  ?   now_pc + i_alu_val            :
            now_pc + 4;

endmodule

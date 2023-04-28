`timescale 1ns / 1ps
`include "ParamDef.vh"
`include "InstDef.vh"
`include "ALUDef.vh"

module inst_decoder(
    input[`INST_LEN] i_inst,
    output o_rs1_ena,
    output o_rs2_ena,
    output[`REG_IDX_LEN] o_rs1_idx,
    output[`REG_IDX_LEN] o_rs2_idx,
    output[`ALU_OP_LEN] o_alu_op
);

wire[6:0] opcode;
wire[2:0] funct3;
wire[6:0] funct7;
wire[4:0] rd,rs1,rs2;
wire[11:0] imm_I,imm_S;
wire[31:0] imm_S,imm_B,imm_U,imm_J;

assign opcode = i_inst[6:0];
assign funct3 = i_inst[14:12];
assign funct7 = i_inst[31:25];
assign rd = i_inst[11:7];
assign rs1 = i_inst[19:15];
assign rs2 = i_inst[24:20];
assign imm_I = i_inst[31:20];
assign imm_S = {i_inst[31:25],i_inst[11:7]};
assign imm_B = {{20{i_inst[31]}},i_inst[19:12],i_inst[20],i_inst[30:21],1'b0};
assign imm_U = {i_inst[31:12],12'b0};
assign imm_J = {{12{i_inst[31]}}, i_inst[19:12],i_inst[20], i_inst[30:21],1'b0};

assign o_alu_op = funct3?(
    (funct3==3'b001)? `ALU_SLL: // sll
    (funct3==3'b010)? `ALU_SLT: // slt
    (funct3==3'b011)? `ALU_SLT: // sltu
    (funct3==3'b100)? ((funct7[0])?`ALU_DIV:`ALU_XOR): // div : xor
    (funct3==3'b101)? ((funct7[5])?`ALU_SRA:`ALU_SRL): // sra : srl
    (funct3==3'b110)? ((funct7[0])?`ALU_REM:`ALU_OR):  // rem : or
    (funct3==3'b111)? `ALU_AND: // and
    `ALU_ERR // err
):
(
    (funct7==7'b000_0000)? `ALU_ADD: // add
    (funct7==7'b000_0001)? `ALU_MUL: // mul
    (funct7==7'b000_0010)? `ALU_ADD: // addu
    (funct7==7'b010_0000)? `ALU_SUB: // sub
    (funct7==7'b000_0100)? `ALU_SUB: // subu
    `ALU_ERR // err
);

endmodule

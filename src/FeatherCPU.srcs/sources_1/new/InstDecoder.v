`timescale 1ns / 1ps
`include "ParamDef.vh"
`include "InstDef.vh"
`include "ALUDef.vh"

module inst_decoder(
    input[`INST_LEN] i_inst,
    output[`REG_IDX_LEN] o_rs1_idx,
    output[`REG_IDX_LEN] o_rs2_idx,
    output[`REG_IDX_LEN] o_rd_idx,
    output[`REG_WIDTH] o_imm,
    output[`ALU_OP_LEN] o_alu_op,
    output o_reg_dst,
    output o_branch,
    output o_mem_read,
    output o_mem_write,
    output o_mem_to_reg,
    output o_alu_src,
    output o_reg_write
);

wire[6:0] opcode;
wire[2:0] funct3;
wire[6:0] funct7;
wire[2:0] inst_type;
wire[11:0] imm_I,imm_S;
wire[31:0] imm_S,imm_B,imm_U,imm_J;
//wire[4:0] rd,rs1,rs2;
//wire o_rs1_ena;
//wire o_rs2_ena;
//wire o_imm_ena;

assign opcode = i_inst[6:0];
assign funct3 = i_inst[14:12];
assign funct7 = i_inst[31:25];

assign inst_type = (opcode==7'b011_0011)?`R_TYPE:
                   (opcode==7'b001_0011)?`I_TYPE:
                   (opcode==7'b000_0011)?`I_TYPE:
                   (opcode==7'b111_0011)?`I_TYPE:
                   (opcode==7'b010_0011)?`S_TYPE:
                   (opcode==7'b110_0011)?`B_TYPE:
                   (opcode==7'b110_1111)?`J_TYPE:
                   (opcode==7'b110_0111)?`J_TYPE:
                   (opcode==7'b011_0111)?`U_TYPE:
                   (opcode==7'b001_0111)?`U_TYPE:`E_TYPE;

assign imm_I = i_inst[31:20];
assign imm_S = {i_inst[31:25],i_inst[11:7]};
assign imm_B = {{20{i_inst[31]}},i_inst[19:12],i_inst[20],i_inst[30:21],1'b0};
assign imm_J = {{12{i_inst[31]}}, i_inst[19:12],i_inst[20], i_inst[30:21],1'b0};
assign imm_U = {i_inst[31:12],12'b0};

//assign o_rs1_ena = (opcode==7'b110_1111||
//                    opcode==7'b110_0111||
//                    opcode==7'b011_0111||
//                    opcode==7'b001_0111)?1'b0:1'b1;

//assign o_rs2_ena = (!o_rs1_ena ||
//                    opcode==7'b001_0011||
//                    opcode==7'b000_0011||
//                    opcode==7'b111_0011)?1'b0:1'b1;

//assign o_imm_ena = (opcode==7'b011_0011)?1'b0:1'b1;

assign o_rd_idx = i_inst[11:7];
assign o_rs1_idx = i_inst[19:15];
assign o_rs2_idx = i_inst[24:20];

assign o_imm = (inst_type==`R_TYPE)?32'h0:
               (inst_type==`I_TYPE)?imm_I:
               (inst_type==`S_TYPE)?imm_S:
               (inst_type==`B_TYPE)?imm_B:
               (inst_type==`J_TYPE)?imm_J:
               (inst_type==`U_TYPE)?imm_U:32'hffff_ffff;

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

assign o_reg_dst    = !(inst_type==`S_TYPE||inst_type==`B_TYPE);
assign o_branch     = (inst_type==`B_TYPE);
assign o_mem_read   = (opcode==7'b000_0011);
assign o_mem_write  = (inst_type==`S_TYPE);
assign o_mem_to_reg = (opcode==7'b000_0011);
assign o_alu_src    = (inst_type==`R_TYPE||inst_type==`S_TYPE||inst_type==`B_TYPE);
assign o_reg_write  = !(inst_type==`S_TYPE||inst_type==`B_TYPE);

endmodule

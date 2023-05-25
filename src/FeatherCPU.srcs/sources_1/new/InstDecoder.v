`timescale 1ns / 1ps
`include "ParamDef.vh"
`include "InstDef.vh"
`include "ALUDef.vh"

module inst_decoder(
    input[`INST_LEN] i_inst,
    output[`REG_IDX_LEN] o_rs1_idx,
    output[`REG_IDX_LEN] o_rs2_idx,
//    output[`REG_IDX_LEN] o_rd_idx,
    output[`REG_WIDTH] o_imm,
    output[`ALU_OP_LEN] o_alu_op,
    output o_mem_read,
    output o_mem_write,
    output o_mem_to_reg,
//    output o_reg_write,
    output [`INST_TYPES_WIDTH] o_inst_type
);

wire[6:0] opcode;
wire[2:0] funct3;
wire[6:0] funct7;
wire[31:0] imm_I, imm_S,imm_B,imm_U,imm_J;
//wire[4:0] rd,rs1,rs2;
//wire o_rs1_ena;
//wire o_rs2_ena;
//wire o_imm_ena;

assign opcode = i_inst[6:0];
assign funct3 = i_inst[14:12];
assign funct7 = i_inst[31:25];

assign o_inst_type=(opcode==7'b011_0011)?`R_TYPE:
                   (opcode==7'b001_0011)?`I_TYPE:
                   (opcode==7'b000_0011)?`I_TYPE:
                   (opcode==7'b111_0011)?`E_TYPE:
                   (opcode==7'b010_0011)?`S_TYPE:
                   (opcode==7'b110_0011)?`B_TYPE:
                   (opcode==7'b110_1111)?`J_TYPE:
                   (opcode==7'b110_0111)?`J_TYPE:
                   (opcode==7'b011_0111)?`U_TYPE:
                   (opcode==7'b001_0111)?`U_TYPE:`E_TYPE;

assign imm_I = {{20{i_inst[31]}},i_inst[31:20]};
assign imm_S = {{20{i_inst[31]}},i_inst[31:25],i_inst[11:7]};
assign imm_B = {{20{i_inst[31]}},i_inst[19:12],i_inst[20],i_inst[30:21],1'b0};
assign imm_JAL = {{12{i_inst[31]}}, i_inst[19:12],i_inst[20], i_inst[30:21],1'b0};
assign imm_JALR = {{20{i_inst[31]}},i_inst[31:20]};
assign imm_U = {i_inst[31:12]};

//assign o_rd_idx = i_inst[11:7];
assign o_rs1_idx = i_inst[19:15];
assign o_rs2_idx = i_inst[24:20];

assign o_imm = (o_inst_type==`R_TYPE)?32'h0:
               (o_inst_type==`I_TYPE)?imm_I:
               (o_inst_type==`S_TYPE)?imm_S:
               (o_inst_type==`B_TYPE)?imm_B:
               (o_inst_type==`J_TYPE)?((opcode==`J_JAL)?imm_JAL:imm_JALR):
               (o_inst_type==`U_TYPE)?imm_U:32'hffff_ffff;

wire funct10 = {funct3,funct7};

assign o_alu_op =
    (o_inst_type==`R_TYPE)?
    ((funct10==`R_ADD||funct10==`R_ADDU)?`ALU_ADD:
    (funct10==`R_SUB||funct10==`R_SUBU)?`ALU_SUB:
    (funct10==`R_MUL)?`ALU_MUL:
    (funct10==`R_DIV)?`ALU_DIV:
    (funct10==`R_REM)?`ALU_REM:
    (funct10==`R_SLL)?`ALU_SLL:
    (funct10==`R_SLT)?`ALU_SLT:
    (funct10==`R_SLTU)?`ALU_SLTU:
    (funct10==`R_XOR)?`ALU_XOR:
    (funct10==`R_SRL)?`ALU_SRL:
    (funct10==`R_SRA)?`ALU_SRA:
    (funct10==`R_OR)?`ALU_OR:
    (funct10==`R_AND)?`ALU_AND:`ALU_ERR)
    :
    (o_inst_type==`I_TYPE)?
    ((opcode==`I_LW)?`ALU_ADD:
    (funct3==`I_ADDI)?`ALU_ADD:
    (funct3==`I_SLTI)?`ALU_SLT:
    (funct3==`I_SLLI)?`ALU_SLL:
    (funct3==`I_SLTIU)?`ALU_SLTU:
    ({funct3,o_imm[11:5]}==`I_SRLI)?`ALU_SRL:
    ({funct3,o_imm[11:5]}==`I_SRAI)?`ALU_SRA:
    (funct3==`I_ORI)?`ALU_OR:
    (funct3==`I_ANDI)?`ALU_AND:`ALU_ERR)
    :
    (o_inst_type==`S_TYPE)?`ALU_ADD:
    (o_inst_type==`B_TYPE)?
    ((funct3==`B_BEQ)?`ALU_BEQ:`ALU_BNE)
    :
    (o_inst_type==`J_TYPE)?`ALU_ADD
    :
    (opcode==`U_TYPE)?`ALU_SLL
    :`ALU_ERR;

assign o_mem_read   = (opcode==7'b000_0011);
assign o_mem_write  = (o_inst_type==`S_TYPE);
assign o_mem_to_reg = (opcode==7'b000_0011);
//assign o_reg_write  = !(o_inst_type==`S_TYPE||o_inst_type==`B_TYPE);

endmodule

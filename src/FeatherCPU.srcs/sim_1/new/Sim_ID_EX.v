`timescale 1ns / 1ps
`include "ParamDef.vh"
`include "InstDef.vh"
`include "ALUDef.vh"
//Simulation file for ID->ALU->REG
module Sim_ID_EX();

reg [1:0] state;
reg [31:0] inst;

wire [`INST_TYPES_WIDTH] inst_type;
wire [`REG_WIDTH] reg_data1;
wire [`REG_WIDTH] reg_data2;
wire [`REG_WIDTH] imm_raw;

wire [`REG_WIDTH] src1 = 
(inst[6:0]==`I_LW)?(reg_data1):     // rd = rs1 + offset
(inst_type==`S_TYPE)?(reg_data1):   // rd = rs1 + offset
(inst_type==`R_TYPE)?(reg_data1):   // rd = rs1 ? rs2
(inst_type==`I_TYPE)?(reg_data1):   // rs = rs1 ? imm
(inst_type==`B_TYPE)?(reg_data1):   // rs1 == rs2
(inst_type==`U_TYPE)?(imm_raw):     // imm << 12
(inst[6:0]==`J_JALR)?(reg_data1):0; // pc = rs1 + imm

wire [`REG_WIDTH] src2 =
(inst[6:0]==`I_LW)?(imm_raw):
(inst_type==`S_TYPE)?(imm_raw):
(inst_type==`R_TYPE)?(reg_data2):
(inst_type==`I_TYPE)?(imm_raw):
(inst_type==`B_TYPE)?(reg_data2):
(inst_type==`U_TYPE)?(4'd12):
(inst[6:0]==`J_JALR)?(imm_raw):0;

InstDecoder u_inst_decoder(
    .i_inst(inst),
    ///input///
    ///output///
    .o_rs1_idx(rs1_idx_raw),
    .o_rs2_idx(rs2_idx_raw),
    .o_rd_idx(rd_idx_raw),
    .o_imm(imm_raw),
    .o_alu_op(alu_op_raw),
    .o_mem_read(mem_read_en),
    .o_mem_write(mem_write_en),
    .o_mem_to_reg(mem_to_reg_en),
    .o_alu_src(alu_src_from_2_regs),
    .o_reg_write(reg_write_en_from_id),
    .o_inst_type(inst_type)
);

wire [`REG_WIDTH] alu_opt;

wire register_write_enable_of_id_and_pc=(state==2'b11)&(reg_write_en_from_id);
wire data_write_into_register = (inst[6:0]==`I_LW)?32'd114514:alu_opt;

Register u_Register(
    .i_read_addr1(rs1_idx_raw),
    .i_read_addr2(rs2_idx_raw),
    .i_write_addr(rd_idx_raw),
    .i_write_data(data_write_into_register),
    .i_write_en(register_write_enable_of_id_and_pc),
    .i_clk(cpu_clk),
    .i_rst(rst),
    ///input///
    ///output///
    .o_read_data1(reg_data1),
    .o_read_data2(reg_data2)
);

wire overflow_raw;

ALU alu(
    .i_src1(src1),
    .i_src2(src2),
    .i_branch_val_i(imm_raw),
    .i_ALU_op(alu_op_raw),
    .i_rst(rst),
    ///input///
    ///output///
    .o_ALU_ouput(alu_opt),
    .o_overflow(overflow_raw)
);

initial
begin
state = 2'b00;
//TODO
end

endmodule

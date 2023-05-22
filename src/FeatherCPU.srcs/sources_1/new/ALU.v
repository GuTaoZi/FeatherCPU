`timescale 1ns / 1ps

`include "ParamDef.vh"
`include "ALUDef.vh"

module ALU(
input [`REG_WIDTH]    src1,
input [`REG_WIDTH]    src2,
input [`REG_WIDTH]    branch_val_i,
input [`ALU_OP_LEN]   ALU_op,
input                 rst,
output [`REG_WIDTH]   opt,
output [`REG_WIDTH]   branch_val_o,
output                overflow
    );
wire [`REG_WIDTH] sum;
wire [`REG_WIDTH] mul;
wire [`REG_WIDTH] shift;
wire [`REG_WIDTH] binary;
wire [`REG_WIDTH] slt;

assign sum      = ALU_op[0] ? src1 - src2 : src1 + src2;
assign mul      = ALU_op[0] ? src1 / src2 : (ALU_op[1] ? src1 % src2 : src1 * src2);
assign shift    = ALU_op[1] ? (ALU_op[0] ? (src1>>>src2) : (src1>>src2)) : (src1<<src2);
assign binary   = ALU_op[0] ? (src1 | src2) : (ALU_op[1] ? (src1 ^ src2) : (src1 & src2));
assign slt      = ALU_op[0] ? ($signed(src1) < $signed(src2) ? 1 : 0) : (src1 < src2 ? 1 : 0);
assign beq      = (src1 == src2) ^ ALU_op[0];

assign opt      = rst ? 0 : (
    (ALU_op ^ `ALU_ADD) >> 2 == 0 ? sum :
    (ALU_op ^ `ALU_MUL) >> 2 == 0 ? mul :
    (ALU_op ^ `ALU_SLL) >> 2 == 0 ? shift :
    (ALU_op ^ `ALU_AND) >> 2 == 0 ? binary :
    (ALU_op ^ `ALU_SLT) >> 2 == 0 ? slt :
    0
);

assign branch_val_o = beq ? branch_val_i : 0;

assign overflow = rst ? 0 : (
    (ALU_op == `ALU_ADD) ? ((src1[`REG_MAX_LEN]&src2[`REG_MAX_LEN]&~sum[`REG_MAX_LEN]) | (~src1[`REG_MAX_LEN]&~src2[`REG_MAX_LEN]&sum[`REG_MAX_LEN])) :
    (ALU_op == `ALU_SUB) ? ((src1[`REG_MAX_LEN]&~src2[`REG_MAX_LEN]&~sum[`REG_MAX_LEN]) | (~src1[`REG_MAX_LEN]&src2[`REG_MAX_LEN]&sum[`REG_MAX_LEN])) :
    0
);

endmodule

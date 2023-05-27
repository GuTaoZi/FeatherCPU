`timescale 1ns / 1ps

`include "ParamDef.vh"
`include "ALUDef.vh"

module ALU(
    input [`REG_WIDTH]    i_src1,
    input [`REG_WIDTH]    i_src2,
    input [`REG_WIDTH]    i_branch_val_i,
    input [`ALU_OP_LEN]   i_ALU_op,
    input                 i_rst,
    output [`REG_WIDTH]   o_ALU_ouput,
    output                o_overflow
);

/****************************************************************
 port           I/O     Src/Dst     Description
i_src1           I        ID        First operand
i_src2           I        ID        Second operand
i_branch_val_i   I        ID        Immediate for B inst
i_ALU_op         I        ID        ALU operator number
i_rst            I        Top       Reset signal
o_ALU_ouput      O        Top       Result
o_overflow       O        Top       Overflow identifier
****************************************************************/

wire [`REG_WIDTH] sum;
wire [`REG_WIDTH] mul;
wire [`REG_WIDTH] shift;
wire [`REG_WIDTH] binary;
wire [`REG_WIDTH] slt;

assign sum      = i_ALU_op[0] ? i_src1 - i_src2 : i_src1 + i_src2;

assign mul      =   i_ALU_op[0] ? $signed(i_src1) / $signed(i_src2) :
                    i_ALU_op[1] ? $signed(i_src1) % $signed(i_src2) :
                                  $signed(i_src1) * $signed(i_src2);

assign shift    = i_ALU_op[1] ? (i_ALU_op[0] ? (i_src1>>>i_src2) : (i_src1>>i_src2)) : (i_src1<<i_src2);
assign binary   = i_ALU_op[0] ? (i_src1 | i_src2) : (i_ALU_op[1] ? (i_src1 ^ i_src2) : (i_src1 & i_src2));
assign slt      = i_ALU_op[0] ? ($signed(i_src1) < $signed(i_src2) ? 1 : 0) : (i_src1 < i_src2 ? 1 : 0);
assign beq      = (i_src1 == i_src2) ^ i_ALU_op[0];

assign o_ALU_ouput      = i_rst ? 0 : (
    (i_ALU_op ^ `ALU_ADD) >> 2 == 0 ? sum :
    (i_ALU_op ^ `ALU_MUL) >> 2 == 0 ? mul :
    (i_ALU_op ^ `ALU_SLL) >> 2 == 0 ? shift :
    (i_ALU_op ^ `ALU_AND) >> 2 == 0 ? binary :
    (i_ALU_op ^ `ALU_SLT) >> 2 == 0 ? slt :
    (i_ALU_op ^ `ALU_BEQ) >> 2 == 0 ? (beq ? i_branch_val_i : 4) :
    114514
);

assign o_overflow = i_rst ? 0 : (
    (i_ALU_op == `ALU_ADD) ? ((i_src1[`REG_MAX_LEN]&i_src2[`REG_MAX_LEN]&~sum[`REG_MAX_LEN]) | (~i_src1[`REG_MAX_LEN]&~i_src2[`REG_MAX_LEN]&sum[`REG_MAX_LEN])) :
    (i_ALU_op == `ALU_SUB) ? ((i_src1[`REG_MAX_LEN]&~i_src2[`REG_MAX_LEN]&~sum[`REG_MAX_LEN]) | (~i_src1[`REG_MAX_LEN]&i_src2[`REG_MAX_LEN]&sum[`REG_MAX_LEN])) :
    0
);

endmodule

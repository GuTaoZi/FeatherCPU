`timescale 1ns / 1ps
`include "ParamDef.vh"
`include "InstDef.vh"

module inst_decoder(
    input[`INST_LEN] i_inst,
    output o_rs1_ena,
    output o_rs2_ena,
    output[`REG_IDX_LEN] o_rs1_idx,
    output[`REG_IDX_LEN] o_rs2_idx,
    output[`INST_TYPES_WIDTH] o_inst_type
);
endmodule

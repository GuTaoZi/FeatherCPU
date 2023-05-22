`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/22 15:22:21
// Design Name: 
// Module Name: top
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

module top(
input clk,
input rst,
input upg_rx,
input [3:0] kb_row,
output [3:0] kb_col,
output upg_tx,
output [23:0] led_o,
output [7:0] seg_cho,
output [7:0] seg_lit
    );
    
wire upg_clk;
wire uart_ena;
wire [14:0] uart_addr;
wire [31:0] uart_data;
wire uart_done;

upg_clk_wiz upg_clk_wiz_u(
    .reset(rst),
    .clk_in1(clk),
    .upg_clk_o(upg_clk)
);

uart0 muart(
    .upg_clk_i(upg_clk),
    .upg_rst_i(rst),
    .upg_rx_i(upg_rx),
    .upg_clk_o(uart_clk),
    .upg_wen_o(uart_ena),
    .upg_adr_o(uart_addr),
    .upg_dat_o(uart_data),
    .upg_done_o(uart_done),
    .upg_tx_o(upg_tx)
);

reg [2:0] cnt;
always @(posedge clk) begin
    cnt = cnt + 1;
end

assign cpu_clk = cnt[2];


reg [2:0] state;

always @(posedge cpu_clk) begin
    state = state + 1;

end

wire [31:0] pc;
wire [31:0] inst;

InsMem if(
    .pc(pc),
    .clk(clk),
    .uart_ena(uart_ena),
    .uart_done(uart_addr[14] == 1'b1 ? 1 : uart_done),
    .uart_clk(uart_clk),
    .uart_addr(uart_addr[13:0]),
    .uart_data(uart_data),
    .inst(inst)
);

// direct from decoder, some of them might be none of use (like non-sense rd)
wire [`REG_IDX_LEN] rs1_idx_raw;
wire [`REG_IDX_LEN] rs2_idx_raw;
wire [`REG_IDX_LEN] rd_idx_raw;
wire [`REG_WIDTH] imm_raw;

wire [`ALU_OP_LEN] alu_op;
wire reg_dst_en;
wire branch_en;
wire branch_

inst_decoder id(
    .i_inst(inst),
    .o_rs1_idx(rs1_idx_raw),
    .o_rs2_idx(rs2_idx_raw),
    .o_rd_idx(rd_idx_raw),
    .o_imm(imm_raw),
    .o_alu_op(alu_op_raw),
    .o_reg_dst, // 
    .o_mem_read,
    .o_mem_write,
    .o_mem_to_reg,
    .o_alu_src,
    .o_reg_write
);

Register reg(
.read_addr1,
.read_addr2,
.write_addr,
.write_data,
.RegWrite,
.clk(cpu_clk),
///input///
///output///
.read_data1,
.read_data2
);

ALU alu(
.src1,
.src2,
.branch_val_i,
.ALU_op(alu_op_raw),
.rst(rst),
///input///
///output///
.opt,
.branch_val_o,
.overflow
);

wire [31:0] hdw_switch_data;

DMA dma(
.hdw_clk(clk),
.cpu_clk(hdw_clk),
.cpu_mem_ena, // If CPU need DMemory
.cpu_addr,
.cpu_write_data,
.cpu_mem_read_ena,
.cpu_mem_write_ena,
.hdw_switch_data(hdw_switch_data[23:0]),
.uart_ena(uart_ena),
.uart_done(uart_done),
.uart_clk(uart_clk),
.uart_addr(uart_addr),
.uart_data(uart_data),
///input////
///output///
.read_data,
.hdw_led_data(led_o)
);

key_bd kb(
.clk(clk),
.rst(rst),
.row(kb_row),
///input///
///output///
.col(kb_col),
.data(hdw_switch_data),
.seg_cho(seg_cho),
.seg_lit(seg_lit)
);

endmodule

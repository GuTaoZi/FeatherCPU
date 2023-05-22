`timescale 1ns / 1ps
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

upg_clk_wiz u_upg_clk_wiz(
    .reset(rst),
    .clk_in1(clk),
    .upg_clk_o(upg_clk)
);

uart0 u_uart0(
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
reg actual_reg_write_en;

always @(posedge cpu_clk) begin
    state = state + 1;

end

wire [31:0] pc;
wire [31:0] inst;

InsMem u_InsMem(
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
wire [`REG_WIDTH] data_from_mem;

wire [`ALU_OP_LEN] alu_op;
wire mem_read_en;
wire mem_write_en;
wire mem_to_reg_en;
wire alu_src_from_2_regs;
wire reg_write_en;
wire [2:0] inst_type;

inst_decoder u_inst_decoder(
    .i_inst(inst),
    .o_rs1_idx(rs1_idx_raw),
    .o_rs2_idx(rs2_idx_raw),
    .o_rd_idx(rd_idx_raw),
    .o_imm(imm_raw),
    .o_alu_op(alu_op_raw),
    .o_mem_read(mem_read_en),
    .o_mem_write(mem_write_en),
    .o_mem_to_reg(mem_to_reg_en),
    .o_alu_src(alu_src_from_2_regs),
    .o_reg_write(reg_write_en),
    .o_inst_type(inst_type)
);

wire [`REG_WIDTH] reg_data1;
wire [`REG_WIDTH] reg_data2;

Register u_Register(
    .read_addr1(rs1_idx_raw),
    .read_addr2(rs2_idx_raw),
    .write_addr(rd_idx_raw),
    .write_data(data_from_mem),
    .write_en(reg_write_en),
    .clk(cpu_clk),
    ///input///
    ///output///
    .read_data1(reg_data1),
    .read_data2(reg_data2)
);

wire [`REG_WIDTH] src1 = 
(inst[6:0]==`I_LW)?(reg_data1):     // rd = rs1 + offset
(inst_type==`S_TYPE)?(reg_data1):   // rd = rs1 + offset
(inst_type==`R_TYPE)?(reg_data1):   // rd = rs1 ? rs2
(inst_type==`I_TYPE)?(reg_data1):   // rs = rs1 ? imm
(inst_type==`B_TYPE)?(reg_data1):   // rs1 == rs2
(inst_type==`U_TYPE)?(imm_raw):0;   // imm << 12

wire [`REG_WIDTH] src2 =
(inst[6:0]==`I_LW)?(imm_raw):
(inst_type==`S_TYPE)?(imm_raw):
(inst_type==`R_TYPE)?(reg_data2):
(inst_type==`I_TYPE)?(imm_raw):
(inst_type==`B_TYPE)?(reg_data2):
(inst_type==`U_TYPE)?(12):0;

wire [`REG_WIDTH] alu_opt;
wire [`REG_WIDTH] branch_val;
wire overflow_raw;


ALU alu(
    .src1(src1),
    .src2(src2),
    .branch_val_i(imm_raw),
    .ALU_op(alu_op_raw),
    .rst(rst),
    ///input///
    ///output///
    .ALU_ouput(alu_opt),
    .branch_val_o(branch_val),
    .overflow(overflow_raw)
);

wire [`REG_WIDTH] hdw_switch_data;

DMA dma(
    .hdw_clk(clk),
    .cpu_clk(hdw_clk),
    .cpu_mem_ena(mem_read_en | mem_write_en), // If CPU need DMemory
    .cpu_addr(alu_opt),
    .cpu_write_data(reg_data2),
    .cpu_mem_read_ena(mem_read_en),
    .cpu_mem_write_ena(mem_write_en),
    .hdw_switch_data(hdw_switch_data[23:0]),
    .uart_ena(uart_ena),
    .uart_done(uart_done),
    .uart_clk(uart_clk),
    .uart_addr(uart_addr),
    .uart_data(uart_data),
    ///input////
    ///output///
    .read_data(data_from_mem),
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

PC u_PC(
    .clk(cpu_clk),
    .rst(rst),
    .J((inst_type==`J_TYPE && )),
    .Jal,
    .branch,
    .J_val,   // from instruction
    .Jal_val, // from register
    .branch_val(branch_val), // from ALU
    ///input///
    ///output///
    .pc(pc)
);

endmodule

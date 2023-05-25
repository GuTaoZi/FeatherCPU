`timescale 1ns / 1ps
`include "ParamDef.vh"

module Top(
    input           fpga_clk,
    input           rst,
    input           upg_rx,
    input  [3:0]    kb_row,
    input           debug_btn,
    input  [`SWITCH_WIDTH]   sw,
    input           kb_ack_btn,
    input           kb_cancel_btn,
    output [3:0]    kb_col,
    output          upg_tx,
    output [`LED_WIDTH]   led_o,
    output [7:0]    seg_cho,
    output [7:0]    seg_lit
);

reg [25:0] cntw;
always @(posedge fpga_clk) begin
    if(rst) begin
        cntw = 0;
    end else begin
        cntw = cntw + 1'b1;
    end
end

wire clk;
assign clk = sw[0] ? cntw[23] : fpga_clk;


//wire debug_btn_fil;
//filter debug_btn_filter(
//.i_clk(fpga_clk),
//.i_rst(rst),
//.i_inp(debug_btn),
//.o_output(debug_btn_fil));

reg [2:0] debug_state = 0;
// 00: show keyboard input
// 01: show current instruction
// 10: show current pc
// 11: show value of reg[sw[23:16]]
// plus one at negedge of debug_btn(P5) 

reg debug_btn_state = 0;

always @(posedge fpga_clk)
begin
    if(debug_btn_state != debug_btn) begin
        debug_btn_state = debug_btn;

        if(~debug_btn)
        begin
            debug_state = debug_state+1'b1;
            if(debug_state == 7)
                debug_state = 3'b000;
        end
    end
end
    
wire upg_clk;
wire uart_ena;
wire [14:0] uart_addr;
wire [31:0] uart_data;
wire uart_done;

upg_clk_wiz u_upg_clk_wiz(
    .reset(rst),
    .clk_in1(fpga_clk),
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

reg [2:0] cnt = 0;
always @(negedge clk, posedge rst) begin
    if(rst) begin
        cnt = 0;
    end else begin
        cnt = cnt + 1;
    end
end

assign cpu_clk = cnt[1];


reg [1:0] state;

always @(negedge cnt[0], posedge rst) begin
    if(rst) begin
        state = 2'b00;
    end else begin
        state = state + 1'b1;
    end
end

wire [31:0] pc;
wire [31:0] inst;

InsMem u_InsMem(
    .i_pc(pc),
    .i_clk(cpu_clk),
    .i_uart_ena(uart_ena),
    .i_uart_done(uart_addr[14] == 1'b1 ? 1'b1 : uart_done),
    .i_uart_clk(uart_clk),
    .i_uart_addr(uart_addr[13:0]),
    .i_uart_data(uart_data),
    ///input///
    ///output///
    .o_inst(inst)
);

// direct from decoder, some of them might be none of use (like non-sense rd)
wire [`REG_IDX_LEN] rs1_idx_raw;
wire [`REG_IDX_LEN] rs2_idx_raw;
wire [`REG_IDX_LEN] rd_idx_raw = inst[11:7];
wire [`REG_WIDTH] imm_raw;
wire [`REG_WIDTH] data_from_mem;

wire [`ALU_OP_LEN] alu_op_raw;

wire mem_read_en;
wire mem_write_en;
// DONE while state == 2'b11 !!!!!!!!!!!!!!!!!!!!!!

wire mem_to_reg_en;
wire [`INST_TYPES_WIDTH] inst_type;
wire reg_write_en_from_id = !(inst_type == `S_TYPE || inst_type ==`B_TYPE);

inst_decoder u_inst_decoder(
    .i_inst(inst),
    ///input///
    ///output///
    .o_rs1_idx(rs1_idx_raw),
    .o_rs2_idx(rs2_idx_raw),
//    .o_rd_idx(rd_idx_raw),
    .o_imm(imm_raw),
    .o_alu_op(alu_op_raw),
    .o_mem_read(mem_read_en),
    .o_mem_write(mem_write_en),
    .o_mem_to_reg(mem_to_reg_en),
//    .o_reg_write(reg_write_en_from_id),
    .o_inst_type(inst_type)
);

wire [`REG_WIDTH] reg_data1;
wire [`REG_WIDTH] reg_data2;
wire [`REG_WIDTH] reg_debug;

wire [`REG_WIDTH] alu_opt;
wire overflow_raw;

wire [`REG_WIDTH] pc_write_back_jalr;
wire register_write_enable_of_id_and_pc=(state==2'b11)&(reg_write_en_from_id);
wire [`REG_WIDTH] data_write_into_register = (inst[6:0]==`I_LW)     ?   data_from_mem           :
                                            (inst[6:0]==`J_JALR)    ?   pc_write_back_jalr      :
                                            (inst[6:0]==`J_JAL)     ?   pc_write_back_jalr      :
                                            alu_opt;
wire reg_write;

Register u_Register(
    .i_read_addr1(rs1_idx_raw),
    .i_read_addr2(rs2_idx_raw),
    .i_write_addr(rd_idx_raw),
    .i_write_data(data_write_into_register),
    .i_write_en(register_write_enable_of_id_and_pc),
    .i_clk(cpu_clk),
    .i_rst(rst),
    .i_debug_idx(sw[23:19]),
    ///input///
    ///output///
    .o_read_data1(reg_data1),
    .o_read_data2(reg_data2),
    .o_debug_data(reg_debug),
    .o_writing(reg_write)
);

wire [`REG_WIDTH] src1 = 
(inst[6:0]==`I_LW)?(reg_data1):     // rd = rs1 + offset
(inst_type==`S_TYPE)?(reg_data1):   // rd = rs1 + offset
(inst_type==`R_TYPE)?(reg_data1):   // rd = rs1 ? rs2
(inst_type==`I_TYPE)?(reg_data1):   // rs = rs1 ? imm
(inst_type==`B_TYPE)?(reg_data1):   // rs1 == rs2
(inst_type==`U_TYPE)?(imm_raw):     // imm << 12
(inst[6:0]==`J_JALR)?(reg_data1):
(inst[6:0]==`J_JAL)?0:0; // pc = rs1 + imm

wire [`REG_WIDTH] src2 =
(inst[6:0]==`I_LW)?(imm_raw):
(inst_type==`S_TYPE)?(imm_raw):
(inst_type==`R_TYPE)?(reg_data2):
(inst_type==`I_TYPE)?(imm_raw):
(inst_type==`B_TYPE)?(reg_data2):
(inst_type==`U_TYPE)?(4'd12):
(inst[6:0]==`J_JALR)?(imm_raw):
(inst[6:0]==`J_JAL)?(imm_raw):0;

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

wire [`SWITCH_WIDTH] hdw_switch_data = sw;
wire [`REG_WIDTH] hdw_keybd_data;
wire [`LED_WIDTH] hdw_led_data;

//filter kb_ack_btn_filter(
//.i_clk(fpga_clk),
//.i_rst(rst),
//.i_inp(kb_ack_btn),
//.o_output(kb_ack_btn_fil));

wire dma_mem_write;

DMA dma(
    .hdw_clk(clk),
    .cpu_clk(cpu_clk),
    .cpu_mem_ena((mem_read_en | mem_write_en) & (state == 2'b01 | state == 2'b10)), // If CPU need DMemory
    .cpu_addr(alu_opt),
    .cpu_write_data(reg_data2),
    .cpu_mem_read_ena(mem_read_en),
    .cpu_mem_write_ena(mem_write_en),
    .hdw_keybd_data(hdw_keybd_data),
    .hdw_sw_data(hdw_switch_data),
    .hdw_ack_but(kb_ack_btn),
    .uart_ena(uart_ena & uart_addr[14]),
    .uart_done(uart_done),
    .uart_clk(uart_clk),
    .uart_addr(uart_addr[13:0]),
    .uart_data(uart_data),
    ///input////
    ///output///
    .read_data(data_from_mem),
    .hdw_led_data(hdw_led_data),
    .o_dma_write(dma_mem_write)
);

wire [`REG_WIDTH] nxt_pc;
wire seg_custom_en = (debug_state==3'b000)?1'b0:1'b1;
wire [31:0] seg_custom_data =({(4'd0 + debug_state),28'h0})|
            ((debug_state==3'b001)?inst:
            (debug_state==3'b010)?pc:
            (debug_state==3'b011)?reg_debug:
            (debug_state==3'b100)?imm_raw:
            (debug_state==3'b101)?alu_opt:
            (debug_state==3'b110)?rd_idx_raw:
            data_write_into_register);

Keyboard_N_Segtube u_keyboard_segtube(
    .i_clk(fpga_clk),
    .i_rst(rst),
    .i_row(kb_row),
    .i_custom_en(seg_custom_en),
    .i_custom_data(seg_custom_data),
    .i_cancel_btn(kb_cancel_btn),
    ///input///
    ///output///
    .o_col(kb_col),
    .o_data(hdw_keybd_data),
    .o_seg_cho(seg_cho),
    .o_seg_lit(seg_lit)
);

wire i_Jal = (inst[6:0]==`J_JAL)?1'b1:1'b0;
wire i_Jalr = (inst[6:0]==`J_JALR)?1'b1:1'b0;
wire i_pc_en =(state==2'b00)?1'b1:1'b0;
wire i_branch = (inst_type==`B_TYPE)?1'b1:1'b0;
wire [0:0] pc_bundle = {cpu_clk};

PC u_PC(
    .i_clk(cpu_clk),
    .i_rst(rst),
    .i_Jal(i_Jal),
    .i_Jalr(i_Jalr),
    .i_pc_en(i_pc_en),
    .i_branch(i_branch),
    .i_Jal_imm(imm_raw),
    .i_alu_val(alu_opt), // from ALU
    ///input///
    ///output///
    .o_pc(pc),
    .o_next_pc(nxt_pc),
    .o_pc_rb(pc_write_back_jalr)
);

assign led_o = hdw_led_data;

endmodule

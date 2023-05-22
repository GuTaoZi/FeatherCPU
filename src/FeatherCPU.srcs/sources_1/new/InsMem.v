`timescale 1ns / 1ps

`include "ParamDef.vh"

module InsMem(
    input   [`REG_WIDTH]    i_pc,
    input                   i_clk, // Be aware of that NEED 2 CYCLES to read data
    input                   i_uart_ena,
    input                   i_uart_done,
    input                   i_uart_clk,
    input   [13:0]          i_uart_addr,
    input   [`REG_WIDTH]    i_uart_data,
    output  [`INST_LEN]     o_inst
);

assign kick_off = ~i_uart_ena | i_uart_done;

ins_mem im( .addra(kick_off ? i_pc[13:0] : i_uart_addr),
            .clka(kick_off ? i_clk : i_uart_clk),
            .dina(kick_off ? 0 : i_uart_data),
            .douta(o_inst),
            .wea(~kick_off));

endmodule

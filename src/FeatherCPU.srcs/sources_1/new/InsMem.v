`timescale 1ns / 1ps

`include "ParamDef.vh"

module InsMem(
input   [`REG_WIDTH]    pc,
input                   clk, // Be aware of that NEED 2 CYCLES to read data
input                   uart_ena,
input                   uart_done,
input                   uart_clk,
input   [13:0]          uart_addr,
input   [`REG_WIDTH]    uart_data,
output  [`INST_LEN]     ins
    );

assign kick_off = ~uart_ena | uart_done;

ins_mem im( .addra(kick_off ? pc[13:0] : uart_addr),
            .clka(kick_off ? clk : uart_clk),
            .dina(kick_off ? 0 : uart_data),
            .douta(ins),
            .wea(~kick_off));

endmodule

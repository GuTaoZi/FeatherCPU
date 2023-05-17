`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/28 15:42:03
// Design Name: 
// Module Name: InsMem
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

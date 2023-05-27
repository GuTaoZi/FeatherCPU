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

/****************************************************************
 port               I/O     Src/Dst     Description
 i_pc                I        PC        Program counter
 i_clk               I       H'ware     FPGA clock signal
 i_uart_ena          I       Uart       Uart-write enable signal
 i_uart_done         I       Uart       Uart write-complete signal
 i_uart_clk          I       Uart       Uart clock signal
 i_uart_addr         I       Uart       Uart-write memory address
 i_uart_data         I       Uart       Data to write in, from uart
 o_inst              O        ID        Instruction read out
****************************************************************/

assign kick_off = ~i_uart_ena | i_uart_done;

ins_mem im( .addra(kick_off ? i_pc[15:2] : i_uart_addr),
            .clka(kick_off ? i_clk : i_uart_clk),
            .dina(kick_off ? 0 : i_uart_data),
            .douta(o_inst),
            .wea(~kick_off));

endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/17 18:42:03
// Design Name: 
// Module Name: DMA
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

module DMA(
input                   hdw_clk,
input                   cpu_clk,
input                   cpu_mem_ena, // If CPU need DMemory
input   [`REG_WIDTH]    cpu_addr,
input   [`REG_WIDTH]    cpu_write_data,
input                   cpu_mem_read_ena,
input                   cpu_mem_write_ena,

input   [23:0]          hdw_switch_data,

input                   uart_ena,
input                   uart_done,
input                   uart_clk,
input   [13:0]          uart_addr,
input   [`REG_WIDTH]    uart_data,

output  [`REG_WIDTH]    read_data,
output  [23:0]          hdw_led_data
    );

assign kick_off = ~uart_ena | uart_done;

reg [5:0]           tran_pos;
reg [`REG_WIDTH]    mem_addr;
reg [`REG_WIDTH]    write_data;
reg                 mem_read;
reg                 mem_write;

DataMem myDM(   .addr(kick_off ? mem_addr : uart_addr),
                .write_data(kick_off ? write_data : uart_data),
                .mem_read(kick_off ? mem_read : 0),
                .mem_write(kick_off ? mem_write : ~uart_done),
                .clk(kick_off ? hdw_clk : uart_clk),
                .read_data(read_data));

always @(posedge cpu_clk) begin
    if(cpu_mem_ena) begin
        mem_addr = cpu_addr;
        mem_read = cpu_mem_read_ena;
        mem_write = cpu_mem_write_ena;
        write_data = cpu_write_data;
    end else begin
        if(tran_pos[5]) begin
            write_addr = `MMIO_sw_map_addr;
            write_data = {8'b0, hdw_switch_data};
            mem_read = 0;
            mem_write = 1;
        end else begin
            mem_addr = `MMIO_led_map_addr;
            hdw_led_data = read_data[23:0];
            mem_read = 1;
            mem_write = 0;
        end
        tran_pos = tran_pos + 1'b1;
    end
end

endmodule

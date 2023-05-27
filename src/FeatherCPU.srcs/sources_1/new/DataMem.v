`timescale 1ns / 1ps

`include "ParamDef.vh"

module DataMem(
    input   [13:0]          i_addr,
    input   [`REG_WIDTH]    i_write_data,
    input                   i_mem_read,
    input                   i_mem_write,
    input                   i_clk, // NEED 2 CYCLES !!
    output  [`REG_WIDTH]    o_read_data
);

/****************************************************************
 port           I/O     Src/Dst     Description
 i_addr          I        DMA       The address of demanded data
 i_write_data    I        DMA       The data to write in
 i_mem_read      I        DMA       Read enable
 i_mem_write     I        DMA       Write enable
 i_clk           I        DMA       FPGA clock signal
 o_read_data     O        DMA       Data read out
****************************************************************/

wire [`REG_WIDTH] mem_out;
assign o_read_data = i_mem_read ? mem_out : 32'b0;
data_mem dm(.addra(i_addr), .clka(i_clk), .dina(i_write_data), .douta(mem_out), .wea(i_mem_write));

endmodule

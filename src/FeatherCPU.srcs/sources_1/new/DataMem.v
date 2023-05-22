`timescale 1ns / 1ps

`include "ParamDef.vh"

module DataMem(
    input   [`REG_WIDTH]    i_addr,
    input   [`REG_WIDTH]    i_write_data,
    input                   i_mem_read,
    input                   i_mem_write,
    input                   i_clk, // NEDD 2 CYCLES !!
    output  [`REG_WIDTH]    o_read_data
);
wire [`REG_WIDTH] mem_out;
assign o_read_data = i_mem_read ? mem_out : 32'b0;
data_mem dm(.addra(i_addr[13:0]), .clka(i_clk), .dina(i_write_data), .douta(mem_out), .wea(i_mem_write));

endmodule

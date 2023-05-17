`timescale 1ns / 1ps

`include "ParamDef.vh"

module DataMem(
input   [`REG_WIDTH]    addr,
input   [`REG_WIDTH]    write_data,
input                   mem_read,
input                   mem_write,
input                   clk, // NEDD 2 CYCLES !!
output  [`REG_WIDTH]    read_data
    );
wire [`REG_WIDTH] mem_out;
assign read_data = mem_read ? mem_out : 32'b0;
data_mem dm(.addra(addr[13:0]), .clka(clk), .dina(write_data), .douta(mem_out), .wea(mem_write));

endmodule

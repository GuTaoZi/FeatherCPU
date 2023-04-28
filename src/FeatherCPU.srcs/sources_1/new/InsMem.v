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
input                   write_enable,
input   [`REG_WIDTH]    write_addr,
input   [`INST_LEN]     write_data,
input                   clk, // Be aware of that NEED 2 CYCLES to read data
output  [`INST_LEN]     ins
    );
wire [`REG_WIDTH] mem_addr;
assign mem_addr = write_enable ? write_addr : pc;
ins_mem im(.addra(mem_addr[13:0]), .clka(clk), .dina(write_data), .douta(ins), .wea(write_enable));

endmodule

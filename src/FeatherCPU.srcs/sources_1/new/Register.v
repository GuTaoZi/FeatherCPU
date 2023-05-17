`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/28 15:21:54
// Design Name: 
// Module Name: Register
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

module Register(
input   [`REG_IDX_LEN]  read_addr1,
input   [`REG_IDX_LEN]  read_addr2,
input   [`REG_IDX_LEN]  write_addr,
input   [`REG_WIDTH]    write_data,
input                   RegWrite,
input                   clk,
output [`REG_WIDTH] read_data1,
output [`REG_WIDTH] read_data2
    );

reg [`REG_WIDTH] registers [`REG_NUMBERS : 0];

always @(negedge clk)
begin
    if(RegWrite && write_addr != 5'b00000) begin
        registers[write_addr] <= write_data;
    end
end

assign read_data1 = registers[read_addr1];
assign read_data2 = registers[read_addr2];

endmodule

`timescale 1ns / 1ps

`include "ParamDef.vh"

module Register(
input   [`REG_IDX_LEN]  read_addr1,
input   [`REG_IDX_LEN]  read_addr2,
input   [`REG_IDX_LEN]  write_addr,
input   [`REG_WIDTH]    write_data,
input                   write_en,
input                   clk,
input                   rst,
output [`REG_WIDTH] read_data1,
output [`REG_WIDTH] read_data2
    );

reg [`REG_WIDTH] registers [`REG_NUMBERS : 0];

always @(negedge clk)
begin
    if(write_en && write_addr != 5'b00000) begin
        registers[write_addr] <= write_data;
    end
end

assign read_data1 = registers[read_addr1];
assign read_data2 = registers[read_addr2];

//TODO: sp

endmodule

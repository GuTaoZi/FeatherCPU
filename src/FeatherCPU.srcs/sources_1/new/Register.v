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
output [`REG_WIDTH] read_data2,
output [`REG_WIDTH] read_ra
    );

reg [`REG_WIDTH] registers [`REG_NUMBERS : 0];

assign read_ra = registers[2];

always @(negedge clk)
begin
    if(rst) begin
        registers[0] <= 32'h0000_0000;
        registers[1] <= 32'h0000_0000;
        registers[2] <= 32'h0000_3fe0;
        registers[3] <= 32'h0000_0080;
        registers[4] <= 32'h0000_0000;
        registers[5] <= 32'h0000_0000;
        registers[6] <= 32'h0000_0000;
        registers[7] <= 32'h0000_0000;
        registers[8] <= 32'h0000_0000;
        registers[9] <= 32'h0000_0000;
        registers[10] <= 32'h0000_0000;
        registers[11] <= 32'h0000_0000;
        registers[12] <= 32'h0000_0000;
        registers[13] <= 32'h0000_0000;
        registers[14] <= 32'h0000_0000;
        registers[15] <= 32'h0000_0000;
        registers[16] <= 32'h0000_0000;
        registers[17] <= 32'h0000_0000;
        registers[18] <= 32'h0000_0000;
        registers[19] <= 32'h0000_0000;
        registers[20] <= 32'h0000_0000;
        registers[21] <= 32'h0000_0000;
        registers[22] <= 32'h0000_0000;
        registers[23] <= 32'h0000_0000;
        registers[24] <= 32'h0000_0000;
        registers[25] <= 32'h0000_0000;
        registers[26] <= 32'h0000_0000;
        registers[27] <= 32'h0000_0000;
        registers[28] <= 32'h0000_0000;
        registers[29] <= 32'h0000_0000;
        registers[30] <= 32'h0000_0000;
        registers[31] <= 32'h0000_0000;
    end else begin
        if(write_en && write_addr != 5'b00000) begin
            registers[write_addr] <= write_data;
        end
    end
end

assign read_data1 = registers[read_addr1];
assign read_data2 = registers[read_addr2];

endmodule

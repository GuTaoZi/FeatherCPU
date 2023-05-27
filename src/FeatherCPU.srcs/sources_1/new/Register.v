`timescale 1ns / 1ps

`include "ParamDef.vh"

module Register(
    input   [`REG_IDX_LEN]  i_read_addr1,
    input   [`REG_IDX_LEN]  i_read_addr2,
    input   [`REG_IDX_LEN]  i_write_addr,
    input   [`REG_WIDTH]    i_write_data,
    input                   i_write_en,
    input                   i_clk,
    input                   i_rst,
    input   [`REG_IDX_LEN]  i_debug_idx,
    output [`REG_WIDTH] o_read_data1,
    output [`REG_WIDTH] o_read_data2,
    output [`REG_WIDTH] o_debug_data
);

 port           I/O     Src/Dst     Description
 i_read_addr1    I        ID        Index of first register
 i_read_addr2    I        ID        Index of second register
 i_write_addr    I        ID        Index of write-back register
 i_write_data    I        Top       Data to write back
 i_write_en      I        Top       Write back enable
 i_clk           I        Top       CPU clock signal
 i_rst           I      H'ware      Reset signal
 i_debug_idx     I        Top       Index of register to display
 o_read_data1    O        ALU       Value of first register
 o_read_data2    O        ALU       Value of second register
 o_debug_data    O        ALU       Value of display register

reg [`REG_WIDTH] registers [`REG_NUMBERS : 0];

assign o_read_ra = registers[1];

always @(posedge i_write_en, posedge i_rst)
begin
    if(i_rst) begin
        registers[0] = 32'h0000_0000;
        registers[1] = 32'h0000_0000;
        registers[2] = 32'h0000_ff80;
        registers[3] = 32'h0000_0080;
        registers[4] = 32'h0000_0000;
        registers[5] = 32'h0000_0000;
        registers[6] = 32'h0000_0000;
        registers[7] = 32'h0000_0000;
        registers[8] = 32'h0000_0000;
        registers[9] = 32'h0000_0000;
        registers[10] = 32'h0000_0000;
        registers[11] = 32'h0000_0000;
        registers[12] = 32'h0000_0000;
        registers[13] = 32'h0000_0000;
        registers[14] = 32'h0000_0000;
        registers[15] = 32'h0000_0000;
        registers[16] = 32'h0000_0000;
        registers[17] = 32'h0000_0000;
        registers[18] = 32'h0000_0000;
        registers[19] = 32'h0000_0000;
        registers[20] = 32'h0000_0000;
        registers[21] = 32'h0000_0000;
        registers[22] = 32'h0000_0000;
        registers[23] = 32'h0000_0000;
        registers[24] = 32'h0000_0000;
        registers[25] = 32'h0000_0000;
        registers[26] = 32'h0000_0000;
        registers[27] = 32'h0000_0000;
        registers[28] = 32'h0000_0000;
        registers[29] = 32'h0000_0000;
        registers[30] = 32'h0000_0000;
        registers[31] = 32'h0000_0000;
    end else if(i_write_en && (i_write_addr != 5'b00000)) begin
        registers[i_write_addr] = i_write_data;
    end
end

assign o_read_data1 = registers[i_read_addr1];
assign o_read_data2 = registers[i_read_addr2];
assign o_debug_data = registers[i_debug_idx];

endmodule

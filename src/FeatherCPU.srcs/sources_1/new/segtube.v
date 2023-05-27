`timescale 1ns / 1ps

module segtube(
    input i_clk,
    input [31:0] i_dat,
    output reg[7:0] o_seg_cho,
    output reg[7:0] o_seg_lit
);
/****************************************************************
 port           I/O     Src/Dst     Description
 i_clk           I      H'ware      FPGA clock signal
 i_dat           I      Key_Seg     Data to display
 o_seg_cho       O      Key_Seg     Segment tube select signal
 o_seg_lit       O      Key_Seg     Segment tube data
****************************************************************/

wire[7:0] num2seg [15:0];
assign num2seg[0] = 8'b1100_0000; // 0
assign num2seg[1] = 8'b1111_1001; // 1
assign num2seg[2] = 8'b1010_0100; // 2
assign num2seg[3] = 8'b1011_0000; // 3
assign num2seg[4] = 8'b1001_1001; // 4
assign num2seg[5] = 8'b1001_0010; // 5
assign num2seg[6] = 8'b1000_0010; // 6
assign num2seg[7] = 8'b1111_1000; // 7
assign num2seg[8] = 8'b1000_0000; // 8
assign num2seg[9] = 8'b1001_0000; // 9
assign num2seg[10] = 8'b1000_1000; // A
assign num2seg[11] = 8'b1000_0011; // B
assign num2seg[12] = 8'b1100_0110; // C
assign num2seg[13] = 8'b1010_0001; // D
assign num2seg[14] = 8'b1000_0110; // E
assign num2seg[15] = 8'b1000_1110; // F

wire [3:0] val [7:0];

assign val[0] = {i_dat[3:0]};
assign val[1] = {i_dat[7:4]};
assign val[2] = {i_dat[11:8]};
assign val[3] = {i_dat[15:12]};
assign val[4] = {i_dat[19:16]};
assign val[5] = {i_dat[23:20]};
assign val[6] = {i_dat[27:24]};
assign val[7] = {i_dat[31:28]};

reg [16:0] cnt;

always @(posedge i_clk)
begin
    cnt <= cnt + 1'b1;
end

wire seg_clk;
assign seg_clk = cnt[16];

reg [2:0] counter = 3'b000;
reg [7:0] cho = 8'b1111_1110;
reg [7:0] tmp = 8'b1111_1110;

always @(posedge seg_clk)
begin
    o_seg_cho = cho;
    o_seg_lit = num2seg[val[counter]];
    counter = counter + 1'b1;
    tmp = (cho << 1'b1) ^ 1'b1;
    cho = (tmp == 8'b1111_1111)? 8'b1111_1110:tmp;
end

endmodule

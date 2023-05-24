module Keyboard_N_Segtube(
    input i_clk,
    input i_rst,
    input  [3:0]        i_row,
    output [3:0]        o_col,
    output reg [31:0]   o_data,
    output [7:0]        o_seg_cho,
    output [7:0]        o_seg_lit
);

reg [31:0] my_data;
wire [3:0] data;
wire ena;

Keyboard kb(
    .i_clk(i_clk),
    .i_rst(i_rst),
    .i_row(i_row),
    .o_col(o_col), 
    .o_data(data),
    .o_enable(ena)
);

always @(posedge ena) begin
    my_data = {my_data[27:0], data};
    if(my_data[19:16] == 4'h1) begin
        o_data = my_data;
        my_data = 0;
    end
end

segtube sg(
    .i_clk(i_clk),
    .i_dat(my_data),
    .o_seg_cho(o_seg_cho),
    .o_seg_lit(o_seg_lit)
);

endmodule
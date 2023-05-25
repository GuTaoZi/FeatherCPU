module Keyboard_N_Segtube(
    input i_clk,
    input i_rst,
    input i_cancel_btn,
    input  [3:0]        i_row,
    input i_custom_en,
    input  [31:0]       i_custom_data,
    output [3:0]        o_col,
    output reg [31:0]   o_data,
    output [7:0]        o_seg_cho,
    output [7:0]        o_seg_lit
);

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


always @(posedge ena, posedge i_cancel_btn) begin
    if(i_cancel_btn) begin
        o_data = 0;
    end else begin
        o_data = {o_data[27:0], data};
    end
end

segtube sg(
    .i_clk(i_clk),
    .i_dat(i_custom_en?i_custom_data:o_data),
    .o_seg_cho(o_seg_cho),
    .o_seg_lit(o_seg_lit)
);

endmodule
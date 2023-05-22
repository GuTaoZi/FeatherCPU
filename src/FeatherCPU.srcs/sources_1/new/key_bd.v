module key_bd(
    input clk,
    input rst,
    input  [3:0]        row,
    output [3:0]        col,
    output reg [31:0]   data,
    output [7:0]        seg_cho,
    output [7:0]        seg_lit
);

reg [31:0] my_data;
wire [3:0] dt;
wire ena;

Keyboard kb(.clk(clk), .rst(rst), .row(row), .col(col), .data(dt), .enable(ena));

always @(posedge ena) begin
    my_data = {my_data[27:0], dt};
    if(my_data[19:16] == 4'h1) begin
        data = my_data;
        my_data = 0;
    end
end

segtube sg(
    .clk(clk),
    .dat(my_data),
    .seg_cho(seg_cho),
    .seg_lit(seg_lit)
);

endmodule
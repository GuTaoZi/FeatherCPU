module keyboard(
    input clk,
    input rst,
    input  [3:0]     row,
    output reg [3:0] col,
    output reg [3:0] data
);

reg [10:0] clkcnt;

always @(posedge clk)
begin
    clkcnt <= clkcnt +1'b1;
end

wire [1:0] keyclk = clkcnt[10:9];

always @(posedge clk)
begin
//    case (keyclk)
//        2'b00: col = 4'b1110;
//        2'b01: col = 4'b1101;
//        2'b10: col = 4'b1011;
//        2'b11: col = 4'b0111;
//    endcase
    col = 4'b1111 ^ (1<<keyclk);
    case({row,col})
        8'b1110_1110: data = 4'h1;
        8'b1101_1110: data = 4'h4;
        8'b1011_1110: data = 4'h7;
        8'b0111_1110: data = 4'hf;
        8'b1110_1101: data = 4'h2;
        8'b1101_1101: data = 4'h5;
        8'b1011_1101: data = 4'h8;
        8'b0111_1101: data = 4'h0;
        8'b1110_1011: data = 4'h3;
        8'b1101_1011: data = 4'h6;
        8'b1011_1011: data = 4'h9;
        8'b0111_1011: data = 4'he;
        8'b1110_0111: data = 4'ha;
        8'b1101_0111: data = 4'hb;
        8'b1011_0111: data = 4'hc;
        8'b0111_0111: data = 4'hd;
        default: data = 4'h0;
    endcase
end
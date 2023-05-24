`timescale 1ns / 1ps

module SignedTest();
reg clk = 0;
reg rst = 0;
reg inp = 0;
wire opt;
filter ft(
.i_clk(clk),
.i_rst(rst),
.i_inp(inp),
.o_output(opt));

always #5 clk = ~clk;

initial begin
    #1000;
    inp = 1;
    #1000;
end
endmodule

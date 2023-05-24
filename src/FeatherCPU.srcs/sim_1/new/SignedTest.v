`timescale 1ns / 1ps

module SignedTest(

    );
reg [3:0]A=4'b1000;
reg [3:0]B=4'b0100;
reg [3:0]C;
reg [3:0]D;
always @*
begin
    C=A-B;
    D=$signed(A)-$signed(B);
end
endmodule

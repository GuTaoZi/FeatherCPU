module filter(
input       i_clk,
input       i_rst,
input       i_inp,
output reg  o_output
);

/****************************************************************
 port               I/O     Src/Dst     Description
 i_clk               I      H'ware      FPGA clock
 i_rst               I      H'ware      Reset signal
 i_inp               I      H'ware      Raw signal before de-jittered
 o_output            O        Top       De-jittered signal
****************************************************************/

reg las_state = 0;
reg [20:0] cnt = 0;

always @(posedge i_clk, posedge i_rst) begin
    if(i_rst) begin
        las_state <= 0;
        cnt <= 0;
        o_output <= 0;
    end else if(i_inp == las_state) begin
        cnt <= 0;
        o_output <= las_state;
        las_state <= las_state;
    end else if(cnt[20]==1'b1) begin
        las_state <= i_inp;
        o_output <= i_inp;
        cnt <= 0;
    end else begin
        cnt <= cnt + 1'b1;
        las_state <= las_state;
        o_output <= o_output;
    end
end

endmodule
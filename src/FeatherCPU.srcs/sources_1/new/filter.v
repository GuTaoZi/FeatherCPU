module filter(
input       i_clk,
input       i_rst,
input       i_inp,
output reg  o_output
);

reg las_state = 0;
reg [5:0] cnt = 0;

always @(posedge i_clk, posedge i_rst) begin
    if(i_rst) begin
        las_state = 0;
        cnt = 0;
        o_output = 0;
    end else begin
        if(i_inp == las_state) begin
            cnt = 0;
            o_output = las_state;
        end else begin
            cnt = cnt + 1'b1;
            if(cnt[5]==1'b1) begin
                las_state = i_inp;
                o_output = i_inp;
                cnt = 0;
            end
        end
    end
end

endmodule
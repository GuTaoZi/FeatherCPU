module filter(
input       clk,
input       rst,
input       inp,
output reg  opt,
parameter len = 21
);

reg las_state = 0;
reg [len:0] cnt = 0;

always @(posedge clk) begin
    if(rst) begin
        las_state = 0;
        cnt = 0;
        opt = 0;
    end else begin
        if(inp == las_state) begin
            cnt = 0;
            opt = las_state;
        end else begin
            cnt += 1'b1;
            if(cnt[21]) begin
                las_state = inp;
                opt = inp;
                cnt = 0;
            end
        end
    end
end

endmodule
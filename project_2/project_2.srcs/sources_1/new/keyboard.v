module Keyboard(
    input clk,
    input rst,
    input  [3:0]    row,
    output [3:0]    col,
    output reg [3:0] data,
    output reg enable
);

reg [20:0] clkcnt = 0;

always @(posedge clk)
begin
    if(rst) begin
        clkcnt = 0;
    end else begin
        clkcnt = clkcnt +1'b1;
    end
end

wire [1:0] keyclk = clkcnt[20:19];
assign col = 4'b1111 ^ (1<<keyclk);
reg lock = 0;

reg las_inp;
reg inp;

always @(posedge clkcnt[18])
begin
    if(rst) begin
        data = 0;
		inp = 0;
		las_inp = 0;
    end else begin
        if(col == 4'b1110) begin
			if(inp != las_inp) begin
				if(inp == 1'b0) begin
					enable = 1;
				end else begin
					enable = 0;
				end
				las_inp = inp;
            end else begin
                enable = enable;
            end
			inp = 0;
		end
        case({row,col})
            8'b1110_1110: begin
                if(lock == 1'b0) begin
                    data = 4'h1;
                    lock = 1'b1;
                end
				inp = 1'b1;
            end
            8'b1101_1110: begin
                if(lock == 1'b0) begin
                    data = 4'h4;
                    lock = 1'b1;
                end
				inp = 1'b1;
            end
            8'b1011_1110: begin
                if(lock == 1'b0) begin
                    data = 4'h7;
                    lock = 1'b1;
                end
				inp = 1'b1;
            end
            8'b0111_1110: begin
                if(lock == 1'b0) begin
                    data = 4'hf;
                    lock = 1'b1;
                end
				inp = 1'b1;
            end
            8'b1110_1101: begin
                if(lock == 1'b0) begin
                    data = 4'h2;
                    lock = 1'b1;
                end
				inp = 1'b1;
            end
            8'b1101_1101: begin
                if(lock == 1'b0) begin
                    data = 4'h5;
                    lock = 1'b1;
                end
				inp = 1'b1;
            end
            8'b1011_1101: begin
                if(lock == 1'b0) begin
                    data = 4'h8;
                    lock = 1'b1;
                end
				inp = 1'b1;
            end
            8'b0111_1101: begin
                if(lock == 1'b0) begin
                    data = 4'h0;
                    lock = 1'b1;
                end
				inp = 1'b1;
            end
            8'b1110_1011: begin
                if(lock == 1'b0) begin
                    data = 4'h3;
                    lock = 1'b1;
                end
				inp = 1'b1;
            end
            8'b1101_1011: begin
                if(lock == 1'b0) begin
                    data = 4'h6;
                    lock = 1'b1;
                end
				inp = 1'b1;
            end
            8'b1011_1011: begin
                if(lock == 1'b0) begin
                    data = 4'h9;
                    lock = 1'b1;
                end
				inp = 1'b1;
            end
            8'b0111_1011: begin
                if(lock == 1'b0) begin
                    data = 4'he;
                    lock = 1'b1;
                end
				inp = 1'b1;
            end
            8'b1110_0111: begin
                if(lock == 1'b0) begin
                    data = 4'ha;
                    lock = 1'b1;
                end
				inp = 1'b1;
            end
            8'b1101_0111: begin
                if(lock == 1'b0) begin
                    data = 4'hb;
                    lock = 1'b1;
                end
				inp = 1'b1;
            end
            8'b1011_0111: begin
                if(lock == 1'b0) begin
                    data = 4'hc;
                    lock = 1'b1;
                end
				inp = 1'b1;
            end
            8'b0111_0111: begin
                if(lock == 1'b0) begin
                    data = 4'hd;
                    lock = 1'b1;
                end
				inp = 1'b1;
            end
            default: begin
                data = data;
                lock = 1'b0;
            end
        endcase
    end
end

endmodule
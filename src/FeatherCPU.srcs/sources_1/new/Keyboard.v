module Keyboard(
    input i_clk,
    input i_rst,
    input  [3:0]    i_row,
    output [3:0]    o_col,
    output reg [3:0] o_data,
    output reg o_enable
);

reg [20:0] clkcnt = 0;

always @(posedge i_clk)
begin
    if(i_rst) begin
        clkcnt = 0;
    end else begin
        clkcnt = clkcnt +1'b1;
    end
end

wire [1:0] keyclk = clkcnt[20:19];
assign o_col = 4'b1111 ^ (1<<keyclk);
reg lock = 0;

reg las_inp;
reg inp;

always @(posedge clkcnt[18])
begin
    if(i_rst) begin
        o_data = 0;
		inp = 0;
		las_inp = 0;
    end else begin
        if(o_col == 4'b1110) begin
			if(inp != las_inp) begin
				if(inp == 1'b0) begin
					o_enable = 1;
				end else begin
					o_enable = 0;
				end
				las_inp = inp;
            end else begin
                o_enable = o_enable;
            end
			inp = 0;
		end
        case({i_row,o_col})
            8'b1110_1110: begin
                if(lock == 1'b0) begin
                    o_data = 4'h1;
                    lock = 1'b1;
                end
				inp = 1'b1;
            end
            8'b1101_1110: begin
                if(lock == 1'b0) begin
                    o_data = 4'h4;
                    lock = 1'b1;
                end
				inp = 1'b1;
            end
            8'b1011_1110: begin
                if(lock == 1'b0) begin
                    o_data = 4'h7;
                    lock = 1'b1;
                end
				inp = 1'b1;
            end
            8'b0111_1110: begin
                if(lock == 1'b0) begin
                    o_data = 4'hf;
                    lock = 1'b1;
                end
				inp = 1'b1;
            end
            8'b1110_1101: begin
                if(lock == 1'b0) begin
                    o_data = 4'h2;
                    lock = 1'b1;
                end
				inp = 1'b1;
            end
            8'b1101_1101: begin
                if(lock == 1'b0) begin
                    o_data = 4'h5;
                    lock = 1'b1;
                end
				inp = 1'b1;
            end
            8'b1011_1101: begin
                if(lock == 1'b0) begin
                    o_data = 4'h8;
                    lock = 1'b1;
                end
				inp = 1'b1;
            end
            8'b0111_1101: begin
                if(lock == 1'b0) begin
                    o_data = 4'h0;
                    lock = 1'b1;
                end
				inp = 1'b1;
            end
            8'b1110_1011: begin
                if(lock == 1'b0) begin
                    o_data = 4'h3;
                    lock = 1'b1;
                end
				inp = 1'b1;
            end
            8'b1101_1011: begin
                if(lock == 1'b0) begin
                    o_data = 4'h6;
                    lock = 1'b1;
                end
				inp = 1'b1;
            end
            8'b1011_1011: begin
                if(lock == 1'b0) begin
                    o_data = 4'h9;
                    lock = 1'b1;
                end
				inp = 1'b1;
            end
            8'b0111_1011: begin
                if(lock == 1'b0) begin
                    o_data = 4'he;
                    lock = 1'b1;
                end
				inp = 1'b1;
            end
            8'b1110_0111: begin
                if(lock == 1'b0) begin
                    o_data = 4'ha;
                    lock = 1'b1;
                end
				inp = 1'b1;
            end
            8'b1101_0111: begin
                if(lock == 1'b0) begin
                    o_data = 4'hb;
                    lock = 1'b1;
                end
				inp = 1'b1;
            end
            8'b1011_0111: begin
                if(lock == 1'b0) begin
                    o_data = 4'hc;
                    lock = 1'b1;
                end
				inp = 1'b1;
            end
            8'b0111_0111: begin
                if(lock == 1'b0) begin
                    o_data = 4'hd;
                    lock = 1'b1;
                end
				inp = 1'b1;
            end
            default: begin
                o_data = o_data;
                lock = 1'b0;
            end
        endcase
    end
end

endmodule
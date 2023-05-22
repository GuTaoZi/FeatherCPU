`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/22 15:22:21
// Design Name: 
// Module Name: top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module top(
input clk,
input rst,
input upg_rx,
output upg_tx
    );
wire uart_ena;
wire [14:0] uart_addr;
wire [31:0] uart_data;
wire uart_done;

uart0 muart(
    .upg_clk_i(clk),
    .upg_rst_i(rst),
    .upg_rx_i(upg_rx),
    .upg_clk_o(uart_clk),
    .upg_wen_o(uart_ena),
    .upg_adr_o(uart_addr),
    .upg_dat_o(uart_data),
    .upg_done_o(uart_done),
    .upg_tx_o(upg_tx)
);

reg [2:0] cnt;
always @(posedge clk) begin
    cnt = cnt + 1;
end

assign cpu_clk = cbt[2];


reg [2:0] state;

always @(posedge cpu_clk) begin
    state = state + 1;

end

endmodule

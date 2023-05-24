`timescale 1ns / 1ps

`include "ParamDef.vh"

module DMA(
    input                   hdw_clk,
    input                   cpu_clk,
    input                   cpu_mem_ena, // If CPU need DMemory
    input   [`REG_WIDTH]    cpu_addr,
    input   [`REG_WIDTH]    cpu_write_data,
    input                   cpu_mem_read_ena,
    input                   cpu_mem_write_ena,

    input   [23:0]          hdw_sw_data,
    input   [23:0]          hdw_keybd_data,
    input                   hdw_ack_but,

    input                   uart_ena,
    input                   uart_done,
    input                   uart_clk,
    input   [13:0]          uart_addr,
    input   [`REG_WIDTH]    uart_data,

    output  [`REG_WIDTH]    read_data,
    output reg [23:0]       hdw_led_data
);

assign kick_off = ~uart_ena | uart_done;

reg [1:0]           tran_pos;
reg [`REG_WIDTH]    mem_addr;
reg [`REG_WIDTH]    write_data;
reg                 mem_read;
reg                 mem_write;

DataMem myDM(
    .i_addr(kick_off ? mem_addr[15:2] : uart_addr),
    .i_write_data(kick_off ? write_data : uart_data),
    .i_mem_read(kick_off ? mem_read : 0),
    .i_mem_write(kick_off ? mem_write : ~uart_done),
    .i_clk(kick_off ? hdw_clk : uart_clk),
    .o_read_data(read_data)
);

reg reading_data = 0;

reg las_ack = 0;

always @(negedge cpu_clk) begin
    if(reading_data) begin
        hdw_led_data = read_data[23:0];
        reading_data = 0;
    end
    if(cpu_mem_ena) begin
        mem_addr = cpu_addr;
        mem_read = cpu_mem_read_ena;
        mem_write = cpu_mem_write_ena;
        write_data = cpu_write_data;
    end else begin
        if(las_ack != hdw_ack_but) begin
            if(hdw_ack_but == 1'b0) begin
                mem_addr = `MMIO_ack_map_addr;
                write_data = 32'h0000_0001;
                mem_read = 1'b0;
                mem_write = 1'b1;
            end
            las_ack = hdw_ack_but;
        end else begin
            if(tran_pos == 2'b00) begin
                mem_addr = `MMIO_sw_map_addr;
                write_data = {8'b0, hdw_sw_data};
                mem_read = 0;
                mem_write = 1;
            end else if(tran_pos == 2'b01) begin
                mem_addr = `MMIO_keybd_map_addr;
                write_data = {8'b0, hdw_keybd_data};
                mem_read = 0;
                mem_write = 1;
            end else begin
                mem_addr = `MMIO_led_map_addr;
                reading_data = 1;
                mem_read = 1;
                mem_write = 0;
            end
            tran_pos = tran_pos + 1'b1;
        end
    end
end

endmodule

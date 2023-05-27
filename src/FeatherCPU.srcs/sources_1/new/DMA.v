`timescale 1ns / 1ps

`include "ParamDef.vh"

module DMA(
    input                   hdw_clk,
    input                   cpu_clk,
    input                   cpu_mem_ena,
    input   [`REG_WIDTH]    cpu_addr,
    input   [`REG_WIDTH]    cpu_write_data,
    input                   cpu_mem_read_ena,
    input                   cpu_mem_write_ena,

    input   [`SWITCH_WIDTH] hdw_sw_data,
    input   [`REG_WIDTH]    hdw_keybd_data,
    input                   hdw_ack_btn,

    input                   uart_ena,
    input                   uart_done,
    input                   uart_clk,
    input   [13:0]          uart_addr,
    input   [`REG_WIDTH]    uart_data,

    output  [`REG_WIDTH]    read_data,
    output reg [`LED_WIDTH] hdw_led_data
);

/****************************************************************
 port               I/O     Src/Dst     Description
 hdw_clk             I        Top       FPGA clock signal
 cpu_clk             I        Top       CPU clock signal
 cpu_mem_ena         I        Top       CPU-access memory signal
 cpu_addr            I        Top       CPU-access memory address
 cpu_write_data      I        Top       Data to write in, from CPU
 cpu_mem_read_ena    I        Top       CPU-read memory signal
 cpu_mem_write_ena   I        Top       CPU-write memory signal
 hdw_sw_data         I        Top       MMIO data from switches
 hdw_keybd_data      I        Top       MMIO data from keyboard
 hdw_ack_btn         I        Top       MMIO data from ACK button
 uart_ena            I        Uart      Uart-write memory signal
 uart_done           I        Uart      Uart-complete signal
 uart_clk            I        Uart      Uart clock signal
 uart_addr           I        Uart      Uart-write memory address
 uart_data           I        Uart      Data to write in, from uart
 read_data           O        Top       Data read from data memory
 hdw_led_data        O        Top       MMIO data for leds
****************************************************************/

assign kick_off = ~uart_ena | uart_done;

reg [1:0]           tran_pos;
reg [`REG_WIDTH]    mem_addr;
reg [`REG_WIDTH]    write_data;
reg                 mem_read;
reg                 mem_write;

DataMem myDM(
    .i_addr(kick_off ? mem_addr[15:2] : uart_addr),
    .i_write_data(kick_off ? write_data : uart_data),
    .i_mem_read(kick_off ? mem_read : 1'b0),
    .i_mem_write(kick_off ? mem_write : ~uart_done),
    .i_clk(kick_off ? hdw_clk : uart_clk),
    .o_read_data(read_data)
);

reg reading_data = 0;

reg las_ack = 0;

always @(negedge cpu_clk) begin
    if(reading_data) begin
        hdw_led_data = read_data[`LED_WIDTH];
        reading_data = 0;
    end
    if(cpu_mem_ena) begin
        mem_addr = cpu_addr;
        mem_read = cpu_mem_read_ena;
        mem_write = cpu_mem_write_ena;
        write_data = cpu_write_data;
        o_dma_write = 1;
    end else begin
        o_dma_write = 0;
        if(las_ack != hdw_ack_btn) begin
            if(hdw_ack_btn == 1'b0) begin
                mem_addr = `MMIO_ack_map_addr;
                write_data = 32'h0000_0001;
                mem_read = 1'b0;
                mem_write = 1'b1;
            end
            las_ack = hdw_ack_btn;
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

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/10/08 10:47:30
// Design Name: 
// Module Name: cmd_decode_tb
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


module cmd_decode_tb( );
    reg sclk;
    reg reset;
    reg rs232_rx;
    wire uart_flag;
    wire [7:0] uart_data; 
    wire wr_trig;
    wire rd_trig;
    wire wfifo_wr_en;
    wire [7:0]wfifo_data;
    uart_rx uart_rx_inst(
    .sclk               (sclk),
    .reset              (reset),
    .rs232_rx           (rs232_rx),
    .rx_data            (uart_data),
    .po_flag            (uart_flag)
    );
    cmd_decode cmd_decode_inst(
        .sclk                  (sclk),
        .reset                 (reset),
        .uart_flag             (uart_flag),
        .uart_data             (uart_data),
        
        .wr_trig               (wr_trig),
        .rd_trig               (rd_trig),
        .wfifo_wr_en           (wfifo_wr_en),
        .wfifo_data            (wfifo_data)
        );
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/26 17:44:17
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
        sclk,
        reset,
        RS232_tx,
        rs232_rx
    );
    input sclk;
    input reset;
    wire tx_trig;
    output RS232_tx;
    
    input rs232_rx;
    wire [7:0]rx_data;
    wire po_flag;
    
    uart_tx ut(
    .sclk(sclk),
    .reset(reset),
    
    .tx_data(rx_data),
    .tx_trig(po_flag),
    
    .RS232_tx(RS232_tx)
    );
    
    uart_rx ur(
    .sclk(sclk),
    .reset(reset),
    
    .rs232_rx(rs232_rx),
    
    .rx_data(rx_data),
    .po_flag(po_flag)
    );
endmodule

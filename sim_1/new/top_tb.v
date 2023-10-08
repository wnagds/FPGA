`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/26 18:11:28
// Design Name: 
// Module Name: top_tb
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


module top_tb(

    );
    reg sclk;
    reg reset;
    reg rs232_rx;
    wire rs232_tx;
    top top(
        .sclk(sclk),
        .reset(reset),
        .RS232_tx(rs232_tx),
        .rs232_rx(rs232_rx)
    );
    
    initial sclk=1;
    always #10 sclk=~sclk;
    initial begin
        reset=0;
        rs232_rx=1;
        #101;
        reset=1;
        tx_byte();
    end
    task tx_byte();
        repeat(4)begin
            tx_bit(8'ha7);
            #3000000;
            tx_bit(8'hc9);
            #3000000;
        end
    endtask
    
    task tx_bit;
    input [7:0]data;
    begin
       rs232_rx=1;
       #20;
       rs232_rx=0;
       #8680;
       
       rs232_rx=data[0];
       #8680;
       rs232_rx=data[1];
       #8680;
       rs232_rx=data[2];
       #8680;   
       rs232_rx=data[3];
      #8680;
      rs232_rx=data[4];
      #8680;
      rs232_rx=data[5];
      #8680;      
      rs232_rx=data[6];
      #8680;
      rs232_rx=data[7];
      #8680;      
      
      rs232_rx=1;
      #8680;
    end
endtask
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/26 15:34:58
// Design Name: 
// Module Name: uart_tx
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


module uart_tx(
    sclk,
    reset,
    tx_data,
    tx_trig,
    
    RS232_tx
    );
    input sclk;
    input reset;
    input [7:0]tx_data;
    input tx_trig;
    output reg RS232_tx;
    localparam BAUD_END         =1_000_000_000/115200/20-1;
    reg bit_clk;
    reg [1:0]q;
    reg tx_flag;
    reg [3:0]bit_cnt;
    reg [12:0]baud_cnt;
    wire posedge_trig;
    reg [9:0]data_r;
    assign posedge_trig =(q==2'b01);
    always@(posedge sclk)
    begin
        q[0]<=tx_trig;
        q[1]<=q[0];
    end
    //tx_flag 
    always@(posedge sclk or negedge reset)
    begin
        if(!reset)
            tx_flag<=0;
        else if(posedge_trig)
            tx_flag<=1;
        else if(bit_cnt==9&&baud_cnt==BAUD_END)
            tx_flag=0;
    end
     always@(posedge sclk or negedge reset)
     begin
        if(!reset)
            baud_cnt<=0;
        else if(baud_cnt>=BAUD_END)
            baud_cnt<=0;
        else if(tx_flag)
            baud_cnt<=baud_cnt+1;
     end
     always@(posedge sclk)
     begin
        if(baud_cnt>=BAUD_END)
            bit_clk<=1;
        else bit_clk<=0;
     end
     always@(posedge sclk or negedge reset)
     begin  
        if(!reset)
            bit_cnt<=0;
        else if(!tx_flag)
            bit_cnt<=0;
        else if(baud_cnt>=BAUD_END)
            bit_cnt<=bit_cnt+1;
     end
     always@(posedge sclk or negedge reset)
     begin 
        if(!reset)
            data_r<=10'b1;
        else if(posedge_trig)
            data_r<={1'b1,tx_data[7:0],1'b0};
        else if(!tx_flag)
            data_r<=10'b1;
     end
     always@(posedge sclk or negedge reset)
     begin
        if(!reset||!tx_flag)
            RS232_tx<=1;
        else RS232_tx<=data_r[bit_cnt];
     end
endmodule

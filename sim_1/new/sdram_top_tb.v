`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/26 22:57:38
// Design Name: 
// Module Name: sdram_top_tb
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


module sdram_top_tb(
    
    );
    reg sclk;
    reg reset;
    wire sdram_clk;
    wire sdram_cke;
    wire sdram_cs;
    wire sdram_cas;
    wire sdram_ras;
    wire sdram_we;
//`   wire [1:0]sdram_bank;
    wire [1:0]sdram_bank;
    wire [11:0]sdram_addr;
    wire [1:0]sdram_dqm;  
    wire [15:0]sdram_dq;  
    reg wr_trig;
    reg rd_trig;
    initial sclk=1;
    always #10 sclk=!sclk;
    initial begin
        reset=0;
        #201;
        reset=1;
    end
    initial begin
        wr_trig <=  0;
        rd_trig <=  0;
        #300_500;
        wr_trig <= 1;
        #20;
        wr_trig <=0;
        #40_000;
        #3000_000;
        rd_trig <= 1;
        #20;
        rd_trig <= 0;
        #300_000;
        $stop;
    end
    sdram_top st(
        //input Interface
    .sclk(sclk),
    .reset(reset),
    //output SDRAM_Interface
    .sdram_clk(sdram_clk),
    .sdram_cke(sdram_cke),
    
    .sdram_cs(sdram_cs),
    .sdram_cas(sdram_cas),
    .sdram_ras(sdram_ras),
    .sdram_we(sdram_we),
    
    .sdram_bank(sdram_bank),
    .sdram_addr(sdram_addr),
    .sdram_dqm(sdram_dqm),
    .sdram_dq(sdram_dq),
    
    .wr_trig(wr_trig),
    .rd_trig(rd_trig)
    
    );
    sdram_model_plus smp(
        .Dq(sdram_dq),
        .Addr(sdram_addr),
        .Ba(sdram_bank),  
        .Clk(sdram_clk), 
        .Cke(sdram_cke), 
        .Cs_n(sdram_cs),
        .Ras_n(sdram_ras),
        .Cas_n(sdram_cas),
        .We_n(sdram_we),
        .Dqm(sdram_dqm),
        .Debug(1'b1)
        );
        defparam    smp.addr_bits=12;
        defparam    smp.data_bits=16;
        defparam    smp.col_bits=9;
        defparam    smp.mem_sizes=2*1024*1024;
endmodule

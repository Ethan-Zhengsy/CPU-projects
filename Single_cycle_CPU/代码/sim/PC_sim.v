`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/11/26 17:29:40
// Design Name: 
// Module Name: PC_sim
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


module PC_sim();

    //input
    reg CLK, Reset, PCWrite;
    reg PCSrc;
    reg [15:0] Immediate;
    
    //outputs
    wire [31:0] InsAddr;
    
    PC uut(
        .CLK(CLK),
        .Reset(Reset),
        .PCWrite(PCWrite),
        .PCSrc(PCSrc),
        .Immediate(Immediate),
        .InsAddr(InsAddr)
    );
    
    always #15 CLK = ~CLK;
    
    initial begin
        //record
        $dumpfile("PC.vcd");
        $dumpvars(0, PC_sim);
        
        //≥ı ºªØ
        CLK = 0;
        Reset = 0;
        PCWrite = 0;
        PCSrc = 0;
        Immediate = 0;
        
        #100;
        Reset = 1;
        PCWrite = 1;
        PCSrc = 0;
        Immediate = 4;
        
        #100;
        Reset = 1;
        PCWrite = 1;
        PCSrc = 0;
        Immediate = 4;
        
        #100;
        Reset = 1;
        PCWrite = 1;
        PCSrc = 1;
        Immediate = 4;
        
        #100;
        Reset = 1;
        PCWrite = 1;
        PCSrc = 1;
        Immediate = 4;
        
        #100;
        Reset = 1;
        PCWrite = 1;
        PCSrc = 1;
        Immediate = 4;
        
        #100;
        $stop;
    end
    
endmodule

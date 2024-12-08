`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/11/30 21:43:15
// Design Name: 
// Module Name: Single_cycle_CPU_sim
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


module Single_cycle_CPU_sim();

    //inputs
    reg CLK;
    reg Reset;
    
    //outputs
    wire [31:0] curPC;
    wire [5:0] op;
    wire [31:0] readData1;
    wire [31:0] readData2;
    wire [31:0] ImExtend;
    wire [4:0] shamt;
    wire [31:0] ALUData;
    

    
    Single_cycle_CPU uut(
        .CLK(CLK),
        .Reset(Reset),
        .op(op),
        .readData1(readData1),
        .readData2(readData2),
        .curPC(curPC),
        .shamt(shamt),
        .ImExtend(ImExtend),
        .ALUData(ALUData)
    );
    
    initial begin
        $dumpfile("Single_cycle_CPU.vcd");
        $dumpvars(0, Single_cycle_CPU_sim);
        
        //≥ı ºªØ ‰»Î
        CLK = 0;
        Reset = 0;
        
        #50;
        CLK = 1;
        
        #50;
        Reset = 1;
        
        forever #50 begin
            CLK = ~CLK;
        end
    end
    
endmodule

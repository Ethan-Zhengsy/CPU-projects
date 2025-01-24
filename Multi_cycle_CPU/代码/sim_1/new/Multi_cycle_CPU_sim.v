`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/12/28 00:36:19
// Design Name: 
// Module Name: Multi_cycle_CPU_sim
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


module Multi_cycle_CPU_sim();

    //inputs
    reg CLK;
    reg Reset;
//    reg IF_ID_Start;
//    reg IF_ID_Write;
//    reg RegWrite;
    
    
    //outputs
    wire [31:0] curPC;
    wire [31:0] nextPC;
    wire [5:0] op;
    wire [31:0] readData1;
    wire [31:0] readData2;
    wire [31:0] ImExtend;
    wire [4:0] shamt;
    wire [31:0] ALUData;
    

    
    Multi_cycle_CPU uut(
        .CLK(CLK),
        .Reset(Reset),
//        .IF_ID_Start(IF_ID_Start),
//        .IF_ID_Write(IF_ID_Write),
//        .WB_RegWrite(RegWrite),
        .ID_op(op),
        .EXE_updateDataA(readData1),
        .EXE_updateDataB(readData2),
        .IF_InsAddr(curPC),
        .IF_nextPC(nextPC),
        .ID_shamt(shamt),
        .ID_ImExtend(ImExtend),
        .EXE_ALUData(ALUData)
    );
    
    initial begin
        $dumpfile("Multi_cycle_CPU.vcd");
        $dumpvars(0, Multi_cycle_CPU_sim);
        
        //≥ı ºªØ ‰»Î
        CLK = 0;
        Reset = 0;
//        IF_ID_Start = 1;
//        IF_ID_Write = 1;
//        RegWrite = 0;
//        op = 6'b000000;
        
        #50;
        CLK = 1;
        
        #50;
        Reset = 1;
        
        forever #50 begin
            CLK = ~CLK;
//            IF_ID_Start = 0;
        end
    end
    
endmodule


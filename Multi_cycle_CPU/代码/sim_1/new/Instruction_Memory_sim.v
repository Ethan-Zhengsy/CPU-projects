`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/12/17 23:49:31
// Design Name: 
// Module Name: Instruction_Memory_sim
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


module Instruction_Memory_sim();

//inputs
reg [31:0] InsAddr;
reg InsMemRW;

//output
wire [31:0] readIns;
//wire [5:0] op;
//wire [4:0] rs, rt, rd;
//wire [4:0] shamt;
//wire [15:0] Immediate;
//wire [5:0] func;

Instruction_Memory uut(
    .InsAddr(InsAddr),
    .InsMemRW(InsMemRW),
    .readIns(readIns)
//    .op(op),
//    .rs(rs),
//    .rt(rt),
//    .rd(rd),
//    .Immediate(Immediate),
//    .shamt(shamt),
//    .func(func)
);

initial begin
    //record
    $dumpfile("Instruction_Memory_sim.vcd");
    $dumpvars(0, Instruction_Memory_sim);
    
    //initial
    #10;
    InsMemRW = 0;
    InsAddr [31:0] = 32'd0;
    
    //read insturction
    #50;
    InsMemRW = 1;
    InsAddr [31:0] = 32'd0;
    
    //read insturction
    #50;
    InsMemRW = 1;
    InsAddr [31:0] = 32'd4;
    
    //read insturction
    #50;
    InsMemRW = 1;
    InsAddr [31:0] = 32'd8;
    
    #10;
    $stop;
end

endmodule

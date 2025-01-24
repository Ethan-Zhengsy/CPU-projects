`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/12/25 23:10:30
// Design Name: 
// Module Name: Control_Unit
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


module Control_Unit(
    input [5:0] op,//op码输入
    input [5:0] func,//function码输入
    
    output ExtSrc, MemWrite, MemRead, InsMemRW, PCWrite_C, RegWrite,//输出信号控制
    output [1:0] PCSrc, MemtoReg, RegDst, zeroOp,//多路选择器选择信号
    output [3:0] ALUOp//ALU局部控制
    );
    
    //从op码产生控制信号
    assign ExtSrc = (op == 6'b001100 || op == 6'b001101 || op == 6'b001110) ? 0 : 1;
    assign MemWrite = (op == 6'b101011) ? 1 : 0;
    assign MemRead = (op == 6'b100011) ? 1 : 0;
    assign InsMemRW = 1;
    assign PCWrite_C = (op == 6'b111111) ? 0 : 1;
    assign RegWrite = (op == 6'b101011 || op == 6'b000100 || op == 6'b000101 || op == 6'b000110 || op == 6'b000010 || op == 6'b111111 || (op == 6'b000000 && func == 6'b001000)) ? 0 : 1;
    assign MemtoReg[1] = (op == 6'b000011) ? 1 : 0;
    assign MemtoReg[0] = (op == 6'b100011) ? 1 : 0;
    assign RegDst[1] = (op == 6'b000011) ? 1 : 0;
    assign RegDst[0] = (op == 6'b000000) ? 1 : 0;
    assign PCSrc[1] = (op == 6'b000010 || op == 6'b000011 || (op == 6'b000000 && func == 6'b001000)) ? 1 : 0;
    assign PCSrc[0] = (op == 6'b000100 || op == 6'b000101 || op == 6'b000110 || (op == 6'b000000 && func == 6'b001000)) ? 1 : 0; 
    assign zeroOp[1] = (op == 6'b000110) ? 1 : 0;
    assign zeroOp[0] = (op == 6'b000101) ? 1 : 0;
    assign ALUOp[3] = (op == 6'b000000) ? 1 : 0;
    assign ALUOp[2] = (op == 6'b001010 || op == 6'b000110 || op == 6'b001110) ? 1 : 0;
    assign ALUOp[1] = (op == 6'b001100 || op == 6'b001101 || op == 6'b000110 || op == 6'b001110) ? 1 : 0;
    assign ALUOp[0] = (op == 6'b001101 || op == 6'b001010 || op == 6'b000100 || op == 6'b000101 || op == 6'b001110) ? 1 : 0;

endmodule

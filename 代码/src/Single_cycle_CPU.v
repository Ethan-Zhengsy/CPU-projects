`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/11/30 18:54:22
// Design Name: 
// Module Name: Single_cycle_CPU
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


module Single_cycle_CPU(
    input CLK, Reset,//输入时钟信号和清零信号
    
    //输出需要显示的数据
    output [4:0] rs, rt,
    output [5:0] op,
    output [5:0] func,
    output [31:0] readData1, readData2, curPC, nextPC, ALUData, DBData,
    output [4:0] shamt,
    output [31:0] ImExtend
    );
    
    //其它连接线声明
    wire [3:0] ALUOp;
    wire [2:0] ALUCtr;
    wire [31:0] DMData;
    wire [15:0] Immediate;
    wire [4:0] rd;
    wire [31:0] JumpPC;
    wire zero, PCWrite, ALUSrcA, ALUSrcB, MemtoReg, RegWrite;
    wire InsMemRW, MemWrite, MemRead, ExtSrc, RegDst;
    wire [1:0] PCSrc;
    wire [3:0] PC4;
    
    //元件实例化
    ALU alu(ALUSrcA, ALUSrcB, ALUCtr, readData1, readData2, ImExtend, shamt, zero, ALUData);
    ALU_Control alu_c(ALUOp, func, ALUSrcA, ALUSrcB, ALUCtr);
    Control_Unit cu(op, zero, ExtSrc, MemWrite, MemRead, InsMemRW, PCWrite, MemtoReg, RegWrite, RegDst, PCSrc, ALUOp);
    Data_Memory dm(CLK, MemWrite, MemRead, readData2, ALUData, DMData);
    Instruction_Memory im(InsMemRW, PC4, curPC, op, rs, rt, rd, shamt, func, Immediate, JumpPC);
    PC pc(CLK, Reset, PCWrite, PCSrc, Immediate, JumpPC, curPC, nextPC, PC4);
    RegFile reg_f(rs, rt, rd, CLK, RegWrite, RegDst, MemtoReg, ALUData, DMData, readData1, readData2, DBData);
    Sign_Zero_Extend ext(ExtSrc, Immediate, ImExtend);
    
endmodule

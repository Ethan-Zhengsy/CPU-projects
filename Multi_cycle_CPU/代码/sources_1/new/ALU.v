`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/12/25 10:08:53
// Design Name: 
// Module Name: ALU
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


module ALU(
    input ALUSrcA, ALUSrcB,//控制信号，输入选择
    input [1:0] forward_EXE_A, forward_EXE_B,//转发信号选择
    input [2:0] ALUCtr,//ALU运算控制
    input [31:0] readDataA, readDataB,//从流水寄存器中读出的数据
    input [31:0] MEMforwardData, WBforwardData,//转发信号
    input [4:0] shamt,//移位字段
    input [31:0] ImExtend,//立即数扩展
    
    output reg [31:0] ALUData,//运算结果
    output [31:0] updateDataA, updateDataB//更新后的数据，用于输出到数码管上
//    output [31:0] outupdateDataB//数据存储器写数据
    );
    
    //转发更新后的数据
    assign updateDataA = (forward_EXE_A[0]) ? MEMforwardData : ((forward_EXE_A[1]) ? WBforwardData : readDataA);
    assign updateDataB = (forward_EXE_B[0]) ? MEMforwardData : ((forward_EXE_B[1]) ? WBforwardData : readDataB);
    wire [31:0] inDataA, inDataB;
    assign inDataA = ALUSrcA ? {{27{1'b0}}, shamt} : updateDataA;
    assign inDataB = ALUSrcB ? ImExtend : updateDataB;
    
//    assign outupdateDataB = updateDataB;
    wire smaller;
    assign smaller = (inDataA < inDataB) ? 1 : 0;
    
    always @ (*) begin 
        case (ALUCtr)
            3'b000: ALUData = inDataA + inDataB;
            3'b001: ALUData = inDataA - inDataB;
            3'b010: ALUData = inDataA & inDataB;
            3'b011: ALUData = inDataA | inDataB;
            3'b100: ALUData = inDataB << inDataA;
            3'b101: ALUData = (inDataA[31] == 0 && inDataB[31] == 0) ? {{31{1'b0}}, smaller} : {{31{1'b0}}, ~smaller};
            3'b110: ALUData = inDataA > inDataB;
            3'b111: ALUData = inDataA ^ inDataB;
            default: ALUData = 32'h0000;
        endcase
    end
    
endmodule

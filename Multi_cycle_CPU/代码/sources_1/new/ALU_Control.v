`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/12/27 13:09:00
// Design Name: 
// Module Name: ALU_Control
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


module ALU_Control(
    input [3:0] ALUOp,//控制信号，ALU局部控制
    input [5:0] func,//R型指令的function码
    
    output reg ALUSrcA, ALUSrcB,//输出ALU输入选择信号
    output reg [2:0] ALUCtr//ALU运算控制
    );
    
    //ALU局部控制
    always @ (*) begin
        if (ALUOp[3] == 1) begin
            ALUSrcA = (func == 6'b000000) ? 1 : 0;
            ALUSrcB = 0;
            ALUCtr[2] = (func == 6'b000000 || func == 6'b101010) ? 1 : 0;
            ALUCtr[1] = (func == 6'b100100 || func == 6'b100101) ? 1 : 0;
            ALUCtr[0] = (func == 6'b100010 || func == 6'b100101 || func == 6'b101010) ? 1 : 0;
        end
        else begin
            ALUSrcA = 0;
            ALUSrcB = (ALUOp == 4'b0001 || ALUOp == 4'b0110) ? 0 : 1;
            ALUCtr[2] = (ALUOp == 4'b0101 || ALUOp == 4'b0110 || ALUOp == 4'b0111) ? 1 : 0;
            ALUCtr[1] = (ALUOp == 4'b0010 || ALUOp == 4'b0011 || ALUOp == 4'b0110 || ALUOp == 4'b0111) ? 1 : 0;
            ALUCtr[0] = (ALUOp == 4'b0011 || ALUOp == 4'b0101 || ALUOp == 4'b0001 || ALUOp == 4'b0111) ? 1 : 0;
        end
    end
    
endmodule

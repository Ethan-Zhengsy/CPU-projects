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
    input ALUSrcA, ALUSrcB,//�����źţ�����ѡ��
    input [1:0] forward_EXE_A, forward_EXE_B,//ת���ź�ѡ��
    input [2:0] ALUCtr,//ALU�������
    input [31:0] readDataA, readDataB,//����ˮ�Ĵ����ж���������
    input [31:0] MEMforwardData, WBforwardData,//ת���ź�
    input [4:0] shamt,//��λ�ֶ�
    input [31:0] ImExtend,//��������չ
    
    output reg [31:0] ALUData,//������
    output [31:0] updateDataA, updateDataB//���º�����ݣ�����������������
//    output [31:0] outupdateDataB//���ݴ洢��д����
    );
    
    //ת�����º������
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

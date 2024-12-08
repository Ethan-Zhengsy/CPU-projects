`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/11/30 15:40:31
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
    input [2:0] ALUCtr,//�����źţ�����ѡ��
    input [31:0] readData1, readData2,//���������
    input [31:0] ImExtend,//��������չ
    input [4:0] shamt,//��λ�ֶ�
    
    output zero,//����ж�
    output reg [31:0] ALUData//������
    );
    
    //��������ALU��������
    wire [31:0] DataA;
    wire [31:0] DataB;
    
    //����ѡ��
    assign DataA = ALUSrcA ? {{27{1'b0}}, shamt} : readData1;
    assign DataB = ALUSrcB ? ImExtend : readData2;
    
    //����ж�
    assign zero = (ALUData == 0) ? 1 : 0;
    
    //ALU����
    always @ (*) begin
        case(ALUCtr)
            3'b000: ALUData = DataA + DataB;
            3'b001: ALUData = DataA - DataB;
            3'b010: ALUData = DataA & DataB;
            3'b011: ALUData = DataA | DataB;
            3'b100: ALUData = DataB << DataA;
            3'b101: ALUData = DataA < DataB;
            3'b110: ALUData = DataA > DataB;
            3'b111: ALUData = DataA ^ DataB;
            default: ALUData = 32'h0000;
        endcase
    end
    
endmodule

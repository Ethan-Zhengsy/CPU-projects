`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/12/25 19:07:43
// Design Name: 
// Module Name: MEM_WB_reg
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


module MEM_WB_reg(
    input CLK,//ʱ���ź�
    
    input [31:0] ALUData,//ALU�������
    input [31:0] DMData,//���ݼĴ�����������
    input [31:0] nextPC4,//����PC��ַ
    input [4:0] writeSrc,//�Ĵ�����д��ַ
    
    input [1:0] MemtoReg,//��������ѡ��
    input RegWrite,//�Ĵ���дʹ��
    
    output [31:0] outALUData,//ALU�������
    output [31:0] outDMData,//���ݼĴ�����������
    output [31:0] outnextPC4,//����PC��ַ
    output [4:0] outwriteSrc,//�Ĵ�����д��ַ
    output [1:0] outMemtoReg,//��������ѡ��
    output outRegWrite//�Ĵ���дʹ��
    );
    
    //������ˮ�Ĵ�������
    reg [31:0] MEM_WB_AD;
    reg [31:0] MEM_WB_MD;
    reg [31:0] MEM_WB_PC;
    reg [7:0] MEM_WB_REG;
    
    //��ʼ����ˮ�Ĵ���
    initial begin
        MEM_WB_AD <= 0;
        MEM_WB_MD <= 0;
        MEM_WB_PC <= 0;
        MEM_WB_REG <= 0;
    end
    
    //��������ӿ�
    assign outALUData = MEM_WB_AD[31:0];
    assign outDMData = MEM_WB_MD[31:0];
    assign outnextPC4 = MEM_WB_PC[31:0];
    assign outwriteSrc = MEM_WB_REG[7:3];
    assign outMemtoReg = MEM_WB_REG[2:1];
    assign outRegWrite = MEM_WB_REG[0];
    
    //״̬�仯:ʱ���½��ظ���
    always @ (negedge CLK) begin
        MEM_WB_AD <= ALUData;
        MEM_WB_MD <= DMData;
        MEM_WB_PC <= nextPC4;
        MEM_WB_REG[7:3] <= writeSrc;
        MEM_WB_REG[2:1] <= MemtoReg;
        MEM_WB_REG[0] <= RegWrite;
    end
    
endmodule

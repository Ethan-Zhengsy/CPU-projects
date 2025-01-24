`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/12/25 11:28:56
// Design Name: 
// Module Name: EXE_MEM_reg
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


module EXE_MEM_reg(
    input CLK,//ʱ���ź�
    
    input [31:0] ALUData,//ALU����
    input [31:0] updateDataB,//ת�����rt������
    input [4:0] writeSrc,//�Ĵ�����д��ַ
    
    input [31:0] nextPC4,//����PC��ַ
    input MemWrite, MemRead,//���ݴ洢�������ź�
    input [1:0] MemtoReg,//��������ѡ��
    input RegWrite,//�Ĵ���дʹ��
    
    output [31:0] outALUData,//ALUData���
    output [31:0] writeData,//���ݴ洢��д������
    output [4:0] outwriteSrc,//�Ĵ���д���ַ
    output [31:0] outnextPC4,//����PC��ַ
    output outMemWrite, outMemRead,//���ݴ洢�������ź�
    output [1:0] outMemtoReg,//��������ѡ��
    output outRegWrite//�Ĵ���дʹ��
    );
    
    //������ˮ�Ĵ�������
    reg [31:0] EXE_MEM_AD;
    reg [31:0] EXE_MEM_WD;
    reg [31:0] EXE_MEM_PC;
    reg [4:0] EXE_MEM_writeSrc;
    reg [4:0] EXE_MEM_MEM;
    
    //��ʼ����ˮ�Ĵ���
    initial begin
        EXE_MEM_AD <= 0;
        EXE_MEM_WD <= 0;
        EXE_MEM_PC <= 0;
        EXE_MEM_writeSrc <= 0;
        EXE_MEM_MEM <= 0;
    end
    
    //������ˮ�Ĵ��������
    assign outALUData = EXE_MEM_AD[31:0];
    assign writeData = EXE_MEM_WD[31:0];
    assign outnextPC4 = EXE_MEM_PC[31:0];
    assign outwriteSrc = EXE_MEM_writeSrc[4:0];
    assign outMemWrite = EXE_MEM_MEM[4];
    assign outMemRead = EXE_MEM_MEM[3];
    assign outMemtoReg = EXE_MEM_MEM[2:1];
    assign outRegWrite = EXE_MEM_MEM[0];
    
    //״̬�仯��ʱ���½��ظ���
    always @ (negedge CLK) begin
        EXE_MEM_AD <= ALUData;
        EXE_MEM_WD <= updateDataB;
        EXE_MEM_PC <= nextPC4;
        EXE_MEM_writeSrc <= writeSrc;
        EXE_MEM_MEM[4] <= MemWrite;
        EXE_MEM_MEM[3] <= MemRead;
        EXE_MEM_MEM[2:1] <= MemtoReg;
        EXE_MEM_MEM[0] <= RegWrite;
    end
    
endmodule

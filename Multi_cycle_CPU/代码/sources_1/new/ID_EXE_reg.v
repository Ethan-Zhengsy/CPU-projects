`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/12/24 17:30:50
// Design Name: 
// Module Name: ID_EXE_reg
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


module ID_EXE_reg(
    input CLK, //ʱ���ź�
    input ID_EXE_Flush,//��ˢ
    
    input [1:0] forward_ID_A, forward_ID_B,//ת���ź�ѡ������������֧��
    input [1:0] zeroOp,//��ָ֧�����ͣ������Ƿ���ת
    input [1:0] RegDst,//�Ĵ���д��ַѡ��
    
    input [31:0] readDataA, readDataB,//�Ĵ��������ź�
    input [31:0] MEMforwardData, WBforwardData,//ת���ź�
    input [4:0] rs,//��rtһ������ת�����
    input [4:0] rt, rd,//�Ĵ���д��ַ
    
    input [4:0] shamt,//λ���ֶ�
    input [31:0] ImExtend,//��������չ
    input [31:0] nextPC4,//��һ��PCֵ
    
    input ALUSrcA, ALUSrcB,//ALU�����ź�
    input [2:0] ALUCtr,//ALU�������
    input MemWrite, MemRead, //���ݴ洢������
    input [1:0] MemtoReg,//��������ѡ��
    input RegWrite,//�Ĵ�����дʹ��
    
    output [31:0] outDataA, outDataB,//ALU������
    output [4:0] outwriteSrc,//�Ĵ�����д��ַ
    output [4:0] outrs, outrt,//����ת���ж�
    
    output [31:0] outnextPC4,//��һ��PC
    output [4:0] outshamt,//��λ�ֶ�
    output [31:0] outImExtend,//��������չ
    
    output outALUSrcA, outALUSrcB,//ALU�����ź�
    output [2:0] outALUCtr,//ALU�������
    output outMemWrite, outMemRead, //���ݴ洢������
    output [1:0] outMemtoReg,//��������ѡ��
    output outRegWrite,//�Ĵ�����дʹ��
    
    output zero,//��ת�����ж�
    output [31:0] storeDataA, storeDataB//����jrָ��ȡ���Ĵ����������ʾ
    );
    
    //������ˮ�Ĵ�������
    reg [31:0] ID_EXE_DataA;
    reg [31:0] ID_EXE_DataB;
    reg [4:0] ID_EXE_Rs;
    reg [4:0] ID_EXE_Rt;
    reg [4:0] ID_EXE_WriteSrc;
    reg [31:0] ID_EXE_PC;
    reg [4:0] ID_EXE_Shamt;
    reg [31:0] ID_EXE_ImExtend;
    reg [4:0] ID_EXE_EX;
    reg [4:0] ID_EXE_MEM;
    
    //��ʼ����ˮ�Ĵ���
    initial begin
        ID_EXE_DataA <= 0;
        ID_EXE_DataB <= 0;
        ID_EXE_Rs <= 0;
        ID_EXE_Rt <= 0;
        ID_EXE_WriteSrc <= 0;
        ID_EXE_PC <= 0;
        ID_EXE_Shamt <= 0;
        ID_EXE_ImExtend <= 0;
        ID_EXE_EX <= 0;
        ID_EXE_MEM <= 0;
    end
    
    //����ѡ��
//    wire [31:0] storeDataB;//д����ˮ�Ĵ����Ĳ�������ת����
    assign storeDataA = (forward_ID_A[0]) ? MEMforwardData : ((forward_ID_A[1]) ? WBforwardData : readDataA);
    assign storeDataB = (forward_ID_B[0]) ? MEMforwardData : ((forward_ID_B[1]) ? WBforwardData : readDataB);
    wire [4:0] writeSrc;
    assign writeSrc = (RegDst[0]) ? rd : ((RegDst[1]) ? 5'b11111 : rt);
    
    //��ת�����ж�
//    assign zero = (storeDataA == storeDataB) ? 1 : 0;//���������Ҫ�޸�,����Ƶ�Ԫ�й�
    wire zeroData1, zeroData2, zeroData3;
    assign zeroData1= (storeDataA - storeDataB == 0) ? 1 : 0;
    assign zeroData2 = (storeDataA < storeDataB) ? 1 : 0;//������Ҫ���¿��Ƿ��ţ�
    assign zeroData3 = (storeDataA[31] == 0 && storeDataB[31] == 0) ? zeroData2 : ~zeroData2;
    assign zero = (zeroOp[0]) ? ~zeroData1 : ((zeroOp[1])? zeroData3 : zeroData1);
    
    //�ӼĴ�����������ֶ�
    assign outDataA = ID_EXE_DataA[31:0];
    assign outDataB = ID_EXE_DataB[31:0];
    assign outrs = ID_EXE_Rs[4:0];
    assign outrt = ID_EXE_Rt[4:0];
    assign outwriteSrc = ID_EXE_WriteSrc[4:0];
    assign outnextPC4 = ID_EXE_PC[31:0];
    assign outshamt = ID_EXE_Shamt[4:0];
    assign outImExtend = ID_EXE_ImExtend[31:0];
    assign outALUSrcA = ID_EXE_EX[4];
    assign outALUSrcB = ID_EXE_EX[3];
    assign outALUCtr = ID_EXE_EX[2:0];
    assign outMemWrite = ID_EXE_MEM[4];
    assign outMemRead = ID_EXE_MEM[3];
    assign outMemtoReg = ID_EXE_MEM[2:1];
    assign outRegWrite = ID_EXE_MEM[0];
    
    //״̬�仯��ʱ���½��ظı�
    always @ (negedge CLK) begin
        ID_EXE_PC <= nextPC4;
        if (ID_EXE_Flush == 0) begin
            ID_EXE_DataA <= storeDataA;
            ID_EXE_DataB <= storeDataB;
            ID_EXE_Rs <= rs;
            ID_EXE_Rt <= rt;
            ID_EXE_WriteSrc <= writeSrc;
            ID_EXE_Shamt <= shamt;
            ID_EXE_ImExtend <= ImExtend;
            ID_EXE_EX [4] <= ALUSrcA;
            ID_EXE_EX [3] <= ALUSrcB;
            ID_EXE_EX [2:0] <= ALUCtr;
            ID_EXE_MEM [4] <= MemWrite;
            ID_EXE_MEM [3] <= MemRead;
            ID_EXE_MEM [2:1] <= MemtoReg;
            ID_EXE_MEM [0] <= RegWrite;
        end
        else begin
            ID_EXE_DataA <= 0;
            ID_EXE_DataB <= 0;
            ID_EXE_Rs <= 0;
            ID_EXE_Rt <= 0;
            ID_EXE_WriteSrc <= 0;
            ID_EXE_Shamt <= 0;
            ID_EXE_ImExtend <= 0;
            ID_EXE_EX [4] <= 0;
            ID_EXE_EX [3] <= 0;
            ID_EXE_EX [2:0] <= 0;
            ID_EXE_MEM [4] <= 0;
            ID_EXE_MEM [3] <= 0;
            ID_EXE_MEM [2:1] <= 0;
            ID_EXE_MEM [0] <= 0;
        end
    end
    
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/12/26 13:02:22
// Design Name: 
// Module Name: Forwarding_Unit
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


module Forwarding_Unit(
    input [4:0] MEM_writeSrc, WB_writeSrc,//����ָ��ļĴ���д��ַ
    input [4:0] EXE_rs, EXE_rt, ID_rs, ID_rt,//����ָ��ļĴ���ȡ����ַ
    input MEM_RegWrite, WB_RegWrite,//�Ĵ���дʹ�ܣ������ж��Ƿ���Ҫת��
    input [1:0] PCSrc,//PC����ѡ�������ж�ָ������
    
    output [1:0] forward_ID_A, forward_ID_B, forward_EXE_A, forward_EXE_B//ת�������ź�
    );
    
    assign forward_ID_A[0] = ((MEM_RegWrite == 1) && (MEM_writeSrc != 0) && (PCSrc[0] == 1) && (MEM_writeSrc == ID_rs)) ? 1 : 0;
    assign forward_ID_B[0] = ((MEM_RegWrite == 1) && (MEM_writeSrc != 0) && (PCSrc[0] == 1) && (MEM_writeSrc == ID_rt)) ? 1 : 0;
    assign forward_ID_A[1] = ((WB_RegWrite == 1) && (WB_writeSrc != 0) && (PCSrc[0] == 1) && (WB_writeSrc == ID_rs)) ? 1 : 0;
    assign forward_ID_B[1] = ((WB_RegWrite == 1) && (WB_writeSrc != 0) && (PCSrc[0] == 1) && (WB_writeSrc == ID_rt)) ? 1 : 0;
    assign forward_EXE_A[0] = ((MEM_RegWrite == 1) && (MEM_writeSrc != 0) && (MEM_writeSrc == EXE_rs)) ? 1 : 0;//Ӧ�ÿ��Բ���ҪPCSrc[0] == 0��
    assign forward_EXE_B[0] = ((MEM_RegWrite == 1) && (MEM_writeSrc != 0) && (MEM_writeSrc == EXE_rt)) ? 1 : 0;//���ܼӣ�����ͬʱ������ת��
    assign forward_EXE_A[1] = ((WB_RegWrite == 1) && (WB_writeSrc != 0) && (WB_writeSrc == EXE_rs)) ? 1 : 0;
    assign forward_EXE_B[1] = ((WB_RegWrite == 1) && (WB_writeSrc != 0) && (WB_writeSrc == EXE_rt)) ? 1 : 0;
    
endmodule

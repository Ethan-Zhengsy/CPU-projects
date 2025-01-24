`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/12/25 20:01:42
// Design Name: 
// Module Name: PC
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


module PC(
    input CLK, Reset, PCWrite_C, PCWrite_HD,//���Ʋ���
    input zero,//������֧����
    input [1:0] PCSrc,//PC����ѡ��
    input [31:0] ImExtend,//������,���������Ҫ�޸�(��λ�����ţ�
    input [31:0] JumpPC,//PC��������ת
    input [31:0] storeDataA,//�Ĵ���������ָ���ַ������jrָ��
    input [31:0] outnextPC4,//����IF_ID�Ĵ������PC + 4
    
    output reg signed [31:0] InsAddr,//��Ҫȡ����ָ���ַ
    output [31:0] nextPC4,//InsAddr + 4(δ����IF_ID�Ĵ�����PC + 4��
    output [31:0] nextPC//�ȴ�д���PCֵ,Ҳ��������������
//    output [3:0] PC4//PC����λ
    );

    wire [31:0] branchPC;
    
    //������ݼ���
    assign nextPC4 = InsAddr + 4;
    assign branchPC = (zero) ? outnextPC4 + (ImExtend << 2) : outnextPC4 + 4;
    assign nextPC = (PCSrc == 2'b11) ? storeDataA : ((PCSrc == 2'b10) ? JumpPC : ((PCSrc == 2'b01) ? branchPC : InsAddr + 4));
    
    //ָ���ַ����
    always @ (negedge CLK or negedge Reset) begin
        if (Reset == 0)
            InsAddr = 0;
        else if (PCWrite_C && PCWrite_HD) begin
            if (PCSrc == 2'b11)
                InsAddr = storeDataA;
            else if (PCSrc == 2'b10)
                InsAddr = JumpPC;
            else if (PCSrc == 2'b01)
                InsAddr = branchPC;
            else
                InsAddr = InsAddr + 4;
            end
        end
        
endmodule

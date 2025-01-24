`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/12/25 09:16:10
// Design Name: 
// Module Name: IF_ID_reg
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


module IF_ID_reg(
    input CLK, //ʱ���ź�
//    input IF_ID_Start,//�����������һ��ָ��
    input IF_ID_Write,//дʹ��
    input zero,//��֧Ԥ�����
    input [1:0] PCSrc,//PC����ѡ���Ƿ���ת
    input [31:0] nextPC4,//����PC
    input [31:0] readIns,//ID�׶ζ�����ָ��
    
    //ȡ��ָ�32λ��
    output [31:0] outnextPC4,//��������PC
    output [5:0] op,//[31:26] op
    output [4:0] rs, rt, rd,//[25:21] rs; [20:16] rt; [15:11] rd
    output [4:0] shamt,//[10:6] shamt
    output [5:0] func,//[5:0] func
    output [15:0] Immediate,//[15:0] immediate
    output [31:0] JumpPC//PC��ת��ַ
    );
    
    //��ʼ����ˮ�Ĵ�������
//    reg [31:0] IF_ID_reg [1:0];//��ˮ�Ĵ�������
    reg [31:0] IF_ID_Ins;//��ˮ�Ĵ����洢��ָ��
    reg [31:0] IF_ID_PC;//��ˮ�Ĵ����洢������PC
    
    initial 
        begin
            IF_ID_Ins <= 0;
            IF_ID_PC <= 0;
        end
    
    //�ӼĴ�����������ֶ�
    assign outnextPC4 = IF_ID_PC [31:0];
    assign op = IF_ID_Ins [31:26];//������ܲ���flush,Ӧ��Ϊ��д
    assign rs = IF_ID_Ins [25:21];
    assign rt = IF_ID_Ins [20:16];
    assign rd = IF_ID_Ins [15:11];
    assign shamt = IF_ID_Ins [10:6];
    assign func = IF_ID_Ins [5:0];
    assign Immediate = IF_ID_Ins [15:0];
    assign JumpPC = {{IF_ID_PC[31:28]},{2'b00},{IF_ID_Ins[25:2]},{2'b00}};
    
    //״̬�仯��ʱ���½��ظı�
    always @ (negedge CLK) begin
//        IF_ID_PC <= nextPC4;
        if ((IF_ID_Write == 1) && (((zero == 1) && (PCSrc == 2'b01)) || (PCSrc[1] == 1))) begin
            IF_ID_Ins <= 0;
        end
        else if (IF_ID_Write == 1) begin
            IF_ID_Ins <= readIns;
            IF_ID_PC <= nextPC4;
        end
    end
    
endmodule

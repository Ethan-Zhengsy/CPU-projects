`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/11/04 17:55:49
// Design Name: 
// Module Name: RegFile
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


module RegFile(
    input [4:0] rs, rt, rd, //��������ַ��5λ��
    input CLK, RegWrite, RegDst, MemtoReg,//����ָ��
    input [31:0] ALUData, DMData,//��Ҫд��Ĵ���������(32λ��
    output [31:0] readData1, readData2,//rs, rt��������32λ��
    output [31:0] DBData//�������ݣ������������ʾ��32λ)
    );
    
    //������ѡ������
    wire [4:0] writeSrc;//��Ҫд��ļĴ�����ַѡ��
    assign writeSrc = RegDst ? rd : rt;//RegDst 0:д��rt 1:д��rd
    
    assign DBData = MemtoReg ? DMData : ALUData;//MemtoReg 0:��ALUд�� 1:��DataMemoryд��
    
    //�Ĵ�������
    reg [31:0] register[0:31];//����32 32λ�Ĵ�������
    
    integer i;//���ڱ����Ĵ���
    initial //��ʼ���Ĵ���
        begin
            for(i = 0; i < 32; i = i + 1) begin
                register[i] <= 0;
            end
        end
    
    assign readData1 = register[rs];//���rs��Ӧ������
    assign readData2 = register[rt];//���rt��Ӧ������
    
    always @ (posedge CLK) begin//д�����ݵ��Ĵ���
        if (RegWrite && writeSrc) begin
            register[writeSrc] <= DBData;//����������д���Ӧ�Ĵ���
        end
    end
    
endmodule

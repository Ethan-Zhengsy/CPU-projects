`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/12/25 09:23:06
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
    input CLK, RegWrite,//����ָ��
    input [1:0] MemtoReg,//����ѡ��
    input [4:0] rs, rt, writeSrc,//��������ַ
    input [31:0] ALUData, DMData, nextPC4,//��Ҫд��Ĵ���������
    
    output [31:0] readData1, readData2,//rs, rt������
    output [31:0] DBData//�������� 
    );
    
    //������ѡ������
    assign DBData = (MemtoReg[0]) ? DMData : ((MemtoReg[1]) ? nextPC4 : ALUData);
    
    //�����Ĵ�������
    reg [31:0] register[0:31];
    
    integer i;//���ڱ����Ĵ���
    initial begin 
        for (i = 0; i < 32; i = i + 1) begin
            register[i] <= 0;
        end
    end
    
    assign readData1 = register[rs];//���rs��Ӧ������
    assign readData2 = register[rt];//���rt��Ӧ������
    
    always @ (posedge CLK) begin//д�����ݵ��Ĵ���
        if (RegWrite && CLK && (writeSrc != 5'b00000)) begin
            register[writeSrc] <= DBData;
        end
    end
    
endmodule

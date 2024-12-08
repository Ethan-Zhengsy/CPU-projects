`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/11/26 16:41:23
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
    input CLK, Reset, PCWrite, //���Ʋ���
    input [1:0] PCSrc,//PC����ѡ�� branch+jump
    input signed [15:0] Immediate,//������
    input [31:0] JumpPC,//��ת
    
    output reg signed [31:0] InsAddr,//��Ҫȡ����ָ���ַ
    output [31:0] nextPC,//��һ��ָ���ַ
    output [3:0] PC4 //PC����λ
    );
    
    //����PCֵ
    assign nextPC = (PCSrc[0]) ? InsAddr + 4 + (Immediate << 2) : ((PCSrc[1]) ? JumpPC : InsAddr + 4);
    
    assign PC4 = InsAddr[31:28];
    
    //ָ���ַ����
    always @ (negedge CLK or negedge Reset) begin
        if (Reset == 0)
            InsAddr = 0;
        else if (PCWrite) begin
            if (PCSrc[0])
                InsAddr = InsAddr + 4 + (Immediate << 2);
            else if (PCSrc[1])
                InsAddr = JumpPC;
            else
                InsAddr = InsAddr + 4;
        end
    end
            
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/11/25 16:37:11
// Design Name: 
// Module Name: Data_Memory
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


module Data_Memory(
    input CLK, MemWrite, MemRead,//�����ź�
    input [31:0] writeData,//��Ҫд�����ݴ洢��������
    input [31:0] DataAddr,//����Ŀ���ַ
    
    output [31:0] readData//����������
    );
    
reg [7:0] Memory [0:127];//�����洢������
wire [31:0] address;//�洢��Ԫ��ַ����

//�洢��ַ��4�ı���
assign address = (DataAddr << 2);

//������
assign readData [7:0] = (MemRead == 1) ? Memory[address + 3] : 8'bz;
assign readData [15:8] = (MemRead == 1) ? Memory[address + 2] : 8'bz;
assign readData [23:16] = (MemRead == 1) ? Memory[address + 1] : 8'bz;
assign readData [31:24] = (MemRead == 1) ? Memory[address] : 8'bz;

//д����
always @ (negedge CLK) begin
    if (MemWrite == 1) begin
        Memory[address] <= writeData [31:24];
        Memory[address + 1] <= writeData [23:16];
        Memory[address + 2] <= writeData [15:8];
        Memory[address + 3] <= writeData [7:0];
    end
end

endmodule

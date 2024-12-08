`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/11/25 17:33:51
// Design Name: 
// Module Name: Instruction_Memory
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


module Instruction_Memory(
    input InsMemRW,//����ָ��
    input [3:0] PC4,//PC����λ��4λ��
    input [31:0] InsAddr,//��Ҫȡ����ָ���ַ��32λ��
    
    //ȡ��ָ�32λ��
    output [5:0] op,//[31:26] op
    output [4:0] rs, rt, rd,//[25:21] rs; [20:16] rt; [15:11] rd
    output [4:0] shamt,//[10:6] shamt
    output [5:0] func,//[5:0] func
    output [15:0] Immediate,//[15:0] immediate
    output [31:0] JumpPC//PC��ת��ַ
    );

//�洢������
 reg [7:0] Mem [0:127];
 reg [31:0] readIns;//���������
 integer i;//���ڱ����洢��
 
 //�Ӵ洢��������������ֶ�
 assign op = readIns [31:26];
 assign rs = readIns [25:21];
 assign rt = readIns [20:16];
 assign rd = readIns [15:11];
 assign shamt = readIns [10:6];
 assign func = readIns [5:0]; 
 assign Immediate = readIns [15:0];
 assign JumpPC = {{PC4},{2'b00},{readIns[25:2]},{2'b00}};

initial begin
    $readmemb("D:/UserDFile/VivadoFile/Single_cycle_CPU/Instructions.txt", Mem);//���ļ��ж�ȡָ�
    
    for (i = 0; i < 128; i = i + 1) begin
        $display("Mem[%0d] = %08b", i, Mem[i]);
    end

    readIns = 0;//ָ���ʼ��
end

//����PC��ַ��8λһ�ж�������ָ��
always @ (InsAddr or InsMemRW) begin
    if (InsMemRW == 1) begin
        readIns [7:0] = Mem[InsAddr + 3];
        readIns [15:8] = Mem[InsAddr + 2];
        readIns [23:16] = Mem[InsAddr + 1];
        readIns [31:24] = Mem[InsAddr];
     end
 end
 
endmodule

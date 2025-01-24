`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/11/26 19:17:35
// Design Name: 
// Module Name: Sign_Zero_Extend
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


module Sign_Zero_Extend(
    input ExtSrc,//�����ź�
    input [15:0] Immediate,//����������
    
    output [31:0] ImExtend//�����չ�����
    );
    
    //��������չ
    assign ImExtend [15:0] = Immediate [15:0];
    assign ImExtend [31:16] = ExtSrc == 1 ? {16{Immediate[15]}} : 16'b0;

endmodule

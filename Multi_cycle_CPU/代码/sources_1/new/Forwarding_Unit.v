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
    input [4:0] MEM_writeSrc, WB_writeSrc,//两条指令的寄存器写地址
    input [4:0] EXE_rs, EXE_rt, ID_rs, ID_rt,//两条指令的寄存器取数地址
    input MEM_RegWrite, WB_RegWrite,//寄存器写使能，用于判断是否需要转发
    input [1:0] PCSrc,//PC更新选择，用于判断指令类型
    
    output [1:0] forward_ID_A, forward_ID_B, forward_EXE_A, forward_EXE_B//转发控制信号
    );
    
    assign forward_ID_A[0] = ((MEM_RegWrite == 1) && (MEM_writeSrc != 0) && (PCSrc[0] == 1) && (MEM_writeSrc == ID_rs)) ? 1 : 0;
    assign forward_ID_B[0] = ((MEM_RegWrite == 1) && (MEM_writeSrc != 0) && (PCSrc[0] == 1) && (MEM_writeSrc == ID_rt)) ? 1 : 0;
    assign forward_ID_A[1] = ((WB_RegWrite == 1) && (WB_writeSrc != 0) && (PCSrc[0] == 1) && (WB_writeSrc == ID_rs)) ? 1 : 0;
    assign forward_ID_B[1] = ((WB_RegWrite == 1) && (WB_writeSrc != 0) && (PCSrc[0] == 1) && (WB_writeSrc == ID_rt)) ? 1 : 0;
    assign forward_EXE_A[0] = ((MEM_RegWrite == 1) && (MEM_writeSrc != 0) && (MEM_writeSrc == EXE_rs)) ? 1 : 0;//应该可以不需要PCSrc[0] == 0吧
    assign forward_EXE_B[0] = ((MEM_RegWrite == 1) && (MEM_writeSrc != 0) && (MEM_writeSrc == EXE_rt)) ? 1 : 0;//不能加！可能同时有两种转发
    assign forward_EXE_A[1] = ((WB_RegWrite == 1) && (WB_writeSrc != 0) && (WB_writeSrc == EXE_rs)) ? 1 : 0;
    assign forward_EXE_B[1] = ((WB_RegWrite == 1) && (WB_writeSrc != 0) && (WB_writeSrc == EXE_rt)) ? 1 : 0;
    
endmodule

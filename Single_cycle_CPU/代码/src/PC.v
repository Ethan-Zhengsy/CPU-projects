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
    input CLK, Reset, PCWrite, //控制参数
    input [1:0] PCSrc,//PC种类选择 branch+jump
    input signed [15:0] Immediate,//立即数
    input [31:0] JumpPC,//跳转
    
    output reg signed [31:0] InsAddr,//需要取出的指令地址
    output [31:0] nextPC,//下一条指令地址
    output [3:0] PC4 //PC高四位
    );
    
    //下条PC值
    assign nextPC = (PCSrc[0]) ? InsAddr + 4 + (Immediate << 2) : ((PCSrc[1]) ? JumpPC : InsAddr + 4);
    
    assign PC4 = InsAddr[31:28];
    
    //指令地址计算
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

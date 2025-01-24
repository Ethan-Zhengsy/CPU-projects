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
    input CLK, Reset, PCWrite_C, PCWrite_HD,//控制参数
    input zero,//条件分支控制
    input [1:0] PCSrc,//PC种类选择
    input [31:0] ImExtend,//立即数,这里可能需要修改(移位？符号）
    input [31:0] JumpPC,//PC无条件跳转
    input [31:0] storeDataA,//寄存器读出的指令地址，用于jr指令
    input [31:0] outnextPC4,//经过IF_ID寄存器后的PC + 4
    
    output reg signed [31:0] InsAddr,//需要取出的指令地址
    output [31:0] nextPC4,//InsAddr + 4(未经过IF_ID寄存器的PC + 4）
    output [31:0] nextPC//等待写入的PC值,也用于输出到数码管
//    output [3:0] PC4//PC高四位
    );

    wire [31:0] branchPC;
    
    //输出数据计算
    assign nextPC4 = InsAddr + 4;
    assign branchPC = (zero) ? outnextPC4 + (ImExtend << 2) : outnextPC4 + 4;
    assign nextPC = (PCSrc == 2'b11) ? storeDataA : ((PCSrc == 2'b10) ? JumpPC : ((PCSrc == 2'b01) ? branchPC : InsAddr + 4));
    
    //指令地址更新
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

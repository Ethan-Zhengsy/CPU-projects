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
    input [4:0] rs, rt, rd, //操作数地址（5位）
    input CLK, RegWrite, RegDst, MemtoReg,//控制指令
    input [31:0] ALUData, DMData,//需要写入寄存器的数据(32位）
    output [31:0] readData1, readData2,//rs, rt操作数（32位）
    output [31:0] DBData//总线数据（用于数码管显示，32位)
    );
    
    //控制码选择数据
    wire [4:0] writeSrc;//需要写入的寄存器地址选择
    assign writeSrc = RegDst ? rd : rt;//RegDst 0:写入rt 1:写入rd
    
    assign DBData = MemtoReg ? DMData : ALUData;//MemtoReg 0:从ALU写入 1:从DataMemory写入
    
    //寄存器操作
    reg [31:0] register[0:31];//创建32 32位寄存器本体
    
    integer i;//用于遍历寄存器
    initial //初始化寄存器
        begin
            for(i = 0; i < 32; i = i + 1) begin
                register[i] <= 0;
            end
        end
    
    assign readData1 = register[rs];//输出rs对应操作数
    assign readData2 = register[rt];//输出rt对应操作数
    
    always @ (posedge CLK) begin//写入数据到寄存器
        if (RegWrite && writeSrc) begin
            register[writeSrc] <= DBData;//将总线数据写入对应寄存器
        end
    end
    
endmodule

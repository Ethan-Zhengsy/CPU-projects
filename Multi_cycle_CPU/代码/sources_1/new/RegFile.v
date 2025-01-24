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
    input CLK, RegWrite,//控制指令
    input [1:0] MemtoReg,//数据选择
    input [4:0] rs, rt, writeSrc,//操作数地址
    input [31:0] ALUData, DMData, nextPC4,//需要写入寄存器的数据
    
    output [31:0] readData1, readData2,//rs, rt操作数
    output [31:0] DBData//总线数据 
    );
    
    //控制码选择数据
    assign DBData = (MemtoReg[0]) ? DMData : ((MemtoReg[1]) ? nextPC4 : ALUData);
    
    //创建寄存器本体
    reg [31:0] register[0:31];
    
    integer i;//用于遍历寄存器
    initial begin 
        for (i = 0; i < 32; i = i + 1) begin
            register[i] <= 0;
        end
    end
    
    assign readData1 = register[rs];//输出rs对应操作数
    assign readData2 = register[rt];//输出rt对应操作数
    
    always @ (posedge CLK) begin//写入数据到寄存器
        if (RegWrite && CLK && (writeSrc != 5'b00000)) begin
            register[writeSrc] <= DBData;
        end
    end
    
endmodule

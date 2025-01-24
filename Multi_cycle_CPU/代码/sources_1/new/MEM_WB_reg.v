`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/12/25 19:07:43
// Design Name: 
// Module Name: MEM_WB_reg
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


module MEM_WB_reg(
    input CLK,//时钟信号
    
    input [31:0] ALUData,//ALU输出数据
    input [31:0] DMData,//数据寄存器读出数据
    input [31:0] nextPC4,//下条PC地址
    input [4:0] writeSrc,//寄存器堆写地址
    
    input [1:0] MemtoReg,//总线数据选择
    input RegWrite,//寄存器写使能
    
    output [31:0] outALUData,//ALU输出数据
    output [31:0] outDMData,//数据寄存器读出数据
    output [31:0] outnextPC4,//下条PC地址
    output [4:0] outwriteSrc,//寄存器堆写地址
    output [1:0] outMemtoReg,//总线数据选择
    output outRegWrite//寄存器写使能
    );
    
    //创建流水寄存器本体
    reg [31:0] MEM_WB_AD;
    reg [31:0] MEM_WB_MD;
    reg [31:0] MEM_WB_PC;
    reg [7:0] MEM_WB_REG;
    
    //初始化流水寄存器
    initial begin
        MEM_WB_AD <= 0;
        MEM_WB_MD <= 0;
        MEM_WB_PC <= 0;
        MEM_WB_REG <= 0;
    end
    
    //分配输出接口
    assign outALUData = MEM_WB_AD[31:0];
    assign outDMData = MEM_WB_MD[31:0];
    assign outnextPC4 = MEM_WB_PC[31:0];
    assign outwriteSrc = MEM_WB_REG[7:3];
    assign outMemtoReg = MEM_WB_REG[2:1];
    assign outRegWrite = MEM_WB_REG[0];
    
    //状态变化:时钟下降沿更新
    always @ (negedge CLK) begin
        MEM_WB_AD <= ALUData;
        MEM_WB_MD <= DMData;
        MEM_WB_PC <= nextPC4;
        MEM_WB_REG[7:3] <= writeSrc;
        MEM_WB_REG[2:1] <= MemtoReg;
        MEM_WB_REG[0] <= RegWrite;
    end
    
endmodule

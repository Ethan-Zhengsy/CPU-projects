`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/12/25 11:28:56
// Design Name: 
// Module Name: EXE_MEM_reg
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


module EXE_MEM_reg(
    input CLK,//时钟信号
    
    input [31:0] ALUData,//ALU数据
    input [31:0] updateDataB,//转发后的rt操作数
    input [4:0] writeSrc,//寄存器堆写地址
    
    input [31:0] nextPC4,//下条PC地址
    input MemWrite, MemRead,//数据存储器控制信号
    input [1:0] MemtoReg,//总线数据选择
    input RegWrite,//寄存器写使能
    
    output [31:0] outALUData,//ALUData输出
    output [31:0] writeData,//数据存储器写入数据
    output [4:0] outwriteSrc,//寄存器写入地址
    output [31:0] outnextPC4,//下条PC地址
    output outMemWrite, outMemRead,//数据存储器控制信号
    output [1:0] outMemtoReg,//总线数据选择
    output outRegWrite//寄存器写使能
    );
    
    //创建流水寄存器本体
    reg [31:0] EXE_MEM_AD;
    reg [31:0] EXE_MEM_WD;
    reg [31:0] EXE_MEM_PC;
    reg [4:0] EXE_MEM_writeSrc;
    reg [4:0] EXE_MEM_MEM;
    
    //初始化流水寄存器
    initial begin
        EXE_MEM_AD <= 0;
        EXE_MEM_WD <= 0;
        EXE_MEM_PC <= 0;
        EXE_MEM_writeSrc <= 0;
        EXE_MEM_MEM <= 0;
    end
    
    //分配流水寄存器输出口
    assign outALUData = EXE_MEM_AD[31:0];
    assign writeData = EXE_MEM_WD[31:0];
    assign outnextPC4 = EXE_MEM_PC[31:0];
    assign outwriteSrc = EXE_MEM_writeSrc[4:0];
    assign outMemWrite = EXE_MEM_MEM[4];
    assign outMemRead = EXE_MEM_MEM[3];
    assign outMemtoReg = EXE_MEM_MEM[2:1];
    assign outRegWrite = EXE_MEM_MEM[0];
    
    //状态变化：时钟下降沿更新
    always @ (negedge CLK) begin
        EXE_MEM_AD <= ALUData;
        EXE_MEM_WD <= updateDataB;
        EXE_MEM_PC <= nextPC4;
        EXE_MEM_writeSrc <= writeSrc;
        EXE_MEM_MEM[4] <= MemWrite;
        EXE_MEM_MEM[3] <= MemRead;
        EXE_MEM_MEM[2:1] <= MemtoReg;
        EXE_MEM_MEM[0] <= RegWrite;
    end
    
endmodule

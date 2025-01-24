`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/12/24 17:30:50
// Design Name: 
// Module Name: ID_EXE_reg
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


module ID_EXE_reg(
    input CLK, //时钟信号
    input ID_EXE_Flush,//冲刷
    
    input [1:0] forward_ID_A, forward_ID_B,//转发信号选择（用于条件分支）
    input [1:0] zeroOp,//分支指令类型，用于是否跳转
    input [1:0] RegDst,//寄存器写地址选择
    
    input [31:0] readDataA, readDataB,//寄存器读出信号
    input [31:0] MEMforwardData, WBforwardData,//转发信号
    input [4:0] rs,//与rt一起用作转发检测
    input [4:0] rt, rd,//寄存器写地址
    
    input [4:0] shamt,//位移字段
    input [31:0] ImExtend,//立即数扩展
    input [31:0] nextPC4,//下一条PC值
    
    input ALUSrcA, ALUSrcB,//ALU控制信号
    input [2:0] ALUCtr,//ALU运算控制
    input MemWrite, MemRead, //数据存储器控制
    input [1:0] MemtoReg,//总线数据选择
    input RegWrite,//寄存器堆写使能
    
    output [31:0] outDataA, outDataB,//ALU操作数
    output [4:0] outwriteSrc,//寄存器堆写地址
    output [4:0] outrs, outrt,//用于转发判断
    
    output [31:0] outnextPC4,//下一条PC
    output [4:0] outshamt,//移位字段
    output [31:0] outImExtend,//立即数扩展
    
    output outALUSrcA, outALUSrcB,//ALU控制信号
    output [2:0] outALUCtr,//ALU运算控制
    output outMemWrite, outMemRead, //数据存储器控制
    output [1:0] outMemtoReg,//总线数据选择
    output outRegWrite,//寄存器堆写使能
    
    output zero,//跳转条件判断
    output [31:0] storeDataA, storeDataB//用于jr指令取出寄存器和输出显示
    );
    
    //构建流水寄存器本体
    reg [31:0] ID_EXE_DataA;
    reg [31:0] ID_EXE_DataB;
    reg [4:0] ID_EXE_Rs;
    reg [4:0] ID_EXE_Rt;
    reg [4:0] ID_EXE_WriteSrc;
    reg [31:0] ID_EXE_PC;
    reg [4:0] ID_EXE_Shamt;
    reg [31:0] ID_EXE_ImExtend;
    reg [4:0] ID_EXE_EX;
    reg [4:0] ID_EXE_MEM;
    
    //初始化流水寄存器
    initial begin
        ID_EXE_DataA <= 0;
        ID_EXE_DataB <= 0;
        ID_EXE_Rs <= 0;
        ID_EXE_Rt <= 0;
        ID_EXE_WriteSrc <= 0;
        ID_EXE_PC <= 0;
        ID_EXE_Shamt <= 0;
        ID_EXE_ImExtend <= 0;
        ID_EXE_EX <= 0;
        ID_EXE_MEM <= 0;
    end
    
    //数据选择
//    wire [31:0] storeDataB;//写入流水寄存器的操作数（转发）
    assign storeDataA = (forward_ID_A[0]) ? MEMforwardData : ((forward_ID_A[1]) ? WBforwardData : readDataA);
    assign storeDataB = (forward_ID_B[0]) ? MEMforwardData : ((forward_ID_B[1]) ? WBforwardData : readDataB);
    wire [4:0] writeSrc;
    assign writeSrc = (RegDst[0]) ? rd : ((RegDst[1]) ? 5'b11111 : rt);
    
    //跳转条件判断
//    assign zero = (storeDataA == storeDataB) ? 1 : 0;//这里可能需要修改,与控制单元有关
    wire zeroData1, zeroData2, zeroData3;
    assign zeroData1= (storeDataA - storeDataB == 0) ? 1 : 0;
    assign zeroData2 = (storeDataA < storeDataB) ? 1 : 0;//可能需要重新考虑符号？
    assign zeroData3 = (storeDataA[31] == 0 && storeDataB[31] == 0) ? zeroData2 : ~zeroData2;
    assign zero = (zeroOp[0]) ? ~zeroData1 : ((zeroOp[1])? zeroData3 : zeroData1);
    
    //从寄存器分配输出字段
    assign outDataA = ID_EXE_DataA[31:0];
    assign outDataB = ID_EXE_DataB[31:0];
    assign outrs = ID_EXE_Rs[4:0];
    assign outrt = ID_EXE_Rt[4:0];
    assign outwriteSrc = ID_EXE_WriteSrc[4:0];
    assign outnextPC4 = ID_EXE_PC[31:0];
    assign outshamt = ID_EXE_Shamt[4:0];
    assign outImExtend = ID_EXE_ImExtend[31:0];
    assign outALUSrcA = ID_EXE_EX[4];
    assign outALUSrcB = ID_EXE_EX[3];
    assign outALUCtr = ID_EXE_EX[2:0];
    assign outMemWrite = ID_EXE_MEM[4];
    assign outMemRead = ID_EXE_MEM[3];
    assign outMemtoReg = ID_EXE_MEM[2:1];
    assign outRegWrite = ID_EXE_MEM[0];
    
    //状态变化：时钟下降沿改变
    always @ (negedge CLK) begin
        ID_EXE_PC <= nextPC4;
        if (ID_EXE_Flush == 0) begin
            ID_EXE_DataA <= storeDataA;
            ID_EXE_DataB <= storeDataB;
            ID_EXE_Rs <= rs;
            ID_EXE_Rt <= rt;
            ID_EXE_WriteSrc <= writeSrc;
            ID_EXE_Shamt <= shamt;
            ID_EXE_ImExtend <= ImExtend;
            ID_EXE_EX [4] <= ALUSrcA;
            ID_EXE_EX [3] <= ALUSrcB;
            ID_EXE_EX [2:0] <= ALUCtr;
            ID_EXE_MEM [4] <= MemWrite;
            ID_EXE_MEM [3] <= MemRead;
            ID_EXE_MEM [2:1] <= MemtoReg;
            ID_EXE_MEM [0] <= RegWrite;
        end
        else begin
            ID_EXE_DataA <= 0;
            ID_EXE_DataB <= 0;
            ID_EXE_Rs <= 0;
            ID_EXE_Rt <= 0;
            ID_EXE_WriteSrc <= 0;
            ID_EXE_Shamt <= 0;
            ID_EXE_ImExtend <= 0;
            ID_EXE_EX [4] <= 0;
            ID_EXE_EX [3] <= 0;
            ID_EXE_EX [2:0] <= 0;
            ID_EXE_MEM [4] <= 0;
            ID_EXE_MEM [3] <= 0;
            ID_EXE_MEM [2:1] <= 0;
            ID_EXE_MEM [0] <= 0;
        end
    end
    
endmodule

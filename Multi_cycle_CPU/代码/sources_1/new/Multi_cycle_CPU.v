`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/12/27 19:15:17
// Design Name: 
// Module Name: Multi_cycle_CPU
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


module Multi_cycle_CPU(
    input CLK, Reset,//输入时钟信号和清零信号
//    input IF_ID_Start,//用于启动CPU

//    input IF_ID_Write,//流水寄存器写使能
//    input WB_RegWrite,//寄存器写使能
    
    //输出需要显示的数据
    output IF_ID_Write,
    output [4:0] ID_rs, ID_rt,
    output [5:0] ID_op,
    output [5:0] ID_func,
    output [31:0] EXE_updateDataA, EXE_updateDataB, IF_InsAddr, IF_nextPC, EXE_ALUData, WB_DBData,
    output [4:0] ID_shamt,
    output [31:0] ID_ImExtend
    );
    
    //其他连接线声明
    wire ID_PCWrite_C, PCWrite_HD;
    wire ID_ExtSrc, ID_MemWrite, ID_MemRead, ID_InsMemRW, ID_RegWrite, ID_ALUSrcA, ID_ALUSrcB, ID_EXE_flush, ID_zero;
    wire EXE_MemWrite, EXE_MemRead, EXE_RegWrite, EXE_ALUSrcA, EXE_ALUSrcB;
    wire MEM_MemWrite, MEM_MemRead, Mem_RegWrite;
    wire WB_RegWrite;
    wire [1:0] ID_PCSrc, ID_zeroOp, ID_MemtoReg, ID_RegDst, forward_ID_A, forward_ID_B, forward_EXE_A, forward_EXE_B;
    wire [1:0] EXE_MemtoReg, MEM_MemtoReg, WB_MemtoReg;
    wire [2:0] ID_ALUCtr, EXE_ALUCtr;
    wire [3:0] ID_ALUOp;
    wire [4:0] ID_rd, EXE_shamt;
    wire [4:0] EXE_rs, EXE_rt, EXE_writeSrc;
    wire [4:0] MEM_writeSrc, WB_writeSrc;
    wire [15:0] ID_Immediate;
    wire [31:0] IF_readIns, IF_nextPC4;
    wire [31:0] ID_JumpPC, ID_nextPC4, ID_readDataA, ID_readDataB, ID_storeDataA, ID_storeDataB;
    wire [31:0] EXE_readDataA, EXE_readDataB, EXE_nextPC4, EXE_ImExtend;
    wire [31:0] MEM_ALUData, MEM_updateDataB, MEM_nextPC4, MEM_DMData;
    wire [31:0] WB_ALUData, WB_DMData, WB_nextPC4;
    
    //元件实例化
    ALU alu(EXE_ALUSrcA, EXE_ALUSrcB, forward_EXE_A, forward_EXE_B, EXE_ALUCtr, EXE_readDataA, EXE_readDataB, MEM_ALUData, WB_DBData, EXE_shamt, EXE_ImExtend, EXE_ALUData, EXE_updateDataA, EXE_updateDataB);
    ALU_Control alu_c(ID_ALUOp, ID_func, ID_ALUSrcA, ID_ALUSrcB, ID_ALUCtr);
    Control_Unit ctr_u(ID_op, ID_func, ID_ExtSrc, ID_MemWrite, ID_MemRead, ID_InsMemRW, ID_PCWrite_C, ID_RegWrite, ID_PCSrc, ID_MemtoReg, ID_RegDst, ID_zeroOp, ID_ALUOp);
    Data_Memory d_mem(CLK, MEM_MemWrite, MEM_MemRead, MEM_updateDataB, MEM_ALUData, MEM_DMData);
    EXE_MEM_reg exe_mem(CLK, EXE_ALUData, EXE_updateDataB, EXE_writeSrc, EXE_nextPC4, EXE_MemWrite, EXE_MemRead, EXE_MemtoReg, EXE_RegWrite, MEM_ALUData, MEM_updateDataB, MEM_writeSrc, MEM_nextPC4, MEM_MemWrite, MEM_MemRead, MEM_MemtoReg, MEM_RegWrite);
    Forwarding_Unit fw_u(MEM_writeSrc, WB_writeSrc, EXE_rs, EXE_rt, ID_rs, ID_rt, MEM_RegWrite, WB_RegWrite, ID_PCSrc, forward_ID_A, forward_ID_B, forward_EXE_A, forward_EXE_B);
    Hazard_Detection haz_d(EXE_MemRead, ID_PCSrc, EXE_writeSrc, ID_rs, ID_rt, ID_op, IF_ID_Write, ID_EXE_flush, PCWrite_HD);
    ID_EXE_reg id_exe(CLK, ID_EXE_flush, forward_ID_A, forward_ID_B, ID_zeroOp, ID_RegDst, ID_readDataA, ID_readDataB, MEM_ALUData, WB_DBData, ID_rs, ID_rt, ID_rd, ID_shamt, ID_ImExtend, ID_nextPC4, ID_ALUSrcA, ID_ALUSrcB, ID_ALUCtr, ID_MemWrite, ID_MemRead, ID_MemtoReg, ID_RegWrite, EXE_readDataA, EXE_readDataB, EXE_writeSrc, EXE_rs, EXE_rt, EXE_nextPC4, EXE_shamt, EXE_ImExtend, EXE_ALUSrcA, EXE_ALUSrcB, EXE_ALUCtr, EXE_MemWrite, EXE_MemRead, EXE_MemtoReg, EXE_RegWrite, ID_zero, ID_storeDataA, ID_storeDataB);
    IF_ID_reg if_id(CLK, IF_ID_Write, ID_zero, ID_PCSrc, IF_nextPC4, IF_readIns, ID_nextPC4, ID_op, ID_rs, ID_rt, ID_rd, ID_shamt, ID_func, ID_Immediate, ID_JumpPC);
    Instruction_Memory i_mem(ID_InsMemRW, IF_InsAddr, IF_readIns);
    MEM_WB_reg mem_wb(CLK, MEM_ALUData, MEM_DMData, MEM_nextPC4, MEM_writeSrc, MEM_MemtoReg, MEM_RegWrite, WB_ALUData, WB_DMData, WB_nextPC4, WB_writeSrc, WB_MemtoReg, WB_RegWrite);
    PC pc(CLK, Reset, ID_PCWrite_C, PCWrite_HD, ID_zero, ID_PCSrc, ID_ImExtend, ID_JumpPC, ID_storeDataA, ID_nextPC4, IF_InsAddr, IF_nextPC4, IF_nextPC);
    RegFile reg_f(CLK, WB_RegWrite, WB_MemtoReg, ID_rs, ID_rt, WB_writeSrc, WB_ALUData, WB_DMData, WB_nextPC4, ID_readDataA, ID_readDataB, WB_DBData);
    Sign_Zero_Extend ext(ID_ExtSrc, ID_Immediate, ID_ImExtend);
endmodule

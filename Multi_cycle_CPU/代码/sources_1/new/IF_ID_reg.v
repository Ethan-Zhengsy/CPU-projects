`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/12/25 09:16:10
// Design Name: 
// Module Name: IF_ID_reg
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


module IF_ID_reg(
    input CLK, //时钟信号
//    input IF_ID_Start,//启动，读入第一条指令
    input IF_ID_Write,//写使能
    input zero,//分支预测情况
    input [1:0] PCSrc,//PC更新选择，是否跳转
    input [31:0] nextPC4,//下条PC
    input [31:0] readIns,//ID阶段读出的指令
    
    //取出指令（32位）
    output [31:0] outnextPC4,//读出下条PC
    output [5:0] op,//[31:26] op
    output [4:0] rs, rt, rd,//[25:21] rs; [20:16] rt; [15:11] rd
    output [4:0] shamt,//[10:6] shamt
    output [5:0] func,//[5:0] func
    output [15:0] Immediate,//[15:0] immediate
    output [31:0] JumpPC//PC跳转地址
    );
    
    //初始化流水寄存器本体
//    reg [31:0] IF_ID_reg [1:0];//流水寄存器本体
    reg [31:0] IF_ID_Ins;//流水寄存器存储的指令
    reg [31:0] IF_ID_PC;//流水寄存器存储的下条PC
    
    initial 
        begin
            IF_ID_Ins <= 0;
            IF_ID_PC <= 0;
        end
    
    //从寄存器输出分配字段
    assign outnextPC4 = IF_ID_PC [31:0];
    assign op = IF_ID_Ins [31:26];//这个可能不用flush,应改为不写
    assign rs = IF_ID_Ins [25:21];
    assign rt = IF_ID_Ins [20:16];
    assign rd = IF_ID_Ins [15:11];
    assign shamt = IF_ID_Ins [10:6];
    assign func = IF_ID_Ins [5:0];
    assign Immediate = IF_ID_Ins [15:0];
    assign JumpPC = {{IF_ID_PC[31:28]},{2'b00},{IF_ID_Ins[25:2]},{2'b00}};
    
    //状态变化：时钟下降沿改变
    always @ (negedge CLK) begin
//        IF_ID_PC <= nextPC4;
        if ((IF_ID_Write == 1) && (((zero == 1) && (PCSrc == 2'b01)) || (PCSrc[1] == 1))) begin
            IF_ID_Ins <= 0;
        end
        else if (IF_ID_Write == 1) begin
            IF_ID_Ins <= readIns;
            IF_ID_PC <= nextPC4;
        end
    end
    
endmodule

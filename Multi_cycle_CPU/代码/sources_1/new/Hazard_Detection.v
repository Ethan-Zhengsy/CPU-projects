`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/12/27 21:23:52
// Design Name: 
// Module Name: Hazard_Detection
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


module Hazard_Detection(
    input MemRead,//检测是否为LW指令
    input [1:0] PCSrc,//检测是否为分支指令
    input [4:0] EXE_writeSrc,//寄存器写地址
    input [4:0] ID_rs, ID_rt,//寄存器取数地址
    input [5:0] op,
    
    output IF_ID_write, ID_EXE_flush, PCWrite_HD
    );
    
    assign IF_ID_write = (((EXE_writeSrc != 5'b00000) && ((MemRead == 1) || (PCSrc[0] == 1)) && ((EXE_writeSrc == ID_rs) || (EXE_writeSrc == ID_rt))) || op == 6'b111111) ? 0 : 1;
    assign ID_EXE_flush = (((EXE_writeSrc != 5'b00000) && ((MemRead == 1) || (PCSrc[0] == 1)) && ((EXE_writeSrc == ID_rs) || (EXE_writeSrc == ID_rt))) || op == 6'b111111) ? 1 : 0;
    assign PCWrite_HD = (((EXE_writeSrc != 5'b00000) && ((MemRead == 1) || (PCSrc[0] == 1)) && ((EXE_writeSrc == ID_rs) || (EXE_writeSrc == ID_rt))) || op == 6'b111111) ? 0 : 1;

endmodule

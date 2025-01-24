`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/11/25 16:37:11
// Design Name: 
// Module Name: Data_Memory
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


module Data_Memory(
    input CLK, MemWrite, MemRead,//控制信号
    input [31:0] writeData,//需要写入数据存储器的数据
    input [31:0] DataAddr,//数据目标地址
    
    output [31:0] readData//读出的数据
    );
    
reg [7:0] Memory [0:127];//创建存储器本体
wire [31:0] address;//存储单元地址编码

//存储地址是4的倍数
assign address = (DataAddr << 2);

//读数据
assign readData [7:0] = (MemRead == 1) ? Memory[address + 3] : 8'bz;
assign readData [15:8] = (MemRead == 1) ? Memory[address + 2] : 8'bz;
assign readData [23:16] = (MemRead == 1) ? Memory[address + 1] : 8'bz;
assign readData [31:24] = (MemRead == 1) ? Memory[address] : 8'bz;

//写数据
always @ (negedge CLK) begin
    if (MemWrite == 1) begin
        Memory[address] <= writeData [31:24];
        Memory[address + 1] <= writeData [23:16];
        Memory[address + 2] <= writeData [15:8];
        Memory[address + 3] <= writeData [7:0];
    end
end

endmodule

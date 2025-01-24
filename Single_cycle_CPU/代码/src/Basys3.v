`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/12/01 00:47:26
// Design Name: 
// Module Name: Basys3
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


module Basys3(
    input CLKButton,//输入按键信号
    input BasysCLK,//系统时钟
    input RST_Button,//Reset信号开关
    input [1:0] SW_in,//显示数据选择开关
    
    output [7:0] SegOut,//需要点亮数码管的图形
    output [3:0] Bits//数码管位选信号
    );
    
    //实例化
    
    //CPU
    wire [4:0] rs, rt;
    wire [31:0] readData1, readData2;
    wire [31:0] ALUData;
    wire [31:0] DBData;
    wire [31:0] curPC, nextPC;
    
    wire CPUCLK;
    Single_cycle_CPU cpu(
        .CLK(CPUCLK),
        .Reset(RST_Button),
        .rs(rs),
        .rt(rt),
        .readData1(readData1),
        .readData2(readData2),
        .curPC(curPC),
        .nextPC(nextPC),
        .ALUData(ALUData),
        .DBData(DBData)
    );
    
    //CLK_slow
    
    wire Div_CLK;
    CLK_Slow clk_slow(
        .CLK_100mhz(BasysCLK),
        .CLK_slow(Div_CLK)
    );
    
    //Display_7Seg
    
    wire [3:0] SegIn;
    Display_7SegLED display_led(
        .display_data(SegIn),
        .dispcode(SegOut)
    );
    
    //Display_select
    
    wire [15:0] display_data;
    Select select(
        .In1({curPC[7:0], nextPC[7:0]}),
        .In2({3'b000, rs[4:0], readData1[7:0]}),
        .In3({3'b000, rt[4:0], readData2[7:0]}),
        .In4({ALUData[7:0], DBData[7:0]}),
        
        .SelectCode(SW_in),
        .DataOut(display_data)
    );
    
    //Display_transfer
    Transfer transfer(
        .CLK(Div_CLK),
        .In(display_data),
        
        .Out(SegIn),
        .Bit(Bits)
    );
    
    //keyboard
    KeyBoard_CLK keyboard(
        .Button(CLKButton),
        .BasysCLK(BasysCLK),
        .CPUCLK(CPUCLK)
    );
endmodule

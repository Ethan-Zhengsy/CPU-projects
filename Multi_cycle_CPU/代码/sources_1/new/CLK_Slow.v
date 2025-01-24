`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/12/09 17:32:23
// Design Name: 
// Module Name: CLK_Slow
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


module CLK_Slow(
    input CLK_100mhz,//输入系统时钟
    
    output reg CLK_slow//输出分频后的时钟
    );

//构造分频计数器
reg [31:0] count = 0;
reg [31:0] N = 50000;

initial CLK_slow = 0;

always @ (posedge CLK_100mhz) begin
    if (count >= N) begin
        count <= 0;
        CLK_slow <= ~CLK_slow;
    end
    else
        count <= count + 1;
end

endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/12/09 18:08:22
// Design Name: 
// Module Name: Transfer
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


module Transfer(
    input CLK,//分频后的时钟
    input [15:0] In,//输入需要显示的数据
    
    output reg [3:0] Out,//需要显示在数码管上的数字（1位）
    output reg [3:0] Bit//数码管扫描信号
    );

//用于遍历需要显示的信号的每一位并对应到相对的数码管
integer i;
initial begin
    i = 0;
end

//选择需要显示的数据和需要点亮的数码管
always @ (negedge CLK) begin
    case(i)
        0 : begin
            Out = In [15:12];
            Bit = 4'b1110;
        end
        1 : begin
            Out = In [11:8];
            Bit = 4'b1101;
        end
        2 : begin
            Out = In [7:4];
            Bit = 4'b1011;
        end
        3 : begin
            Out = In [3:0];
            Bit = 4'b0111;
        end
    endcase
    i = (i == 3) ? 0 : i + 1;
end

endmodule

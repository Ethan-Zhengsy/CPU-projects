`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/11/26 20:10:18
// Design Name: 
// Module Name: KeyBoard_CLK
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


module KeyBoard_CLK(
    input Button,//按键输入
    input BasysCLK,//系统时钟，用于消抖
    
    output CPUCLK//输出按键时钟
    );
    
reg button_previous_state;
reg button_current_state;

wire button_edge;

always @ (posedge BasysCLK) begin
    button_current_state <= Button;
    button_previous_state <= button_current_state;
end

assign button_edge = button_previous_state & (~button_current_state);

reg [20:0] counter;

always @ (posedge BasysCLK) begin
    if (button_edge)
        counter <= 21'h0;
    else
        counter <= counter + 1;
end

reg delayed_button_previous_state;
reg delayed_button_current_state;

always @ (posedge BasysCLK) begin
    if (counter == 21'h1E8480)
        delayed_button_current_state <= button_current_state;
    delayed_button_previous_state <= delayed_button_current_state;
end

assign CPUCLK = delayed_button_previous_state & (~delayed_button_current_state);

endmodule

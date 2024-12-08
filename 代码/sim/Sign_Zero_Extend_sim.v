`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/11/26 19:37:51
// Design Name: 
// Module Name: Sign_Zero_Extend_sim
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


module Sign_Zero_Extend_sim();

//inputs
reg ExtSrc;
reg signed [15:0] Immediate;

//outputs
wire [31:0] ImExtend;

Sign_Zero_Extend uut(
    .ExtSrc(ExtSrc),
    .Immediate(Immediate),
    .ImExtend(ImExtend)
);

initial begin
    //record
    $dumpfile("Sign_Zero_Extend.vcd");
    $dumpvars(0, Sign_Zero_Extend_sim);
    
    #50;
    ExtSrc = 0;
    Immediate [15:0] = 15'd7;
    
    #50;
    ExtSrc = 1;
    Immediate [15:0] = 15'd10;
    
    #50;
    ExtSrc = 1;
    Immediate [15:0] = 15'd7;
    Immediate[15] = 1;
    
    //stop
    #50;
    $stop;
end
endmodule

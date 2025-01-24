`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/12/17 23:46:18
// Design Name: 
// Module Name: Data_Memory_sim
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


module Data_Memory_sim;

//input
reg CLK, MemWrite, MemRead;
reg [31:0] writeData, DataAddr;

//output
wire [31:0] readData;

Data_Memory uut(
    .CLK(CLK),
    .MemWrite(MemWrite),
    .MemRead(MemRead),
    .writeData(writeData),
    .DataAddr(DataAddr),
    .readData(readData)
);

always #15 CLK = ~CLK;

initial begin
    //record
    $dumpfile("Data_Memory.vcd");
    $dumpvars(0, Data_Memory_sim);
    
    //≥ı ºªØ
    CLK= 0;
    DataAddr = 0;
    writeData = 0;
    MemRead = 0;
    MemWrite = 0;
    
    #30;
    DataAddr = 8;
    writeData = 8;
    MemRead = 0;
    MemWrite = 1;
    
    #30;
    DataAddr = 12;
    writeData = 12;
    MemRead = 0;
    MemWrite = 1;
    
    #30;
    DataAddr = 8;
    MemRead = 1;
    MemWrite = 0;
    
    #30;
    DataAddr = 12;
    MemRead = 1;
    MemWrite = 0;
    
    #30;
    $stop;
end
endmodule

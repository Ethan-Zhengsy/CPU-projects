`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/11/18 17:37:51
// Design Name: 
// Module Name: RegFile_sim
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


module RegFile_sim;
    //inputs
    reg [4:0] rs, rt, rd;
    reg CLK, RegWrite, RegDst, MemtoReg;
    reg [31:0] ALUData, DMData;
    //outputs
    wire [31:0] readData1;
    wire [31:0] readData2;
    
    RegFile uut(
        .rs(rs),
        .rt(rt),
        .rd(rd),
        
        .CLK(CLK),
        .RegWrite(RegWrite),
        .RegDst(RegDst),
        .MemtoReg(MemtoReg),
        .ALUData(ALUData),
        .DMData(DMData),
        
        .readData1(readData1),
        .readData2(readData2)
    );

    always #15 CLK = ~CLK;
    
    initial begin
        //record
        $dumpfile("RegisterFile.vcd");
        $dumpvars(0, RegFile_sim);
    
        CLK = 0;
        //Test 1
        #10;
        CLK = 0;
        RegDst = 1;
        RegWrite = 1;
        MemtoReg = 0;
        rs = 5'b00000;
        rt = 5'b00001;
        rd = 5'b00010;
        ALUData = 32'd1;
        DMData = 32'd2;
        
        //Test 2
        #100;
        RegDst = 0;
        RegWrite = 0;
        MemtoReg = 1;
        rs = 5'b00011;
        rt = 5'b00100;
        rd = 5'b00101;
        ALUData = 32'd3;
        DMData = 32'd4;

        $stop;
    end
endmodule

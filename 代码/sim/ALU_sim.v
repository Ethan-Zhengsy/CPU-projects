`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/11/30 16:13:23
// Design Name: 
// Module Name: ALU_sim
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


module ALU_sim();

    //input
    reg ALUSrcA, ALUSrcB;
    reg [2:0] ALUCtr;
    reg [31:0] readData1, readData2;
    reg [31:0] ImExtend;
    reg [4:0] shamt;
    
    //output
    wire zero;
    wire [31:0] ALUData;
    
    ALU uut(
        .ALUSrcA(ALUSrcA),
        .ALUSrcB(ALUSrcB),
        .ALUCtr(ALUCtr),
        .readData1(readData1),
        .readData2(readData2),
        .ImExtend(ImExtend),
        .shamt(shamt),
        .zero(zero),
        .ALUData(ALUData)
    );
    
    initial begin
        //record
        $dumpfile("ALU.vcd");
        $dumpvars(0, ALU_sim);
        
        //add1
        readData1 = 0;
        readData2 = 0;
        ImExtend = 1;
        shamt = 1;
        ALUCtr = 3'b000;
        ALUSrcA = 0;
        ALUSrcB = 0;
        
        //add2
        #50;
        readData1 = 0;
        readData2 = 0;
        ImExtend = 1;
        shamt = 1;
        ALUCtr = 3'b000;
        ALUSrcA = 1;
        ALUSrcB = 0;
        
        //add3
        #50;
        readData1 = 0;
        readData2 = 0;
        ImExtend = 1;
        shamt = 1;
        ALUCtr = 3'b000;
        ALUSrcA = 0;
        ALUSrcB = 1;
        
        //add4
        #50;
        readData1 = 0;
        readData2 = 0;
        ImExtend = 1;
        shamt = 1;
        ALUCtr = 3'b000;
        ALUSrcA = 1;
        ALUSrcB = 1;
        
        //sub1
        #50;
        readData1 = 1;
        readData2 = 2;
        ImExtend = 3;
        shamt = 4;
        ALUCtr = 3'b001;
        ALUSrcA = 0;
        ALUSrcB = 0;
        
        //sub2
        #50;
        readData1 = 1;
        readData2 = 2;
        ImExtend = 3;
        shamt = 4;
        ALUCtr = 3'b001;
        ALUSrcA = 1;
        ALUSrcB = 0;
        
        //sub3
        #50;
        readData1 = 1;
        readData2 = 2;
        ImExtend = 3;
        shamt = 4;
        ALUCtr = 3'b001;
        ALUSrcA = 0;
        ALUSrcB = 1;
        
        //sub4
        #50;
        readData1 = 1;
        readData2 = 2;
        ImExtend = 3;
        shamt = 4;
        ALUCtr = 3'b001;
        ALUSrcA = 1;
        ALUSrcB = 1;
        
        //and1
        #50;
        readData1 = 1;
        readData2 = 2;
        ImExtend = 2;
        shamt = 4;
        ALUCtr = 3'b010;
        ALUSrcA = 0;
        ALUSrcB = 0;
        
        //and2
        #50;
        readData1 = 1;
        readData2 = 2;
        ImExtend = 2;
        shamt = 4;
        ALUCtr = 3'b010;
        ALUSrcA = 1;
        ALUSrcB = 0;
        
        //and3
        #50;
        readData1 = 1;
        readData2 = 2;
        ImExtend = 2;
        shamt = 4;
        ALUCtr = 3'b010;
        ALUSrcA = 0;
        ALUSrcB = 1;
        
        //and4
        #50;
        readData1 = 1;
        readData2 = 2;
        ImExtend = 2;
        shamt = 4;
        ALUCtr = 3'b010;
        ALUSrcA = 1;
        ALUSrcB = 1;
        
        //or1
        #50;
        readData1 = 1;
        readData2 = 2;
        ImExtend = 2;
        shamt = 4;
        ALUCtr = 3'b011;
        ALUSrcA = 0;
        ALUSrcB = 0;
        
        //or2
        #50;
        readData1 = 1;
        readData2 = 2;
        ImExtend = 2;
        shamt = 4;
        ALUCtr = 3'b011;
        ALUSrcA = 1;
        ALUSrcB = 0;
        
        //or3
        #50;
        readData1 = 1;
        readData2 = 2;
        ImExtend = 2;
        shamt = 4;
        ALUCtr = 3'b011;
        ALUSrcA = 0;
        ALUSrcB = 1;
        
        //or4
        #50;
        readData1 = 1;
        readData2 = 2;
        ImExtend = 2;
        shamt = 4;
        ALUCtr = 3'b011;
        ALUSrcA = 1;
        ALUSrcB = 1;
        
        //left_shift1
        #50;
        readData1 = 1;
        readData2 = 2;
        ImExtend = 2;
        shamt = 4;
        ALUCtr = 3'b100;
        ALUSrcA = 0;
        ALUSrcB = 0;
        
        //left_shift2
        #50;
        readData1 = 1;
        readData2 = 2;
        ImExtend = 2;
        shamt = 4;
        ALUCtr = 3'b100;
        ALUSrcA = 1;
        ALUSrcB = 0;
        
        //left_shift3
        #50;
        readData1 = 1;
        readData2 = 2;
        ImExtend = 2;
        shamt = 4;
        ALUCtr = 3'b100;
        ALUSrcA = 0;
        ALUSrcB = 1;
        
        //left_shift4
        #50;
        readData1 = 1;
        readData2 = 2;
        ImExtend = 2;
        shamt = 4;
        ALUCtr = 3'b100;
        ALUSrcA = 1;
        ALUSrcB = 1;
        
        //smaller1
        #50;
        readData1 = 1;
        readData2 = 2;
        ImExtend = 2;
        shamt = 1;
        ALUCtr = 3'b101;
        ALUSrcA = 0;
        ALUSrcB = 0;
        
        //smaller2
        #50;
        readData1 = 1;
        readData2 = 2;
        ImExtend = 2;
        shamt = 1;
        ALUCtr = 3'b101;
        ALUSrcA = 1;
        ALUSrcB = 0;
        
        //smaller3
        #50;
        readData1 = 1;
        readData2 = 2;
        ImExtend = 2;
        shamt = 1;
        ALUCtr = 3'b101;
        ALUSrcA = 0;
        ALUSrcB = 1;
        
        //smaller4
        #50;
        readData1 = 1;
        readData2 = 2;
        ImExtend = 2;
        shamt = 1;
        ALUCtr = 3'b101;
        ALUSrcA = 1;
        ALUSrcB = 1;
        
        //bigger1
        #50;
        readData1 = 1;
        readData2 = 2;
        ImExtend = 2;
        shamt = 1;
        ALUCtr = 3'b110;
        ALUSrcA = 0;
        ALUSrcB = 0;
        
        //bigger2
        #50;
        readData1 = 1;
        readData2 = 2;
        ImExtend = 2;
        shamt = 1;
        ALUCtr = 3'b110;
        ALUSrcA = 1;
        ALUSrcB = 0;
        
        //bigger3
        #50;
        readData1 = 1;
        readData2 = 2;
        ImExtend = 2;
        shamt = 1;
        ALUCtr = 3'b110;
        ALUSrcA = 0;
        ALUSrcB = 1;
        
        //bigger4
        #50;
        readData1 = 1;
        readData2 = 2;
        ImExtend = 2;
        shamt = 1;
        ALUCtr = 3'b110;
        ALUSrcA = 1;
        ALUSrcB = 1;
        
        //xor1
        #50;
        readData1 = 1;
        readData2 = 2;
        ImExtend = 2;
        shamt = 1;
        ALUCtr = 3'b111;
        ALUSrcA = 0;
        ALUSrcB = 0;
        
        //xor2
        #50;
        readData1 = 1;
        readData2 = 2;
        ImExtend = 2;
        shamt = 1;
        ALUCtr = 3'b111;
        ALUSrcA = 1;
        ALUSrcB = 0;
        
        //xor3
        #50;
        readData1 = 1;
        readData2 = 2;
        ImExtend = 2;
        shamt = 1;
        ALUCtr = 3'b111;
        ALUSrcA = 0;
        ALUSrcB = 1;
        
        //xor4
        #50;
        readData1 = 1;
        readData2 = 2;
        ImExtend = 2;
        shamt = 1;
        ALUCtr = 3'b111;
        ALUSrcA = 1;
        ALUSrcB = 1;
        
        //stop
        #50;
        $stop;
    end
        
endmodule

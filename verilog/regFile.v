
/*
   CS/ECE 552, Fall '22
   Homework #3, Problem #1
  
   This module creates a 16-bit register.  It has 1 write port, 2 read
   ports, 3 register select inputs, a write enable, a reset, and a clock
   input.  All register state changes occur on the rising edge of the
   clock. 
*/
module regFile (
                // Outputs
                read1Data, read2Data, err,
                // Inputs
                clk, rst, read1RegSel, read2RegSel, writeRegSel, writeData, writeEn
                );

   input        clk, rst;
   input [2:0]  read1RegSel;
   input [2:0]  read2RegSel;
   input [2:0]  writeRegSel;
   input [15:0] writeData;
   input        writeEn;

   output [15:0] read1Data;
   output [15:0] read2Data;
   output        err;

   /* YOUR CODE HERE */
   reg [15:0] regfile [0:7];
   wire [15:0] saveWrite; 
   wire[2:0] num;
   wire writeEnSave ;
   reg [15:0] read1Save;
   reg [15:0] read2Save;

   //write data
   dff write [15:0] (saveWrite, writeData, clk, rst);
   dff saveseq [2:0] (num, writeRegSel, clk,rst);
   dff saveWriteEn (writeEnSave, writeEn, clk,rst);

      assign read1Data = regfile[read1RegSel];

      assign read2Data = regfile[read2RegSel];

	
   always @(*) begin
      regfile[num] = writeEnSave == 1 ?  saveWrite: regfile[num];
      case (rst)
            1: begin
            regfile[0] = 16'h0000;
            regfile[1] = 16'h0000;
            regfile[2] = 16'h0000;
            regfile[3] = 16'h0000;
            regfile[4] = 16'h0000;
            regfile[5] = 16'h0000;
            regfile[6] = 16'h0000;
            regfile[7] = 16'h0000;
            end
      endcase
      end
//read1Save = regfile[read1RegSel];
//read2Save = regfile[read2RegSel];

endmodule


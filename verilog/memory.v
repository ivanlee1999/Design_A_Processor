/*
   CS/ECE 552 Spring '20
  
   Filename        : memory.v
   Description     : This module contains all components in the Memory stage of the 
                     processor.
*/
module memory (
               memWriteEnable, memReadEnable,
               siic, nop,clk, rst, halt,
               R2Data, ALUOut,
               memoryOutData
                  );

   // TODO: Your code here

   input           memWriteEnable;
   input           memReadEnable;
   input           siic, nop;
   input           clk, rst;
   input           halt;
   input [15:0]    R2Data;
   input[15:0]     ALUOut;

   output[15:0]    memoryOutData;


   wire memEnable = memReadEnable | memWriteEnable;

   //read or write memory
   memory2c m(.data_out(memoryOutData), .data_in(R2Data), .addr(ALUOut), .enable(memEnable), .wr(memWriteEnable), .createdump(halt), .clk(clk), .rst(rst));
   // $display("test");
   // always@(clk) begin
   // if(memWriteEnable == 1'b1) begin
   //    $display("memory address %h  memoryWriteData : %h.",ALUOut, R2Data);
   //    $display("memoryOutData : %h, memReadEnable: %h, memWriteEnable: %h, halt: %h, clk: %h, rst: %h, memEnable: %h",
   //          memoryOutData, memReadEnable, memWriteEnable, halt, clk, rst, memEnable);
   // end
   // end

endmodule

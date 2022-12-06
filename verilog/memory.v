/*
   CS/ECE 552 Spring '20
  
   Filename        : memory.v
   Description     : This module contains all components in the Memory stage of the 
                     processor.
*/
module memory (//Input
               memWriteEnable, memReadEnable,
               siic, nop,clk, rst, halt,
               R2Data, ALUOut,
               //Output
               memoryOutData, memoryDone, memoryStall);

   // TODO: Your code here

   input           memWriteEnable;
   input           memReadEnable;
   input           siic, nop;
   input           clk, rst;
   input           halt;
   input [15:0]    R2Data;
   input[15:0]     ALUOut;

   output[15:0]    memoryOutData;
   output          memoryDone, memoryStall;


   wire memEnable = memReadEnable | memWriteEnable;

//   memory2c m(.data_out(memoryOutData), .data_in(R2Data), .addr(ALUOut), .enable(memEnable), .wr(memWriteEnable), .createdump(halt), .clk(clk), .rst(rst));

   mem_system mem (//Output
   		   .DataOut	(memoryOutData),
   		   .Done	(memoryDone),
   		   .Stall	(memoryStall),
   		   .CacheHit	(),
   		   .err		(),
   		   //Input
   		   .Addr	(ALUOut),
   		   .DataIn	(R2Data),
   		   .Rd		(memEnable),
   		   .Wr		(memWriteEnable),
   		   .createdump	(halt),
   		   .clk		(clk),
   		   .rst		(rst),
   		   );

endmodule

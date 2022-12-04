/*
   CS/ECE 552 Spring '20
  
   Filename        : wb.v
   Description     : This is the module for the overall Write Back stage of the processor.
*/
module wb (
            ALUOut, memoryOut, PC2, compareResult,
            regWriteDataSel,
            regWriteData
         );

   // TODO: Your code here
   input[15:0]   ALUOut, memoryOut, PC2;
   input         compareResult;
   input[1:0]    regWriteDataSel;

   output[15:0]  regWriteData; 


   // choose regWriteData
   //module mux4_1 (A, B, C, D, S, O );
   mux4_1 m1[15:0] (.A(ALUOut), .B(memoryOut), .C({15'h0000, compareResult}), .D(PC2), .S(regWriteDataSel[1:0]), .O(regWriteData));
   
endmodule

module MEMWB (memoryOut, ALUOut, PC2, compareResult, regWriteDataSel, clk, rst,
	      regWriteEnable, regWriteNum,halt, PCOut, PCCtr,J,
	      memoryOut_MW, ALUOut_MW, PC2_MW, compareResult_MW, regWriteDataSel_MW,
	      regWriteEnable_MW, regWriteNum_MW, halt_MW, PCOut_MW, PCCtr_MW, J_MW);
   
   input [15:0]      memoryOut;
   input [15:0]         ALUOut;
   input [15:0] 	   PC2;
   input 	 compareResult;
   input [1:0] regWriteDataSel;
   input              clk, rst;
   input        regWriteEnable;
   input [2:0]        regWriteNum;
   input             halt;
   input [15:0]        PCOut;
   input [1:0]       PCCtr;
   input             J;
   
   output [15:0]      memoryOut_MW;
   output [15:0]         ALUOut_MW;
   output [15:0] 	    PC2_MW;
   output 	  compareResult_MW;
   output [1:0] regWriteDataSel_MW;
   output        regWriteEnable_MW;
   output [2:0]        regWriteNum_MW;
   output               halt_MW;
   output [15:0]     PCOut_MW;
   output [1:0]     PCCtr_MW;
   output            J_MW;
   
   dff_16b memoryOutdff (memoryOut_MW, memoryOut, clk, rst);
   dff_16b ALUOutdff    (ALUOut_MW, ALUOut, clk, rst);
   dff_16b PC2dff       (PC2_MW, PC2, clk, rst);
   dff compareResultdff (compareResult_MW, compareResult, clk, rst);
   dff regWDSedff [1:0] (.q(regWriteDataSel_MW), .d(regWriteDataSel), 
   		      .clk(clk), .rst(rst));
   dff regWENabledff    (regWriteEnable_MW, regWriteEnable, clk, rst);
   dff regWritedff [2:0]       (.q(regWriteNum_MW), .d(regWriteNum), .clk(clk), .rst(rst));
   dff dffhaltdff (.q(halt_MW), .d(halt), .clk(clk), .rst(rst));
   dff passPCOutdff [15:0] (.q(PCOut_MW), .d(PCOut), .clk(clk), .rst(rst)); 
   dff passPCCtrdff [1:0] (PCCtr_MW, PCCtr, clk, rst);
   dff JDFF(J_MW, J, clk, rst);
   		      
endmodule

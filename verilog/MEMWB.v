module MEMWB (memoryOut, ALUOut, PC2, compareResult, regWriteDataSel, clk, rst,
	      regWriteEnable, regWriteNum,halt, PCOut, PCCtr,J,
	      memoryOut_MW, ALUOut_MW, PC2_MW, compareResult_MW, regWriteDataSel_MW,
	      regWriteEnable_MW, regWriteNum_MW, halt_MW, PCOut_MW, PCCtr_MW, J_MW, en, dataMemStall);
   
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
   input en;
   input dataMemStall;
   
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
   
   dffr memoryOutdff [15:0] (memoryOut_MW, memoryOut, en,clk, rst);
   dffr ALUOutdff  [15:0]  (ALUOut_MW, ALUOut, en,clk, rst);
   dffr PC2dff    [15:0]   (PC2_MW, PC2, en,clk, rst);
   dffr compareResultdff (compareResult_MW, compareResult,en, clk, rst);
   dffr regWDSedff [1:0] (.q(regWriteDataSel_MW), .d(regWriteDataSel), .en(en),
   		      .clk(clk), .rst(rst));
   dffr regWENabledff    (regWriteEnable_MW, (regWriteEnable & ~dataMemStall), en,clk, rst);
   dffr regWritedff [2:0]       (.q(regWriteNum_MW), .d(regWriteNum ), .en(en), .clk(clk), .rst(rst));
   dffr dffhaltdff (.q(halt_MW), .d(halt), .en(en), .clk(clk), .rst(rst));
   dffr passPCOutdff [15:0] (.q(PCOut_MW), .d(PCOut),.en(en), .clk(clk), .rst(rst)); 
   dffr passPCCtrdff [1:0] (PCCtr_MW, PCCtr,en, clk, rst);
   dffr JDFF(J_MW, J, en,clk, rst);
   		      
endmodule

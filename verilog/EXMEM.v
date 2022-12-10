module EXMEM (//input
	      ALUOut, compareResult, PC2, regWriteDataSel, memWriteEnable,
	      memReadEnable, clk, rst, halt, R2Data, siic,nop, regWriteNum, regWriteEnable_in, PCOut, PCCtr,J,
              //output
              ALUOut_EM, compareResult_EM, PC2_EM, regWriteDataSel_EM,
              memWriteEnable_EM, memReadEnable_EM, halt_EM,
              R2Data_EM, siic_EM, nop_EM,regWriteNum_EM, regWriteEnable_out, PCOut_EM, PCCtr_EM, J_EM, en);
   
   input [15:0]         ALUOut;
   input         compareResult;
   input [15:0]            PC2;
   input [1:0] regWriteDataSel;
   input 	memWriteEnable;
   input 	 memReadEnable;
   input 	clk, rst, halt;
   input [15:0] 	R2Data;
   input             siic, nop;
   input [2:0]        regWriteNum;
   input     regWriteEnable_in;
   input [15:0] PCOut;
   input [1:0] PCCtr;
   input J;
   input en;
   
   //input        regWriteENable;
   //input [1:0]  regwriteRegSel;
   //input [1:0]       PCControl;
   //input [1:0] CompareSig;
   //input J;
   //input [1:0] BranchSig;
   //input [15:0]       PC2I;
   //input [15:0] PC2D;
   //input [15:0] PCSI;
    
   output [15:0]         ALUOut_EM;
   output         compareResult_EM;
   output [15:0]            PC2_EM;
   output [1:0] regWriteDataSel_EM;
   output 	 memWriteEnable_EM;
   output 	  memReadEnable_EM;
   output 	 	   halt_EM;
   output [15:0]       	 R2Data_EM;
   output          siic_EM, nop_EM;
   output [2:0]        regWriteNum_EM;
   output       regWriteEnable_out;
   output [15:0]    PCOut_EM;
   output [1:0]   PCCtr_EM;
   output J_EM;
   
   dffr ALUOutdff[15:0]    (ALUOut_EM, ALUOut, en, clk, rst);
   dffr compareResultdff (compareResult_EM, compareResult, en, clk, rst);
   dffr PC2dff  [15:0]  (PC2_EM, PC2,en, clk, rst);
   dffr regWDSeldff [1:0] (.q(regWriteDataSel_EM), .d(regWriteDataSel), .en(en),
   		      .clk(clk), .rst(rst));
   dffr memWriteEnabledff (memWriteEnable_EM, memWriteEnable,en, clk, rst);
   dffr memReadEnabledff (memReadEnable_EM, memReadEnable, en,clk, rst);
   dffr haltdff (halt_EM, halt, en,clk, rst);
   dffr R2Datadff [15:0] (R2Data_EM, R2Data, en,clk, rst);
   dffr siicdff (siic_EM, siic, en,clk, rst);
   dffr nopdff (nop_EM, nop,en, clk, rst);
   dffr regWritedff [2:0] (regWriteNum_EM, regWriteNum, en,clk, rst);
   dffr regWriteEnabledff (regWriteEnable_out, (regWriteEnable_in), en,clk, rst);
   dffr passPCOutdff [15:0] (PCOut_EM, PCOut, en,clk, rst);
   dffr passPCCtrdff [1:0] (PCCtr_EM, PCCtr, en,clk, rst);
   dffr Jdff (J_EM, J, en,clk, rst);
   	      
endmodule	      

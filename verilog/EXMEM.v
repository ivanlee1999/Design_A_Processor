module EXMEM (//input
	      ALUOut, compareResult, PC2, regWriteDataSel, memWriteEnable,
	      memReadEnable, clk, rst, halt, R2Data, siic,nop, regWriteNum, regWriteEnable_in, PCOut, PCCtr,J,
              //output
              ALUOut_EM, compareResult_EM, PC2_EM, regWriteDataSel_EM,
              memWriteEnable_EM, memReadEnable_EM, halt_EM,
              R2Data_EM, siic_EM, nop_EM,regWriteNum_EM, regWriteEnable_out, PCOut_EM, PCCtr_EM, J_EM);
   
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
   
   dff_16b ALUOutdff    (ALUOut_EM, ALUOut, clk, rst);
   dff compareResultdff (compareResult_EM, compareResult, clk, rst);
   dff_16b PC2dff       (PC2_EM, PC2, clk, rst);
   dff regWDSeldff [1:0] (.q(regWriteDataSel_EM), .d(regWriteDataSel), 
   		      .clk(clk), .rst(rst));
   dff memWriteEnabledff (memWriteEnable_EM, memWriteEnable, clk, rst);
   dff memReadEnabledff (memReadEnable_EM, memReadEnable, clk, rst);
   dff haltdff (halt_EM, halt, clk, rst);
   dff_16b R2Datadff (R2Data_EM, R2Data, clk, rst);
   dff siicdff (siic_EM, siic, clk, rst);
   dff nopdff (nop_EM, nop, clk, rst);
   dff regWritedff [2:0] (regWriteNum_EM, regWriteNum, clk, rst);
   dff regWriteEnabledff (regWriteEnable_out, regWriteEnable_in, clk, rst);
   dff passPCOutdff [15:0] (PCOut_EM, PCOut, clk, rst);
   dff passPCCtrdff [1:0] (PCCtr_EM, PCCtr, clk, rst);
   dff Jdff (J_EM, J, clk, rst);
   	      
endmodule	      

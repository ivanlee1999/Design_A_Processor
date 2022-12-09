/* $Author: sinclair $ */
/* $LastChangedDate: 2020-02-09 17:03:45 -0600 (Sun, 09 Feb 2020) $ */
/* $Rev: 46 $ */
module proc (/*AUTOARG*/
   // Outputs
   err, 
   // Inputs
   clk, rst
   );

   input clk;
   input rst;

   output err;

   // None of the above lines can be modified

   // OR all the err ouputs for every sub-module and assign it as this
   // err output
   
   // As desribed in the homeworks, use the err signal to trap corner
   // cases that you think are illegal in your statemachines
   
   
   /* your code here -- should include instantiations of fetch, decode, execute, mem and wb modules */
   wire halt, clk, rst;
   wire [15:0] PCOut, newPC, PC2;
   wire [15:0] instr;
   wire [15:0] regWriteData;
   wire [15:0] R1Data, R2Data;
   wire [15:0] I5, I8, D;
   wire [1:0]  regWriteDataSel;
   wire inv1, inv2, cin;
   wire[1:0] ALU1Sel, ALU2Sel;
   wire[2:0] ALUOp;
   wire memWriteEnable, memReadEnable;
   wire [1:0] PCCtr;
   wire J;
   wire siic, nop;
   wire [1:0] compareSig, branchSig;
   wire[15:0] ALUOut;
   wire compareResult;
   wire [15:0] memoryOut;
   wire [2:0] regWriteNum;

   wire RWEN;
   //IFID
   wire [15:0] instr_ID;
   wire [15:0] newPC_ID;
   wire [15:0] PC2_ID;
   //IDEX
   wire halt_EX;
   wire inv1_EX, inv2_EX, cin_EX;
   wire [1:0] ALU1Sel_EX, ALU2Sel_EX;
   wire [2:0] ALUOp_EX;
   wire memWriteEnable_EX;
   wire memReadEnable_EX;
   wire [1:0] PCCtr_EX;
   wire J_EX;
   wire siic_EX, nop_EX;
   wire [15:0] I5_EX, I8_EX, D_EX;
   wire [15:0] R1Data_EX;
   wire [15:0] R2Data_EX;
   wire [1:0] regWriteDataSel_EX;
   wire [1:0] compareSig_EX, branchSig_EX;
   wire [2:0] regWriteNum_EX;
   wire [15:0] newPC_EX;
   wire [15:0] PC2_EX;
   wire RWEN_EX;
   //EXMEM
   wire [15:0] ALUOut_EM;
   wire compareResult_EM;
   wire [15:0] PC2_EM;
   wire [1:0] regWriteDataSel_EM;
   wire memWriteEnable_EM;
   wire memReadEnable_EM;
   wire halt_EM;
   wire [15:0] R2Data_EM;
   wire siic_EM, nop_EM;
   wire [2:0] regWriteNum_EM;
   wire RWEN_EM;
   wire [15:0] PCOut_EM;
   wire [1:0] PCCtr_EM;
   wire J_EM;
   //MEMWB
   wire [15:0] memoryOut_WB;
   wire [15:0] ALUOut_WB;
   wire [15:0] PC2_WB;
   wire compareResult_WB;
   wire [1:0] regWriteDataSel_WB;
   wire regWriteEnable_WB;
   wire [2:0] regWriteNum_WB;
   wire RWEN_WB;
   wire halt_MW;
   wire [15:0] PCOut_MW;
   wire [1:0] PCCtr_MW;
   wire J_MW;


   wire stall;
   wire branchStall;
   wire [15:0]  PCStall;

      wire [1:0] PCCtr_End;
   wire [15:0] PCOut_End;


   wire [2:0]   r1Num_EX, r2Num_EX;


   fetch fetch0(   
      .PCin(PCStall),
      .halt(halt_MW), //need change
      .clk(clk),
      .rst(rst),
      .newPC(newPC),
      .PC2(PC2),
      .instrct(instr),
      .stall(stall),
      .PCCtr(PCCtr_EM),
      .branchStall(branchStall),
      .PCOut(PCOut_EM),
      .J(J_EM)
      );


   // always@(negedge clk) begin
   //    // $display("A: %b, Op: %b, Inv: %b", 
   //    // A, Op, Inv);
   //  $display("instr : %b", instr);
   //  $display("instr id : %b", instr_ID);
   //  $display("instr stall : %b", instrStall);
   //  $display("stall: %h", stall);
   //  $display("branchStall: %h", branchStall);
   // //  $display("branch : %h", PCCtr);
   // //  $display("branchEX : %h", PCCtr_EX);
   // //  $display("branchEM : %h", PCCtr_EM);
   // //  $display("branchWB : %h", PCCtr_MW); 
   // //  $display("fetch0 : newPC: %d, PC2: %d", newPC, PC2);
   // //  $display("PCStall: %d", PCStall);
   // //  $display("PCOut : %d", PCOut); 
   // //  $display("D : %b", D_EX); 
   // //  $display("halt : %b", halt_MW); 
   // //  $display("PC_temp : %d", fetch0.PC_temp); 
   // //  $display("R2Data : %h", R2Data_EM);
   //  $display("regwriteNum: ID : %h,  EX : %h, EM : %h, WB : %h", regWriteNum, regWriteNum_EX, regWriteNum_EM, regWriteNum_WB);
   //  $display("R1Num_EX : %h, R2Num_EX : %h", r1Num_EX, r2Num_EX);
   //  $display("memWriteEnable_EM: %h", memWriteEnable_EM);
   //  $display("forward signal 1 : %b", forward_a);
   //  $display("forward signal 2 : %b", forward_b);
   //  $display("original data 1 : %b", R1Data_EX);
   //  $display("original data 2 : %b", R2Data_EX);
   //  $display("forward data 1 : %b", forwardR1Data);
   //  $display("forward data 2 : %b", forwardR2Data);
   //  $display("jump: %b, branch: %b", hazard0.jump, hazard0.branch);
   //  $display("ALUOut_EX: %b, AluOut_EM: %b, ALUout_MW: %b", ALUOut, ALUOut_EM, ALUOut_WB);
   //   $display("regWriteDataSel_EM: %b,  regWriteDataSel_MW: %b", regWriteDataSel_EM, regWriteDataSel_WB);
   //  $display("PCCTR: %b, PCCtr_EX: %b, PCCtr_EM: %b, PCCtr_MW: %b", PCCtr, PCCtr_EX, PCCtr_EM, PCCtr_MW);
    

   //  $display("");
   // end
      
   IFID ifid0(
      .instrct_in(instr),
      .instrct_out(instr_ID),
      .newPC_in(newPC),
      .newPC_out(newPC_ID),
      .PC2_in(PC2),
      .PC2_out(PC2_ID),
      .clk(clk),
      .rst(rst));


  //always@(negedge clk) begin
    //   $display("A: %b, Op: %b, Inv: %b", 
    //   A, Op, Inv);
   //  $display("instr %h", instr_ID);
   //  $display("PCin %h", PCOut_MW);
   //  $display("IFID : newPC: %h, PC2: %h", newPC_ID, PC2_ID);
   //  $display("halt %d", halt);
   //end

   wire hazard_stall;
   hazard_stall hazardStall(
         .instr(instr), 
         .memWriteEnable_EX(memWriteEnable), 
         .memReadEnable_EX(memReadEnable), 
         .regWriteNum_EX(regWriteNum), 
         .hazard(hazard_stall)
      );

   wire[1:0] forward_a, forward_b;

   hazard_forward hazard0 (
      .regWriteNum_EXMEM(regWriteNum_EM),
      .regWriteNum_MEMWB(regWriteNum_WB),
      .regWriteEnable_EXMEM(RWEN_EM),
      .regWriteEnable_MEMWB(RWEN_WB),
      .J(J), .J_EX(J_EX), .J_EM(J_EM), .J_MW(J_MW),
      .PCCtr(PCCtr), .PCCtr_EX(PCCtr_EX), .PCCtr_EM(PCCtr_EM), .PCCtr_MW(PCCtr_MW),
      .branchStall(branchStall),
      .r1Num_EX(r1Num_EX), .r2Num_EX(r2Num_EX),
      .ALU1Sel_EX(ALU1Sel_EX), .ALU2Sel_EX(ALU2Sel_EX),
      .forward_a(forward_a), .forward_b(forward_b));


   assign stall = hazard_stall | branchStall;


   wire [15:0] forwardR1Data, forwardR2Data;
   forward_alu fa(
      .forward_a(forward_a), .forward_b(forward_b), 
      .originalR1Data(R1Data_EX), .originalR2Data(R2Data_EX),
      .ALUOut_EM(ALUOut_EM), .ALUOut_MW(ALUOut_WB),
      .memoryOut(memoryOut), .memoryOut_WB(memoryOut_WB),
      .PC2_EM(PC2_EM), .PC2_WB(PC2_WB),
      .compareResult_EM(compareResult_EM), .compareResult_WB(compareResult_WB),
      .regWriteDataSel_EM(regWriteDataSel_EM), .regWriteDataSel_WB(regWriteDataSel_WB),
      .forwardR1Data(forwardR1Data), .forwardR2Data(forwardR2Data)
   );


   
   wire stallNext;
   dff dffstall(stallNext, stall, clk, rst);

   wire [15:0] instrStall;
   // assign instrStall = (branchStall == 1'b1) ?   16'h0800 : (stallNext) ? 16'h0800 : instr_ID;
   assign instrStall = (stallNext) ? 16'h0800 : instr_ID;
   // assign instrStall = instr_ID;



   wire [2:0]   r1Num, r2Num;
   decode decode0(
      .instr(instrStall), .clk(clk), .rst(rst),
      .WBData(regWriteData),
      .R1Data(R1Data), .R2Data(R2Data), 
      .I5(I5), .I8(I8), .D(D),
      .halt(halt),
      .regWriteDataSel(regWriteDataSel),
      .inv1(inv1), .inv2(inv2), .cin(cin), 
      .ALU1Sel(ALU1Sel), .ALU2Sel(ALU2Sel), .ALUOp(ALUOp),
      .memWriteEnable(memWriteEnable), .memReadEnable(memReadEnable),
      .PCCtr(PCCtr), .J(J), 
      .siic(siic), .nop(nop),
      .compareSig(compareSig), .branchSig(branchSig),
      .regWriteNum_in(regWriteNum_WB), .regWriteEN_in(RWEN_WB),
      .regWriteNum_out(regWriteNum), .regWriteEnable_out(RWEN),
      .r1Num(r1Num), .r2Num(r2Num)
      // .regWriteNum(regWriteSel)
      //  .regWriteSel(regWriteSel_WB),//check
      // .regWriteEN(RWEN_WB),//check     .regWriteEnable(RWEN)           
   );

   wire branch;
   


   IDEX idex0 (
      .halt_in(halt), .halt_out(halt_EX),
      .inv1_in(inv1), .inv2_in(inv2), .cin_in(cin),
      .inv1_out(inv1_EX), .inv2_out(inv2_EX), .cin_out(cin_EX),
      .ALU1Sel_in(ALU1Sel),
      .ALU1Sel_out(ALU1Sel_EX),
      .ALU2Sel_in(ALU2Sel),
      .ALU2Sel_out(ALU2Sel_EX),
      .ALUOp_in(ALUOp), .ALUOp_out(ALUOp_EX),
      .memWriteEnable_in(memWriteEnable),
      .memWriteEnable_out(memWriteEnable_EX),
      .memReadEnable_in(memReadEnable),
      .memReadEnable_out(memReadEnable_EX),
      .PCCtr_in(PCCtr), .PCCtr_out(PCCtr_EX),
      .J_in(J), .J_out(J_EX),
      .siic_in(siic), .siic_out(siic_EX),
      .nop_in(nop), .nop_out(nop_EX),
      .I5_in(I5), .I8_in(I8), .D_in(D),
      .I5_out(I5_EX), .I8_out(I8_EX), .D_out(D_EX),
      .R1Data_in(R1Data), .R1Data_out(R1Data_EX), 
      .R2Data_in(R2Data), .R2Data_out(R2Data_EX),
      .regWriteDataSel_in(regWriteDataSel),
      .regWriteDataSel_out(regWriteDataSel_EX), 
      .compareSig_in(compareSig), .branchSig_in(branchSig),
      .compareSig_out(compareSig_EX), .branchSig_out(branchSig_EX),
      .regWriteNum_in(regWriteNum), .regWriteNum_out(regWriteNum_EX),
      .clk(clk), .rst(rst),
      .newPC_in(newPC_ID), .newPC_out(newPC_EX),
      .PC2_in(PC2_ID), .PC2_out(PC2_EX),
      .regWriteEnable_in(RWEN), .regWriteEnable_out(RWEN_EX),
      .r1Num_in(r1Num), .r1Num_out(r1Num_EX),
      .r2Num_in(r2Num), .r2Num_out(r2Num_EX));





      







   execute executeModule(
      .R1Data(forwardR1Data), .R2Data(forwardR2Data), 
      .I5(I5_EX), .I8(I8_EX), .D(D_EX), 
      .halt(halt_EX), 
      .inv1(inv1_EX), .inv2(inv2_EX), .cin(cin_EX), 
      .ALU1Sel(ALU1Sel_EX), .ALU2Sel(ALU2Sel_EX), .ALUOp(ALUOp_EX),
      .PCCtr(PCCtr_EX), .J(J_EX),
      .PC(newPC), .PC2(PC2),
      .siic(siic_EX), .nop(nopEX),
      .compareSig(compareSig_EX), .branchSig(branchSig_EX),
      .ALUOut(ALUOut), .compareResult(compareResult), .PCOut(PCOut)
   );
   


   dff dffPCCTREND [1:0] (PCCtr_End, PCCtr_MW, clk, rst);
   dff dffPCCTREND2 [15:0] (PCOut_End, PCOut_MW, clk, rst);
   

   assign PCStall = stall ? newPC : PCOut;
   // assign PCStall = (PCCtr_End == 2'b01)? PCOut_End : (stall ? newPC : PCOut);
   // assign PCStall = (PCCtr_MW == 2'b01)? PCOut_MW : (stall ? newPC : PCOut);

   EXMEM exmem0(
      //input
      .ALUOut(ALUOut),
      .compareResult(compareResult),
      .PC2(PC2_EX),
      .regWriteDataSel(regWriteDataSel_EX),
      .memWriteEnable(memWriteEnable_EX),
      .memReadEnable(memReadEnable_EX),
      .clk(clk), .rst(rst), .halt(halt_EX),
      .R2Data(forwardR2Data),                                //r2 data should be from forwarding
      .siic(siic_EX), .nop(nop_EX),
      .regWriteNum(regWriteNum_EX),
      .regWriteEnable_in(RWEN_EX),
      .PCOut(PCOut),
      .PCCtr(PCCtr_EX),
      .J(J_EX),
      //output
      .ALUOut_EM(ALUOut_EM),
      .compareResult_EM(compareResult_EM),
      .PC2_EM(PC2_EM),
      .regWriteDataSel_EM(regWriteDataSel_EM),
      .memWriteEnable_EM(memWriteEnable_EM),
      .memReadEnable_EM(memReadEnable_EM),
      .halt_EM(halt_EM),
      .R2Data_EM(R2Data_EM),
      .siic_EM(siic_EM), .nop_EM(nop_EM),
      .regWriteNum_EM(regWriteNum_EM),
      .regWriteEnable_out(RWEN_EM),
      .PCOut_EM(PCOut_EM),
      .PCCtr_EM(PCCtr_EM),
      .J_EM(J_EM)
      );

   memory memory0(
      .memWriteEnable(memWriteEnable_EM), .memReadEnable(memReadEnable_EM),
      .siic(siic_EM), .nop(nop_EM), .clk(clk), .rst(rst), .halt(halt_EM), 
      .R2Data(R2Data_EM), .ALUOut(ALUOut_EM),
      .memoryOutData(memoryOut)
   );

   MEMWB memwb0 (
      //input
      .memoryOut(memoryOut),
      .ALUOut(ALUOut_EM),
      .PC2(PC2_EM),
      .compareResult(compareResult_EM),
      .regWriteDataSel(regWriteDataSel_EM),
      .clk(clk), .rst(rst),
      .regWriteEnable(RWEN_EM),
      .regWriteNum(regWriteNum_EM),
      .halt(halt_EM),
      .PCOut(PCOut_EM),
      .PCCtr(PCCtr_EM),
      .J(J_EM),
      //output
      .memoryOut_MW(memoryOut_WB),
      .ALUOut_MW(ALUOut_WB),
      .PC2_MW(PC2_WB),
      .compareResult_MW(compareResult_WB),
      .regWriteDataSel_MW(regWriteDataSel_WB),
      .regWriteEnable_MW(RWEN_WB),
      .regWriteNum_MW(regWriteNum_WB),
      .halt_MW(halt_MW),
      .PCOut_MW(PCOut_MW),
      .PCCtr_MW(PCCtr_MW),
      .J_MW(J_MW)
      );

   wb wbModule(
      .ALUOut(ALUOut_WB), .memoryOut(memoryOut_WB), .PC2(PC2_WB), 
      .compareResult(compareResult_WB),
      .regWriteDataSel(regWriteDataSel_WB),
      .regWriteData(regWriteData)
   );
   
endmodule // proc
// DUMMY LINE FOR REV CONTROL :0:

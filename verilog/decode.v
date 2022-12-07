/*
   CS/ECE 552 Spring '20
  
   Filename        : decode.v
   Description     : This is the module for the overall decode stage of the processor.
*/
module decode (instr, clk, rst, WBData, 
               R1Data, R2Data, 
               I5, I8, D,
               halt,
               regWriteDataSel,
               inv1, inv2, cin, 
               ALU1Sel, ALU2Sel, ALUOp,
               memWriteEnable, memReadEnable,
               PCCtr, J,siic, nop,
               compareSig, branchSig,
               regWriteNum_in, regWriteEN_in,
               regWriteNum_out, regWriteEnable_out,
               r1Num, r2Num
               );

input clk, rst;
input [15:0] instr;
input[15:0] WBData;
input [2:0] regWriteNum_in;//check
input       regWriteEN_in;//check

output         halt;
output         inv1, inv2, cin;
output[1:0]    ALU1Sel;
output[1:0]    ALU2Sel;
output[2:0]    ALUOp;
output         memWriteEnable;
output         memReadEnable;
output[1:0]    PCCtr;
output         J;
output         siic, nop;

output[15:0]    I5, I8, D;
output[15:0]    R1Data;
output[15:0]    R2Data;
output[1:0]    regWriteDataSel;
output[1:0]    compareSig, branchSig;
output[2:0]    regWriteNum_out; //check
output         regWriteEnable_out; //check

output [2:0]   r1Num, r2Num;

wire[1:0]    regWriteRegSel;
wire         signExtend;
//wire[2:0]    regWriteNum;
wire         err;

//Control Signal
control CtrSignal (
    instr, regWriteEnable_out, regWriteRegSel, regWriteDataSel, 
    inv1, inv2, cin, signExtend, ALU1Sel, ALU2Sel, ALUOp, 
    memWriteEnable, memReadEnable, PCCtr, J, siic, nop, 
    compareSig, branchSig, halt);



//choose regWrite
// module mux4_1_3b (
//     A, B, C, D, S, O
// );
mux4_1_3b m1(instr[7:5], instr[10:8], 3'b111, instr[4:2], regWriteRegSel, regWriteNum_out);

assign r2Num = instr[7:5];
assign r1Num = instr[10:8];



// module regFile (
//                 // Outputs
//                 read1Data, read2Data, err,
//                 // Inputs
//                 clk, rst, read1RegSel, read2RegSel, writeRegSel, writeData, writeEn
//                 );
regFile_bypass regFile0(.read1Data(R1Data), .read2Data(R2Data), .err(err), .clk(clk), .rst(rst), 
            .read1RegSel(instr[10:8]), .read2RegSel(instr[7:5]), 
            .writeRegSel(regWriteNum_in), .writeData(WBData), .writeEn(regWriteEN_in));



//extension
assign I5 = signExtend == 1'b0 ? {{11{1'b0}}, instr[4:0]} : {{11{instr[4]}}, instr[4:0]};
assign I8 = signExtend == 1'b0 ? {{8{1'b0}}, instr[7:0]} : {{8{instr[7]}}, instr[7:0]};
assign D = signExtend == 1'b0 ? {{5{1'b0}}, instr[10:0]} : {{5{instr[10]}}, instr[10:0]};




endmodule

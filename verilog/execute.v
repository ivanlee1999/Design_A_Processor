 /*
   CS/ECE 552 Spring '20
  
   Filename        : execute.v
   Description     : This is the overall module for the execute stage of the processor.
*/
module execute (
                  R1Data, R2Data, 
                  I5, I8, D, 
                  halt, 
                  inv1, inv2, cin, 
                  ALU1Sel, ALU2Sel, ALUOp,
                  PCCtr, J,PC, PC2,
                  siic, nop,
                  compareSig, branchSig,
                  ALUOut, compareResult, PCOut
                  );

   // TODO: Your code here
input[15:0] R1Data;
input[15:0] R2Data;
input[15:0] I5, I8, D;
input         halt;
input         inv1, inv2, cin;
input[1:0]    ALU1Sel;
input[1:0]    ALU2Sel;
input[2:0]    ALUOp;
input[1:0]    PCCtr;
input         J;
input         siic, nop;
input[1:0]    compareSig, branchSig;

input[15:0]     PC, PC2;

output[15:0] ALUOut;
output compareResult;
output [15:0] PCOut;

wire R1Inv, R2Inv;
wire R1BTR;
wire [15:0] Rs8, RsBTR;
wire [15:0] ALUIn1, ALUIn2;
wire [15:0] PC2I;
wire [15:0] PC2D;
wire [15:0] PCSI;
wire branchResult;
wire[15:0] PCCalc;
wire zero, ofl;
wire cout;



//Select ALU input1
// assign Rs8 = R1Data << 8;
assign Rs8 = {R1Data[7:0], 8'h00};
//btr
assign RsBTR = {R1Data[0], R1Data[1], R1Data[2], R1Data[3], R1Data[4], R1Data[5], R1Data[6], R1Data[7],
	         R1Data[8], R1Data[9], R1Data[10], R1Data[11], R1Data[12], R1Data[13], R1Data[14], R1Data[15]};

//Select ALU input1
mux4_1  m1[15:0](.A(R1Data), .B(16'h0000), .C(Rs8), .D(RsBTR), .S(ALU1Sel[1:0]), .O(ALUIn1));

//Select ALU input2
mux4_1 m2[15:0](.A(R2Data), .B(I5), .C(16'h0000), .D(I8), .S(ALU2Sel[1:0]), .O(ALUIn2));

//Select ALU input1,2 after forwarding
//ALUIn1 = (stall_rs_ex) ?  ALUOut_EM : (stall_rs_mem) ? mempryOut_WB : ALUIn1;
//ALUIn2 = (stall_rd_ex) ?  ALUOut_EM : (stall_rd_mem) ? mempryOut_WB : ALUIn2;
	
//ALU calculate
//module alu (InA, InB, Cin, Oper, invA, invB, sign, Out, Zero, Ofl);
alu alu1(.InA(ALUIn1), .InB(ALUIn2), .Cin(cin), .Oper(ALUOp), 
            .invA(inv1), .invB(inv2), .sign(1'b1), .Out(ALUOut), .Zero(zero), .Ofl(ofl));


//compare
wire less;
assign less = (ALUIn1[15] & ~ALUIn2[15]) | (ALUIn1[15] & ALUIn2[15] & ALUOut[15]) | (~ALUIn1[15] & ~ALUIn2[15] & ALUOut[15]);
assign compareResult = (compareSig == 2'b00) ? zero:     // ==
                       (compareSig == 2'b01) ? less :  // <
                       (compareSig == 2'b10) ? less | (zero & ~ofl)  :  // <=
                       (compareSig == 2'b11) ? alu1.add1.c_out :1'b0;       //<< cary
 
assign branchResult = (branchSig == 2'b00) ? zero:       // ==
                      (branchSig == 2'b01) ? ~zero:     // !=
                      (branchSig == 2'b10) ? ALUOut[15]:  // <
                      (branchSig == 2'b11) ? ((~ALUOut[15]) | zero) : 1'b0;  // >=
   
//calculate PC
alu alu2(.InA(PC2), .InB(I8), .Cin(1'b0), .Oper(3'b100), .invA(1'b0), .invB(1'b0), .sign(1'b1), .Out(PC2I), .Zero(), .Ofl());
alu alu3(.InA(PC2), .InB(D), .Cin(1'b0), .Oper(3'b100), .invA(1'b0), .invB(1'b0), .sign(1'b1), .Out(PC2D), .Zero(), .Ofl());
alu alu4(.InA(R1Data), .InB(I8), .Cin(1'b0), .Oper(3'b100), .invA(1'b0), .invB(1'b0), .sign(1'b1), .Out(PCSI), .Zero(), .Ofl());

//update PC
mux4_1 m3[15:0] (.A(PC2), .B(PC2I), .C(PC2D), .D(PCSI), .S(PCCtr[1:0]), .O(PCCalc));
assign PCOut = (halt == 1'b1) ? PC : 
               (PCCtr == 2'b00) ? PC2 :   
               (branchResult | J) == 1'b1 ? PCCalc : PC2;

// always@(negedge clk) begin
//    if(memWriteEnable == 1'b1) begin
//       $display("memory address %h .", ALUOut);
//    end
// end

endmodule

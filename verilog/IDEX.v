module IDEX (
	halt_in,           
	halt_out,
	inv1_in, inv2_in, cin_in,
	inv1_out, inv2_out, cin_out, 
	ALU1Sel_in,   
	ALU1Sel_out,
	ALU2Sel_in,
	ALU2Sel_out,
	ALUOp_in,
	ALUOp_out,
	memWriteEnable_in,
	memWriteEnable_out,
	memReadEnable_in,
	memReadEnable_out,
	PCCtr_in,
	PCCtr_out,
	J_in,
	J_out,
	siic_in, nop_in,
	siic_out, nop_out,
	I5_in, I8_in, D_in,
	I5_out, I8_out, D_out,
	R1Data_in,
	R1Data_out,
	R2Data_in,
	R2Data_out,
	regWriteDataSel_in,
	regWriteDataSel_out,
	compareSig_in, branchSig_in,
	compareSig_out, branchSig_out,
	regWriteNum_in, regWriteNum_out,
	clk, rst,
	newPC_in, newPC_out,
	PC2_in, PC2_out,
	regWriteEnable_in, regWriteEnable_out,
	r1Num_in, r2Num_in,
	r1Num_out, r2Num_out);

	input         clk, rst;
	input         halt_in;
	input         inv1_in, inv2_in, cin_in;
	input[1:0]    ALU1Sel_in;
	input[1:0]    ALU2Sel_in;
	input[2:0]    ALUOp_in;
	input         memWriteEnable_in;
	input         memReadEnable_in;
	input[1:0]    PCCtr_in;
	input         J_in;
	input         siic_in, nop_in;
	input[15:0]    I5_in , I8_in, D_in;
	input[15:0]    R1Data_in;
	input[15:0]    R2Data_in;
	input[1:0]     regWriteDataSel_in;
	input[1:0]     compareSig_in, branchSig_in;
	input[2:0]     regWriteNum_in;
	
	input[15:0]    newPC_in;//check
	input[15:0]    PC2_in;//check
	input          regWriteEnable_in;

	input[2:0]     r1Num_in, r2Num_in;

	output         halt_out;
	output         inv1_out, inv2_out, cin_out;
	output[1:0]    ALU1Sel_out;
	output[1:0]    ALU2Sel_out;
	output[2:0]    ALUOp_out;
	output         memWriteEnable_out;
	output         memReadEnable_out;
	output[1:0]    PCCtr_out;
	output         J_out;
	output         siic_out, nop_out;
	output[15:0]   I5_out, I8_out, D_out;
	output[15:0]   R1Data_out;
	output[15:0]   R2Data_out;
	output[1:0]    regWriteDataSel_out;
	output[1:0]    compareSig_out, branchSig_out;
	output[2:0]    regWriteNum_out;
	
	output[15:0]   newPC_out;//check
	output[15:0]   PC2_out;//check
	output         regWriteEnable_out;


	output[2:0]    r1Num_out, r2Num_out;


	dff d0 (.q(), .d(), .clk(clk), .rst(rst));

	dff d1(.q(halt_out), .d(halt_in), .clk(clk), .rst(rst));
	dff d2(.q(inv1_out), .d(inv1_in), .clk(clk), .rst(rst));
	dff d3(.q(inv2_out), .d(inv2_in), .clk(clk), .rst(rst));
	dff d4(.q(cin_out), .d(cin_in), .clk(clk), .rst(rst));
	dff d5[1:0] (.q(ALU1Sel_out), .d(ALU1Sel_in), .clk(clk), .rst(rst));
	dff d6[1:0] (.q(ALU2Sel_out), .d(ALU2Sel_in), .clk(clk), .rst(rst));
	dff d7[2:0] (.q(ALUOp_out), .d(ALUOp_in), .clk(clk), .rst(rst));
	dff d8(.q(memWriteEnable_out), .d(memWriteEnable_in), .clk(clk), .rst(rst));
	dff d9(.q(memReadEnable_out), .d(memReadEnable_in), .clk(clk), .rst(rst));
	dff d10[1:0] (.q(PCCtr_out), .d(PCCtr_in), .clk(clk), .rst(rst));
	dff d11 (.q(J_out), .d(J_in), .clk(clk), .rst(rst));
	dff d12 (.q(siic_out), .d(siic_in), .clk(clk), .rst(rst));
	dff d13 (.q(nop_out), .d(nop_in), .clk(clk), .rst(rst));
	dff d14[15:0] (.q(I5_out), .d(I5_in), .clk(clk), .rst(rst));
	dff d15[15:0] (.q(I8_out), .d(I8_in), .clk(clk), .rst(rst));
	dff d16[15:0] (.q(D_out), .d(D_in), .clk(clk), .rst(rst));
	dff d17[15:0] (.q(R1Data_out), .d(R1Data_in), .clk(clk), .rst(rst));
	dff d18[15:0] (.q(R2Data_out), .d(R2Data_in), .clk(clk), .rst(rst));
	dff d19[1:0] (.q(regWriteDataSel_out), .d(regWriteDataSel_in), .clk(clk), 
	.rst(rst));
	dff d20[1:0] (.q(compareSig_out), .d(compareSig_in), .clk(clk), .rst(rst));
	dff d21[1:0] (.q(branchSig_out), .d(branchSig_in), .clk(clk), .rst(rst));
	dff d22[2:0] (.q(regWriteNum_out), .d(regWriteNum_in), .clk(clk), .rst(rst));
        dff_16b d23  (.q(newPC_out), .d(newPC_in), .clk(clk), .rst(rst));
        dff_16b d24  (.q(PC2_out), .d(PC2_in), .clk(clk), .rst(rst));
        dff d25 (.q(regWriteEnable_out), .d(regWriteEnable_in), .clk(clk), .rst(rst));



	dff d26[2:0] (.q(r1Num_out), .d(r1Num), .clk(clk), .rst(rst));
	dff d27[2:0] (.q(r2Num_out), .d(r2Num), .clk(clk), .rst(rst));	
        
endmodule

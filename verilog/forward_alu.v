module forward_alu (
    forward_a, forward_b, 
    originalR1Data, originalR2Data,
    ALUOut_EM, ALUOut_MW,
	memoryOut, memoryOut_WB,
	PC2_EM, PC2_WB,
	compareResult_EM, compareResult_WB,
	regWriteDataSel_EM, regWriteDataSel_WB,
    forwardR1Data, forwardR2Data
);

input [1:0] forward_a, forward_b;
input [15:0] originalR1Data, originalR2Data;
input [15:0] ALUOut_EM, ALUOut_MW;
input [15:0] memoryOut, memoryOut_WB;
input [15:0] PC2_EM, PC2_WB;
input compareResult_EM, compareResult_WB;
input [1:0] regWriteDataSel_EM, regWriteDataSel_WB;


output [15:0] forwardR1Data, forwardR2Data;

wire [15:0] regWriteData_EM, regWriteData_WB;

mux4_1 m1[15:0] (.A(ALUOut_EM), .B(memoryOut), .C({15'h0000, compareResult_EM}), .D(PC2_EM), .S(regWriteDataSel_EM[1:0]), .O(regWriteData_EM));
mux4_1 m2[15:0] (.A(ALUOut_MW), .B(memoryOut_WB), .C({15'h0000, compareResult_WB}), .D(PC2_WB), .S(regWriteDataSel_WB[1:0]), .O(regWriteData_WB));

assign forwardR1Data = (forward_a == 2'b10) ? regWriteData_EM
                     : (forward_a == 2'b01) ?  regWriteData_WB
                     : originalR1Data;

assign forwardR2Data = (forward_b == 2'b10) ? regWriteData_EM
                     : (forward_b == 2'b01) ?  regWriteData_WB
                     : originalR2Data;
    
endmodule
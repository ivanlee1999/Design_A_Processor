module forward_alu (
    forward_a, forward_b, 
    originalR1Data, originalR2Data,
    ALUOut_EM, regWriteData,
    forwardR1Data, forwardR2Data
);

input [1:0] forward_a, forward_b;
input [15:0] originalR1Data, originalR2Data;
input [15:0] ALUOut_EM, regWriteData;
output [15:0] forwardR1Data, forwardR2Data;

	// assign alu_in_a = (forward_a == 2'b10) ?
	// 	ex_mem_data
	// : (forward_a == 2'b01) ?
	// 	mem_wb_data
	// : 
	// 	readData1;

	// assign alu_in_b = (forward_b == 2'b10) ?
	// 	ex_mem_data
	// : (forward_b == 2'b01) ?
	// 	mem_wb_data
	// :
	// 	readData2;

assign forwardR1Data = (forward_a == 2'b10) ? ALUOut_EM
                     : (forward_a == 2'b01) ?  regWriteData
                     : originalR1Data;

assign forwardR2Data = (forward_b == 2'b10) ? ALUOut_EM
                     : (forward_b == 2'b01) ?  regWriteData
                     : originalR2Data;
    
endmodule
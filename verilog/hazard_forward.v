module hazard_forward (
    regWriteNum_EXMEM,
    regWriteNum_MEMWB,
    regWriteEnable_EXMEM,
    regWriteEnable_MEMWB,
    J, J_EX, J_EM, J_MW,
    PCCtr, PCCtr_EX, PCCtr_EM, PCCtr_MW,
    branchStall,
    r1Num_EX, r2Num_EX,
    ALU1Sel_EX, ALU2Sel_EX,
    forward_a, forward_b
);


input [2:0] regWriteNum_EXMEM, regWriteNum_MEMWB;
input regWriteEnable_EXMEM, regWriteEnable_MEMWB;
input J, J_EX, J_EM, J_MW;
input [1:0] PCCtr, PCCtr_EX, PCCtr_EM, PCCtr_MW;
input [1:0] ALU1Sel_EX, ALU2Sel_EX;
input [2:0] r1Num_EX, r2Num_EX;

output branchStall;
output [1:0] forward_a, forward_b;

	// 		2'b00;



assign forward_a =   
                ((r1Num_EX == regWriteNum_EXMEM) & regWriteEnable_EXMEM  ) ? 2'b10 : 
                ((r1Num_EX == regWriteNum_MEMWB) & regWriteEnable_MEMWB  ) ? 2'b01 :
                2'b00;

assign forward_b = 
                ((r2Num_EX == regWriteNum_EXMEM) & regWriteEnable_EXMEM  ) ? 2'b10 : 
                ((r2Num_EX == regWriteNum_MEMWB) & regWriteEnable_MEMWB  ) ? 2'b01 :
                2'b00;


wire jump;
assign jump = J | J_EX | J_EM | J_MW;

wire branch;
assign branch = (PCCtr == 2'b01) | (PCCtr_EX == 2'b01) | (PCCtr_EM == 2'b01) | (PCCtr_MW == 2'b01);

    
//stall can delate, output rs_ex, rs_mem, rd_ex, rd_mem

assign branchStall = jump | branch;

endmodule

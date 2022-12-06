module hazard_detect (
    instr,
    regWriteNum,
    regWriteNum_IDEX,
    regWriteNum_EXMEM,
    regWriteNum_MEMWB,
    regWriteEnable,
    regWriteEnable_IDEX,
    regWriteEnable_EXMEM,
    regWriteEnable_MEMWB,
    J, J_EX, J_EM, J_MW,
    PCCtr, PCCtr_EX, PCCtr_EM, PCCtr_MW,
    stall, branchStall
);


input [15:0] instr;
input [2:0] regWriteNum, regWriteNum_IDEX,regWriteNum_EXMEM, regWriteNum_MEMWB;
input regWriteEnable, regWriteEnable_IDEX, regWriteEnable_EXMEM, regWriteEnable_MEMWB;
input J, J_EX, J_EM, J_MW;
input [1:0] PCCtr, PCCtr_EX, PCCtr_EM, PCCtr_MW;

output stall;
output branchStall;

wire [2:0] Rs, Rt;

assign Rs = instr[10:8];
assign Rt = instr[7:5];


wire [1:0] ALU1Sel, ALU2Sel;
wire     memWriteEnable;

wire RtRead;

assign ALU1Sel = ({instr[15:11]} == 5'b11000)? 2'b01 : 2'b00;

assign ALU2Sel = (({instr[15:12]} == 4'b1101) | ({instr[15:13]} == 3'b111)) ? 2'b00 : 2'b01;
assign memWriteEnable = (({instr[15:11]} == 5'b10000) | ({instr[15:11]} == 5'b10011) | ({instr[15:11]} == 5'b10001)) ? 1'b1 : 1'b0;

assign RtRead = (ALU2Sel == 2'b00) | (memWriteEnable == 1'b1);

// regWrite == Rs && not LBI(ALU1SEL == 01)
assign stall_rs =  (ALU1Sel != 2'b01) &  (
                  ((Rs == regWriteNum_IDEX) & regWriteEnable_IDEX) | 
                  ((Rs == regWriteNum_EXMEM) & regWriteEnable_EXMEM) | 
                  ((Rs == regWriteNum_MEMWB) & regWriteEnable_MEMWB) |
                  ((Rs == regWriteNum) & regWriteEnable)); 


assign stall_rd = (RtRead) & (
                  ((Rt == regWriteNum_IDEX) & regWriteEnable_IDEX) | 
                  ((Rt == regWriteNum_EXMEM) & regWriteEnable_EXMEM) | 
                  ((Rt == regWriteNum_MEMWB) & regWriteEnable_MEMWB) |
                  ((Rt == regWriteNum) & regWriteEnable));


wire jump;
assign jump = J | J_EX | J_EM | J_MW;

wire branch;
assign branch = (PCCtr == 2'b01) | (PCCtr_EX == 2'b01) | (PCCtr_EM == 2'b01) | (PCCtr_MW == 2'b01);


assign stall = stall_rs | stall_rd | jump | branch;
// assign stall;


assign branchStall = jump | branch;

    
endmodule

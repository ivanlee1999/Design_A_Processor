module hazard_stall (
    instr, memWriteEnable_EX, memReadEnable_EX, regWriteNum_EX, hazard
);

input [15:0] instr;
input memWriteEnable_EX, memReadEnable_EX;
input[2:0] regWriteNum_EX;

output hazard;

wire [2:0] Rs, Rt;

assign Rs = instr[10:8];
assign Rt = instr[7:5];



// only hazard situation is first loading data from data memory and use the data in the next insrtuction
//R2 = LW(R0);
//R3 = R1 + R2;
assign hazard = (memReadEnable_EX & (~memWriteEnable_EX) & ((Rs == regWriteNum_EX) | (Rt == regWriteNum_EX)));


    
endmodule
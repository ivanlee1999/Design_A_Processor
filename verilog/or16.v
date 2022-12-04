module or16 (
    O, A, B
);

input [15:0] A;
input [15:0] B;
output [15:0] O;

assign O[0] = A[0] | B[0];
assign O[1] = A[1] | B[1];
assign O[2] = A[2] | B[2];
assign O[3] = A[3] | B[3];
assign O[4] = A[4] | B[4];
assign O[5] = A[5] | B[5];
assign O[6] = A[6] | B[6];
assign O[7] = A[7] | B[7];
assign O[8] = A[8] | B[8];
assign O[9] = A[9] | B[9];
assign O[10] = A[10] | B[10];
assign O[11] = A[11] | B[11];
assign O[12] = A[12] | B[12];
assign O[13] = A[13] | B[13];
assign O[14] = A[14] | B[14];
assign O[15] = A[15] | B[15];
    
endmodule
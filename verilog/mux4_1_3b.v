module mux4_1_3b (
    A, B, C, D, S, O
);

input[2:0] A, B, C, D;
input [1:0]S;
output [2:0] O;




mux4_1 m1(A[0],B[0], C[0], D[0], S[1:0], O[0]);
mux4_1 m2(A[1],B[1], C[1], D[1], S[1:0], O[1]);
mux4_1 m3(A[2],B[2], C[2], D[2], S[1:0], O[2]);


endmodule
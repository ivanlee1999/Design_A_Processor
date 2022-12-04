module mux4_1 (
    A, B, C, D, S, O
);

input A, B, C, D;
input [1:0]S;
output O;

assign O = ((~S[0]) & (~S[1]) & A) | (S[0] & (~S[1]) & B) | (S[1] & (~S[0]) & C) | (S[0] & S[1] & D);
    
endmodule

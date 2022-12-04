module mux8_1(I0, I1, I2, I3, I4, I5, I6, I7, S, O);

input I0, I1, I2, I3, I4, I5, I6, I7;
input [2:0] S;
output O;

assign O = (~S[2] & ~S[1] & ~S[0] & I0) 
         | (~S[2] & ~S[1] &  S[0] & I1)
         | (~S[2] &  S[1] & ~S[0] & I2)
         | (~S[2] &  S[1] &  S[0] & I3)
         | ( S[2] & ~S[1] & ~S[0] & I4)
         | ( S[2] & ~S[1] &  S[0] & I5)
         | ( S[2] &  S[1] & ~S[0] & I6)
         | ( S[2] &  S[1] &  S[0] & I7);
endmodule

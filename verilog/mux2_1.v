module mux2_1 (
    A, B, S, O
);
input A, B,S;
output O;

assign O = (~S & A) | (S & B);

endmodule

/*
    CS/ECE 552 FALL'22
    Homework #2, Problem 1
    
    a 4-bit CLA module
*/
module cla_4b(sum, c_out, a, b, c_in);

    // declare constant for size of inputs, outputs (N)
    parameter   N = 4;

    output [N-1:0] sum;
    output         c_out;
    input [N-1: 0] a, b;
    input          c_in;

    // YOUR CODE HERE
    wire c1, c2,c3;

    fullAdder_1b f1(sum[0], c1, a[0], b[0], c_in );
    fullAdder_1b f2(sum[1], c2, a[1], b[1], c1 );
    fullAdder_1b f3(sum[2], c3, a[2], b[2], c2 );
    fullAdder_1b f4(sum[3], c_out, a[3], b[3], c3 );

endmodule

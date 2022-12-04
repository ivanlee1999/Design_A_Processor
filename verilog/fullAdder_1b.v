/*
    CS/ECE 552 FALL '22
    Homework #2, Problem 1
    
    a 1-bit full adder
*/
module fullAdder_1b(s, c_out, a, b, c_in);
    output s;
    output c_out;
    input  a, b;
    input  c_in;
    wire ab, ac, bc;
    

    // YOUR CODE HERE
    // xor3 x3(s,a,b,c_in);
    assign s = a ^ b ^ c_in;
    nand2 n1(ab,a, b);
    nand2 n2(ac, a, c_in);
    nand2 n3(bc,c_in, b);
    nand3 n4(c_out, ab, ac, bc);

endmodule

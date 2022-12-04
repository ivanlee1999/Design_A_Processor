


/*
    CS/ECE 552 FALL '22
    Homework #2, Problem 3

    A multi-bit ALU module (defaults to 16-bit). It is designed to choose
    the correct operation to perform on 2 multi-bit numbers from rotate
    left, shift left, shift right arithmetic, shift right logical, add,
    or, xor, & and.  Upon doing this, it should output the multi-bit result
    of the operation, as well as drive the output signals Zero and Overflow
    (OFL).
*/
module alu (InA, InB, Cin, Oper, invA, invB, sign, Out, Zero, Ofl);

    parameter OPERAND_WIDTH = 16;    
    parameter NUM_OPERATIONS = 3;
       
    input  [OPERAND_WIDTH -1:0] InA ; // Input operand A
    input  [OPERAND_WIDTH -1:0] InB ; // Input operand B
    input                       Cin ; // Carry in
    input  [NUM_OPERATIONS-1:0] Oper; // Operation type
    input                       invA; // Signal to invert A
    input                       invB; // Signal to invert B
    input                       sign; // Signal for signed operation
    output [OPERAND_WIDTH -1:0] Out ; // Result of computation
    output                      Ofl ; // Signal if overflow occured
    output                      Zero; // Signal if Out is 0

    /* YOUR CODE HERE */

    wire [15:0] afterInvA;
    wire [15:0] afterInvB;
    wire [3:0]  negInvB;
    wire [15:0] ShiftResult;
    wire [15:0] AddResult;
    wire [15:0] AndResult;
    wire [15:0] OrResult;
    wire [15:0] XorResult;
    wire Cout;


    inverse inv1(InA, invA, afterInvA);
    inverse inv2(InB, invB, afterInvB);

    shifter shi1(afterInvA, negInvB, Oper[1:0], ShiftResult);

    cla_16b add1(AddResult, Cout, afterInvA, afterInvB, Cin);
    //module cla_4b(sum, c_out, a, b, c_in);
    cla_4b   add2(.sum(negInvB), .c_out(), .a(afterInvB[3:0]), .b(4'b0000), .c_in(Cin));

    assign AndResult = afterInvA & afterInvB;
    assign OrResult =  afterInvA | afterInvB;
    assign XorResult = afterInvA ^ afterInvB;

    mux8_1 Out2(ShiftResult[0], ShiftResult[0], ShiftResult[0], ShiftResult[0], AddResult[0], AndResult[0], OrResult[0], XorResult[0], Oper, Out[0]);
    mux8_1 Out3(ShiftResult[1], ShiftResult[1], ShiftResult[1], ShiftResult[1], AddResult[1], AndResult[1], OrResult[1], XorResult[1], Oper, Out[1]);
    mux8_1 Out4(ShiftResult[2], ShiftResult[2], ShiftResult[2], ShiftResult[2], AddResult[2], AndResult[2], OrResult[2], XorResult[2], Oper, Out[2]);
    mux8_1 Out5(ShiftResult[3], ShiftResult[3], ShiftResult[3], ShiftResult[3], AddResult[3], AndResult[3], OrResult[3], XorResult[3], Oper, Out[3]);
    mux8_1 Out6(ShiftResult[4], ShiftResult[4], ShiftResult[4], ShiftResult[4], AddResult[4], AndResult[4], OrResult[4], XorResult[4], Oper, Out[4]);
    mux8_1 Out7(ShiftResult[5], ShiftResult[5], ShiftResult[5], ShiftResult[5], AddResult[5], AndResult[5], OrResult[5], XorResult[5], Oper, Out[5]);
    mux8_1 Out8(ShiftResult[6], ShiftResult[6], ShiftResult[6], ShiftResult[6], AddResult[6], AndResult[6], OrResult[6], XorResult[6], Oper, Out[6]);
    mux8_1 Out9(ShiftResult[7], ShiftResult[7], ShiftResult[7], ShiftResult[7], AddResult[7], AndResult[7], OrResult[7], XorResult[7], Oper, Out[7]);
    mux8_1 Out10(ShiftResult[8], ShiftResult[8], ShiftResult[8], ShiftResult[8], AddResult[8], AndResult[8], OrResult[8], XorResult[8], Oper, Out[8]);
    mux8_1 Out11(ShiftResult[9], ShiftResult[9], ShiftResult[9], ShiftResult[9], AddResult[9], AndResult[9], OrResult[9], XorResult[9], Oper, Out[9]);
    mux8_1 Out12(ShiftResult[10], ShiftResult[10], ShiftResult[10], ShiftResult[10], AddResult[10], AndResult[10], OrResult[10], XorResult[10], Oper, Out[10]);
    mux8_1 Out13(ShiftResult[11], ShiftResult[11], ShiftResult[11], ShiftResult[11], AddResult[11], AndResult[11], OrResult[11], XorResult[11], Oper, Out[11]);
    mux8_1 Out14(ShiftResult[12], ShiftResult[12], ShiftResult[12], ShiftResult[12], AddResult[12], AndResult[12], OrResult[12], XorResult[12], Oper, Out[12]);
    mux8_1 Out15(ShiftResult[13], ShiftResult[13], ShiftResult[13], ShiftResult[13], AddResult[13], AndResult[13], OrResult[13], XorResult[13], Oper, Out[13]);
    mux8_1 Out16(ShiftResult[14], ShiftResult[14], ShiftResult[14], ShiftResult[14], AddResult[14], AndResult[14], OrResult[14], XorResult[14], Oper, Out[14]);
    mux8_1 Out17(ShiftResult[15], ShiftResult[15], ShiftResult[15], ShiftResult[15], AddResult[15], AndResult[15], OrResult[15], XorResult[15], Oper, Out[15]);
    
	// assign Out = AndResult;  

    assign Zero = (AddResult == 16'b0);

    assign Ofl = (sign &(AddResult[15]  ^ afterInvA[15] ^ afterInvB[15] ^ Cout))  | ((~sign) & Cout);

    
endmodule
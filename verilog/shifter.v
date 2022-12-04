/*
    CS/ECE 552 FALL '22
    Homework #2, Problem 2
    
    A barrel shifter module.  It is designed to shift a number via rotate
    left, shift left, shift right arithmetic, or shift right logical based
    on the 'Oper' value that is passed in.  It uses these
    shifts to shift the value any number of bits.
 */
module shifter (In, ShAmt, Oper, Out);

    // declare constant for size of inputs, outputs, and # bits to shift
    parameter OPERAND_WIDTH = 16;
    parameter SHAMT_WIDTH   =  4;
    parameter NUM_OPERATIONS = 2;

    input  [OPERAND_WIDTH -1:0] In   ; // Input operand
    input  [SHAMT_WIDTH   -1:0] ShAmt; // Amount to shift/rotate
    input  [NUM_OPERATIONS-1:0] Oper ; // Operation type
    output [OPERAND_WIDTH -1:0] Out  ; // Result of shift/rotate

   /* YOUR CODE HERE */
    wire [15:0] rl;
    wire [15:0] sl;
    wire [15:0] sra;
    wire [15:0] srl;

    wire [15:0] I1;
    wire [15:0] I2;
    wire [15:0] I3;
    wire [15:0] I4;

    rotate ro(In, ShAmt, rl);
    mux4_1 mu0(rl[0], sl[0], sra[0], srl[0], Oper, Out[0]);
    mux4_1 mu1(rl[1], sl[1], sra[1], srl[1], Oper, Out[1]);
    mux4_1 mu2(rl[2], sl[2], sra[2], srl[2], Oper, Out[2]);
    mux4_1 mu3(rl[3], sl[3], sra[3], srl[3], Oper, Out[3]);
    mux4_1 mu4(rl[4], sl[4], sra[4], srl[4], Oper, Out[4]);
    mux4_1 mu5(rl[5], sl[5], sra[5], srl[5], Oper, Out[5]);
    mux4_1 mu6(rl[6], sl[6], sra[6], srl[6], Oper, Out[6]);
    mux4_1 mu7(rl[7], sl[7], sra[7], srl[7], Oper, Out[7]);
    mux4_1 mu8(rl[8], sl[8], sra[8], srl[8], Oper, Out[8]);
    mux4_1 mu9(rl[9], sl[9], sra[9], srl[9], Oper, Out[9]);
    mux4_1 mu10(rl[10], sl[10], sra[10], srl[10], Oper, Out[10]);
    mux4_1 mu11(rl[11], sl[11], sra[11], srl[11], Oper, Out[11]);
    mux4_1 mu12(rl[12], sl[12], sra[12], srl[12], Oper, Out[12]);
    mux4_1 mu13(rl[13], sl[13], sra[13], srl[13], Oper, Out[13]);
    mux4_1 mu14(rl[14], sl[14], sra[14], srl[14], Oper, Out[14]);
    mux4_1 mu15(rl[15], sl[15], sra[15], srl[15], Oper, Out[15]);
    


    assign sl = In << ShAmt;
    assign sra = ($signed(In) >>> ShAmt)  ;
    assign srl = In >> ShAmt;



endmodule

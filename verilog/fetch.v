/*
   CS/ECE 552 Spring '20
  
   Filename        : fetch.v
   Description     : This is the module for the overall fetch stage of the processor.
*/
module fetch (
   PCin,
   halt,
   clk,
   rst,
   newPC,
   PC2,
   instrct,
   stall,
   PCCtr,
   branchStall,
   PCOut,
   J
); 
   input[15:0] PCin;
   input halt, clk, rst;
   input stall;
   input [1:0] PCCtr;
   input branchStall;
   input [15:0] PCOut;
   input J;

   output[15:0] instrct;
   output [15:0] newPC, PC2;

   wire [15:0] instct_temp;
   wire[15:0] PC_temp;
   
   wire [15:0] incr;

   assign incr = stall ? 16'h0000 : 16'h0002;

   //assign incr = branchStall ? 16'h0000 : 16'h0002;

   //module cla_16b(sum, c_out, a, b, c_in);
   dff_16b passPC(.q(newPC), .d(PC_temp), .clk(clk), .rst(rst));
   cla_16b pcPlus2(.sum(PC2), .c_out(), .a(newPC), .b(incr), .c_in(1'b0));
   memory2c fetchInstruct(.data_out(instrct), .data_in(16'h0000), 
                        .addr(newPC), .enable(1'b1), .wr(1'b0), .createdump(halt), .clk(clk), .rst(rst) );

   
   assign PC_temp = ((PCCtr == 2'b01) | (J == 1'b1)) ? PCOut : PCin;
   
   // assign instrct = (branchStall) ?  16'h0800 : inst_temp;
   wire [15:0] instrct2, test;
   assign test = 16'd24;
   
   memory2c fetchInstruct2(.data_out(instrct2), .data_in(16'h0000), 
                        .addr(test), .enable(1'b1), .wr(1'b0), .createdump(1'b0), .clk(clk), .rst(rst) );


   // always@(negedge clk) begin
   //  //   $display("A: %b, Op: %b, Inv: %b", 
   //  //   A, Op, Inv);
   // //  $display("PCin : %h, newPC : %h, PC2 : %h", PCin, newPC, PC2);
   //    $display("test address of %d : %b",test, instrct2);
   //    $display("");
   // end

endmodule







module dff_16b (q,d, clk, rst);
   output [15:0] q;
   input [15:0] d;
   input clk, rst;

   dff dff1(q[0], d[0], clk, rst); 
   dff dff2(q[1], d[1], clk, rst); 
   dff dff3(q[2], d[2], clk, rst); 
   dff dff4(q[3], d[3], clk, rst); 
   dff dff5(q[4], d[4], clk, rst); 
   dff dff6(q[5], d[5], clk, rst); 
   dff dff7(q[6], d[6], clk, rst); 
   dff dff8(q[7], d[7], clk, rst); 
   dff dff9(q[8], d[8], clk, rst); 
   dff dff10(q[9], d[9], clk, rst); 
   dff dff11(q[10], d[10], clk, rst); 
   dff dff12(q[11], d[11], clk, rst); 
   dff dff13(q[12], d[12], clk, rst); 
   dff dff14(q[13], d[13], clk, rst); 
   dff dff15(q[14], d[14], clk, rst); 
   dff dff16(q[15], d[15], clk, rst); 
endmodule
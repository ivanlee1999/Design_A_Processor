module IFID (
    instrct_in,
    instrct_out,
    newPC_in,
    newPC_out,
    PC2_in,
    PC2_out,
    clk,
    rst,
    en
);

   input clk, rst;
   input[15:0] instrct_in;
   input[15:0] newPC_in, PC2_in;
   input en;
   output[15:0] instrct_out;
   output[15:0] newPC_out, PC2_out;

    wire [15:0] inst_temp;

   assign inst_temp = (rst) ? 16'h0800 : instrct_in;

   dffr d1 [15:0] (.q(instrct_out),.d(inst_temp), .clk(clk), .rst(1'b0), .en(en));
   dffr d2 [15:0] (.q(newPC_out),.d(newPC_in), .clk(clk), .rst(rst), .en(en));
   dffr d3 [15:0] (.q(PC2_out),.d(PC2_in), .clk(clk), .rst(rst), .en(en));
    
endmodule
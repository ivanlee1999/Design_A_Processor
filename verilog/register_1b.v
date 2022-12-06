module register_1b (clk, rst, en, in, out);
  input clk, rst;
  input en; // flag for write
  input in; // write
  output out; // read

  wire writeEN;

  dff DFF (.q(out), .d(writeEN), .clk(clk), .rst(rst));

  mux2_1 MUX (.A(out), .B(in), .S(en), .O(writeEN));
endmodule


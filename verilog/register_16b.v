module register_16b (clk, rst, en, in, out);
  // --- Inputs and Outputs ---
  input clk, rst;
  input en; 
  input [15:0] in; 
  output [15:0] out;

  // --- Wire ---
  wire [15:0] writeEN;

  // --- Code ---
  // dff
  dff DFF[15:0] (.q(out), .d(writeEN), .clk(clk), .rst(rst));

  // mux
  mux2_1 MUX[15:0] (.A(out), .B(in), .S(en), .O(writeEN));
endmodule

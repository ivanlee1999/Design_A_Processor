module dffr (q, d, en, clk, rst);
    input d, en, clk, rst;
    output q;

    wire in;
    
    assign in = (en) ? d : q;

    dff ff(.q(q), .d(in), .clk(clk), .rst(rst));
endmodule
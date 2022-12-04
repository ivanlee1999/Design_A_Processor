module inverse (
    In, Op, O
);

input [15:0] In;
input Op;
output [15:0] O;

assign O[0] = In[0] ^ Op;
assign O[1] = In[1] ^ Op;
assign O[2] = In[2] ^ Op;
assign O[3] = In[3] ^ Op;
assign O[4] = In[4] ^ Op;
assign O[5] = In[5] ^ Op;
assign O[6] = In[6] ^ Op;
assign O[7] = In[7] ^ Op;
assign O[8] = In[8] ^ Op;
assign O[9] = In[9] ^ Op;
assign O[10] = In[10] ^ Op;
assign O[11] = In[11] ^ Op;
assign O[12] = In[12] ^ Op;
assign O[13] = In[13] ^ Op;
assign O[14] = In[14] ^ Op;
assign O[15] = In[15] ^ Op;
endmodule
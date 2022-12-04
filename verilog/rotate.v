module rotate (
    In, ShAmt, Ou
);
input [15:0] In;
input [3:0] ShAmt;
output [15:0] Ou;
wire [15:0] R1;
wire [15:0] R2;
wire [15:0] R3;

// After first layer
mux2_1 m000(In[0], In[15], ShAmt[0], R1[0]);
mux2_1 m001(In[1], In[0], ShAmt[0], R1[1]);
mux2_1 m002(In[2], In[1], ShAmt[0], R1[2]);
mux2_1 m003(In[3], In[2], ShAmt[0], R1[3]);
mux2_1 m004(In[4], In[3], ShAmt[0], R1[4]);
mux2_1 m005(In[5], In[4], ShAmt[0], R1[5]);
mux2_1 m006(In[6], In[5], ShAmt[0], R1[6]);
mux2_1 m007(In[7], In[6], ShAmt[0], R1[7]);
mux2_1 m008(In[8], In[7], ShAmt[0], R1[8]);
mux2_1 m009(In[9], In[8], ShAmt[0], R1[9]);
mux2_1 m010(In[10], In[9], ShAmt[0], R1[10]);
mux2_1 m011(In[11], In[10], ShAmt[0], R1[11]);
mux2_1 m012(In[12], In[11], ShAmt[0], R1[12]);
mux2_1 m013(In[13], In[12], ShAmt[0], R1[13]);
mux2_1 m014(In[14], In[13], ShAmt[0], R1[14]);
mux2_1 m015(In[15], In[14], ShAmt[0], R1[15]);


// After second layer
mux2_1 m100(R1[0],  R1[14], ShAmt[1], R2[0]);
mux2_1 m101(R1[1],  R1[15], ShAmt[1], R2[1]);
mux2_1 m102(R1[2],  R1[0],  ShAmt[1], R2[2]);
mux2_1 m103(R1[3],  R1[1],  ShAmt[1], R2[3]);
mux2_1 m104(R1[4],  R1[2],  ShAmt[1], R2[4]);
mux2_1 m105(R1[5],  R1[3],  ShAmt[1], R2[5]);
mux2_1 m106(R1[6],  R1[4],  ShAmt[1], R2[6]);
mux2_1 m107(R1[7],  R1[5],  ShAmt[1], R2[7]);
mux2_1 m108(R1[8],  R1[6],  ShAmt[1], R2[8]);
mux2_1 m109(R1[9],  R1[7], ShAmt[1], R2[9]);
mux2_1 m110(R1[10], R1[8], ShAmt[1], R2[10]);
mux2_1 m111(R1[11], R1[9], ShAmt[1], R2[11]);
mux2_1 m112(R1[12], R1[10], ShAmt[1], R2[12]);
mux2_1 m113(R1[13], R1[11], ShAmt[1], R2[13]);
mux2_1 m114(R1[14], R1[12], ShAmt[1], R2[14]);
mux2_1 m115(R1[15], R1[13],  ShAmt[1], R2[15]);

// after third layer
mux2_1 m200(R2[0],  R2[12], ShAmt[2], R3[0]);
mux2_1 m201(R2[1],  R2[13], ShAmt[2], R3[1]);
mux2_1 m202(R2[2],  R2[14],  ShAmt[2], R3[2]);
mux2_1 m203(R2[3],  R2[15],  ShAmt[2], R3[3]);
mux2_1 m204(R2[4],  R2[0],  ShAmt[2], R3[4]);
mux2_1 m205(R2[5],  R2[1],  ShAmt[2], R3[5]);
mux2_1 m206(R2[6],  R2[2],  ShAmt[2], R3[6]);
mux2_1 m207(R2[7],  R2[3],  ShAmt[2], R3[7]);
mux2_1 m208(R2[8],  R2[4],  ShAmt[2], R3[8]);
mux2_1 m209(R2[9],  R2[5], ShAmt[2], R3[9]);
mux2_1 m210(R2[10], R2[6], ShAmt[2], R3[10]);
mux2_1 m211(R2[11], R2[7], ShAmt[2], R3[11]);
mux2_1 m212(R2[12], R2[8], ShAmt[2], R3[12]);
mux2_1 m213(R2[13], R2[9], ShAmt[2], R3[13]);
mux2_1 m214(R2[14], R2[10], ShAmt[2], R3[14]);
mux2_1 m215(R2[15], R2[11],  ShAmt[2], R3[15]);
    
// after final layer
mux2_1 m300(R3[0],  R3[8], ShAmt[3], Ou[0]);
mux2_1 m301(R3[1],  R3[9], ShAmt[3], Ou[1]);
mux2_1 m302(R3[2],  R3[10],  ShAmt[3], Ou[2]);
mux2_1 m303(R3[3],  R3[11],  ShAmt[3], Ou[3]);
mux2_1 m304(R3[4],  R3[12],  ShAmt[3], Ou[4]);
mux2_1 m305(R3[5],  R3[13],  ShAmt[3], Ou[5]);
mux2_1 m306(R3[6],  R3[14],  ShAmt[3], Ou[6]);
mux2_1 m307(R3[7],  R3[15],  ShAmt[3], Ou[7]);
mux2_1 m308(R3[8],  R3[0],  ShAmt[3], Ou[8]);
mux2_1 m309(R3[9],  R3[1], ShAmt[3], Ou[9]);
mux2_1 m310(R3[10], R3[2], ShAmt[3], Ou[10]);
mux2_1 m311(R3[11], R3[3], ShAmt[3], Ou[11]);
mux2_1 m312(R3[12], R3[4], ShAmt[3], Ou[12]);
mux2_1 m313(R3[13], R3[5], ShAmt[3], Ou[13]);
mux2_1 m314(R3[14], R3[6], ShAmt[3], Ou[14]);
mux2_1 m315(R3[15], R3[7],  ShAmt[3], Ou[15]);



endmodule
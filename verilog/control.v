module control (
    instr, regWriteEnable, regWriteRegSel, regwriteDataSel, 
    inv1, inv2, cin, signExtend, ALU1Sel, ALU2Sel, ALUOp, 
    memWriteEnable, memReadEnable, PCCtr, J, siic, nop,
    compareSig, branchSig, halt);

input [15:0] instr;

output reg          halt;
output reg          regWriteEnable;
output reg [1:0]    regWriteRegSel;
output reg [1:0]    regwriteDataSel;
output reg          inv1, inv2, cin, signExtend;
output reg [1:0]    ALU1Sel;
output reg [1:0]    ALU2Sel;
output reg [2:0]    ALUOp;
output reg          memWriteEnable;
output reg          memReadEnable;
output reg [1:0]    PCCtr;
output reg          J;
output reg          siic, nop;
output reg [1:0]    compareSig, branchSig;


always @(*) begin
    halt = 1'b0;
    regWriteEnable = 1'b0;
    regWriteRegSel = 2'b00;
    regWriteRegSel = 2'b00;
    regwriteDataSel = 2'b00;
    inv1 = 1'b0;
    inv2 = 1'b0;
    cin = 1'b0;
    signExtend = 1'b0;
    ALU1Sel = 2'b00;
    ALU2Sel = 2'b00;
    ALUOp = 3'b000;
    memWriteEnable = 1'b0;
    memReadEnable = 1'b0;
    PCCtr = 2'b00;
    J = 1'b0;
    siic = 1'b0;
    nop = 1'b0;
    compareSig = 2'b00; 
    branchSig = 2'b00;
    
    case ({instr[15:11]})

        5'b00000:begin                //HALT
            halt = 1'b1;
        end
        5'b00001:begin               //NOP
        end
        5'b01000:begin
            ALUOp =  3'b100;
            signExtend = 1'b1;
            regWriteEnable = 1'b1;
            ALU2Sel = 2'b01;              //from intermediate
            regWriteRegSel = 2'b00;      //[7:5]
            regwriteDataSel = 2'b00;     //from ALU Out
        end
        5'b01001:begin
            ALUOp =  3'b100;
            signExtend = 1'b1;
            regWriteEnable = 1'b1;
            ALU2Sel = 2'b01;              //from intermediate
            regWriteRegSel = 2'b00;      //[7:5]
            regwriteDataSel = 2'b00;     //from ALU Out
            inv1 = 1'b1;
            cin = 1;
        end
        5'b01010:begin                  //XORI
            ALUOp =  3'b111;
            signExtend = 1'b0;
            regWriteEnable = 1'b1;
            ALU2Sel = 2'b01;              //from intermediate
            regWriteRegSel = 2'b00;      //[7:5] d
            regwriteDataSel = 2'b00;     //from ALU Out
        end
        5'b01011:begin                  //ANDNI
            ALUOp =  3'b101;
            signExtend = 1'b0;
            regWriteEnable = 1'b1;
            ALU2Sel = 2'b01;              //from intermediate
            regWriteRegSel = 2'b00;      //[7:5] d
            regwriteDataSel = 2'b00;     //from ALU Out
            inv2 = 1'b1;
        end
        5'b10100:begin                      //ROLI
            ALUOp =  3'b000;
            signExtend = 1'b0;
            regWriteEnable = 1'b1;
            ALU2Sel = 2'b01;              //from intermediate
            regWriteRegSel = 2'b00;      //[7:5] d
            regwriteDataSel = 2'b00;     //from ALU Out
        end
        5'b10101:begin                      //SLLI
            ALUOp =  3'b001;
            signExtend = 1'b0;
            regWriteEnable = 1'b1;
            ALU2Sel = 2'b01;              //from intermediate
            regWriteRegSel = 2'b00;      //[7:5] d
            regwriteDataSel = 2'b00;     //from ALU Out
        end
        5'b10110:begin                      //RORI
            ALUOp =  3'b000;
            signExtend = 1'b0;
            regWriteEnable = 1'b1;
            ALU2Sel = 2'b01;              //from intermediate
            regWriteRegSel = 2'b00;      //[7:5] d
            regwriteDataSel = 2'b00;     //from ALU Out
            inv2 = 1'b1;
            cin = 1'b1;
        end
        5'b10111:begin                      //SRLI
            ALUOp =  3'b011;
            signExtend = 1'b0;
            regWriteEnable = 1'b1;
            ALU2Sel = 2'b01;              //from intermediate
            regWriteRegSel = 2'b00;      //[7:5] d
            regwriteDataSel = 2'b00;     //from ALU Out
        end
        5'b10000:begin                  //ST  ALU calculate(RS + I)
            ALUOp = 3'b100;
            signExtend = 1'b1;
            memWriteEnable = 1'b1;
            ALU2Sel = 2'b01;
        end
        5'b10001:begin                  //LD
            ALUOp = 3'b100;
            signExtend = 1'b1;
            memReadEnable = 1'b1;
            ALU2Sel = 2'b01;
            regWriteEnable = 1'b1;
            regwriteDataSel = 2'b01;      //from memory
            regWriteRegSel = 2'b00;     
        end
        5'b10011:begin                     //stu
            ALUOp = 3'b100;
            signExtend = 1'b1;
            memWriteEnable = 1'b1;
            ALU2Sel = 2'b01;
            regWriteEnable = 1'b1;
            regwriteDataSel = 2'b00;
            regWriteRegSel = 2'b01;      //[10:8] s
        end

        5'b11001:begin                 //BTR
            ALUOp = 3'b100;
            ALU1Sel = 2'b11;
            ALU2Sel = 2'b10;
            regWriteEnable = 1'b1;
            regwriteDataSel = 2'b00;
            regWriteRegSel = 2'b11;         //[4:2]
        end


        //R instruction

        5'b11011:begin       
            regWriteEnable = 1'b1;
            regWriteRegSel = 2'b11;             //[4:2] d
            regwriteDataSel = 2'b00;            // from ALU
            ALU2Sel = 2'b00;                    //R2
            case (instr[1:0])   
                2'b00 : ALUOp = 3'b100;     //ADD
                2'b01 : begin               //SUB
                    ALUOp = 3'b100;
                    inv1 = 1'b1;
                    cin = 1'b1;
                end 
                2'b10 : ALUOp = 3'b111;     //XOR
                2'b11 : begin               //ANDN
                     ALUOp = 3'b101;
                     inv2 = 1'b1;
                end
            endcase
        end

        5'b11010:begin
            regWriteEnable = 1'b1;
            regWriteRegSel = 2'b11;             //[4:2] d
            regwriteDataSel = 2'b00;            // from ALU
            ALU2Sel = 2'b00;                   //R2
            case(instr[1:0])
                2'b00 : ALUOp = 3'b000;     //ROL
                2'b01 : ALUOp = 3'b001;     //SLL
                2'b10 : begin               //ROR
                    ALUOp = 3'b000;
                    inv2 = 1;
                    cin = 1;
                end
                2'b11: ALUOp = 3'b011;      //SRL
            endcase
        end



        //compare
        5'b11100:begin                    //SEQ
            ALUOp = 3'b100;
            ALU2Sel = 2'b00;           //R2
            regWriteEnable = 1'b1;
            regWriteRegSel = 2'b11;
            regwriteDataSel = 2'b10;        //from compareResult
            inv2 = 1'b1;
            cin = 1'b1;
            compareSig = 2'b00;
        end
        5'b11101:begin                    //SLT
            ALUOp = 3'b100;
            ALU2Sel = 2'b00;           //R2
            regWriteEnable = 1'b1;
            regWriteRegSel = 2'b11;
            regwriteDataSel = 2'b10;
            inv2 = 1'b1;
            cin = 1'b1;
            compareSig = 2'b01;
        end
        5'b11110:begin                    //SLE      -r1+rt2
            ALUOp = 3'b100;
            ALU2Sel = 2'b00;           //R2
            regWriteEnable = 1'b1;
            regWriteRegSel = 2'b11;
            regwriteDataSel = 2'b10;
            inv2 = 1'b1;
            cin = 1'b1;
            compareSig = 2'b10;
        end
        5'b11111:begin                    //SCO
            ALUOp = 3'b100;
            ALU2Sel = 2'b00;           //R2
            regWriteEnable = 1'b1;
            regWriteRegSel = 2'b11;
            regwriteDataSel = 2'b10;
            compareSig = 2'b11;
        end


        //branch
        5'b01100:begin          //BEQz
            ALUOp = 3'b100;
            ALU2Sel = 2'b10;      //add 0 to ALU
            branchSig = 2'b00;
            signExtend = 1'b1;
            PCCtr = 2'b01;
        end
        5'b01101:begin          //BNEZ
            ALUOp = 3'b100;
            ALU2Sel = 2'b10;      //add 0 to ALU
            branchSig = 2'b01;
            signExtend = 1'b1;
            PCCtr = 2'b01;
        end
        5'b01110:begin          //BLTZ
            ALUOp = 3'b100;
            ALU2Sel = 2'b10;      //add 0 to ALU
            branchSig = 2'b10;
            signExtend = 1'b1;
            PCCtr = 2'b01;
        end
        5'b01111:begin          //BGEZ
            ALUOp = 3'b100;
            ALU2Sel = 2'b10;      //add 0 to ALU
            branchSig = 2'b11;
            signExtend = 1'b1;
            PCCtr = 2'b01;
        end

        5'b11000:begin        //LBI
            ALUOp = 3'b100;
            regWriteEnable = 1'b1;
            regWriteRegSel = 2'b01;      //[10:8]  s
            regwriteDataSel = 2'b00;
            signExtend = 1'b1;
            ALU1Sel = 2'b01;             //zero
            ALU2Sel = 2'b11;
        end

        5'b10010:begin        //SLBI
            ALUOp = 3'b110;
            regWriteEnable = 1'b1;
            regWriteRegSel = 2'b01;      //[10:8]  s
            regwriteDataSel = 2'b00;
            signExtend = 1'b0;
            ALU1Sel = 2'b10;
            ALU2Sel = 2'b11;
        end



        //J
        5'b00100:begin              //J
            J = 1'b1;
            signExtend = 1'b1;
            PCCtr = 2'b10;           //PC2D
        end
        5'b00101:begin              //JR
            J = 1'b1;
            signExtend = 1'b1;
            ALUOp = 3'b100;
            ALU2Sel = 2'b10;     //0
            PCCtr = 2'b11;         //RSI8
        end
        5'b00110:begin               //JAL
            J = 1'b1;
            signExtend = 1'b1;
            regWriteEnable = 1'b1;
            regWriteRegSel = 2'b10;
            regwriteDataSel = 2'b11;
            PCCtr = 2'b10;          //PC2D
        end
        5'b00111:begin               //JALR
            J = 1'b1;
            regWriteEnable = 1'b1;
            signExtend = 1'b1;
            regWriteRegSel = 2'b10;
            regwriteDataSel = 2'b11;
            PCCtr = 2'b11;          //RSI8
        end
        5'b00010: siic = 1'b1;
        5'b00011: nop = 1'b1;

    endcase
end

    
endmodule
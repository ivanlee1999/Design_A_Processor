module cache_controller(//input
		       clk, rst, addrLatch, dataInLatch, action, trueHit,
		       WRITE, READ, wrLatch, memDataOut,
		       //output
		       FSMErr, done, cacheHit, comp, latch, Stall,
		       memWrite, write, memRead, bank, cacheOffset,
		       cacheDataIn, flip);

input clk, rst;
input [15:0] addrLatch;
input [15:0] dataInLatch;
input action;
input trueHit;
input WRITE, READ;
input wrLatch;
input [15:0] memDataOut;

output reg FSMErr;
output reg done;
output reg cacheHit;
output reg comp, flip;
output reg latch, write;
output reg Stall;
output reg memWrite, memRead;
output reg [1:0] bank;
output reg [2:0] cacheOffset;
output reg [15:0] cacheDataIn;

wire [3:0] state;
reg [3:0] nextState;

dff statedff[3:0](.q(state), .d(nextState), .clk(clk), .rst(rst));

always @(*) begin
    FSMErr = 0;
    done = 0;
    cacheHit = 0;
    comp = 0;
    latch = 0;
    Stall = 0;
    memWrite = 0;
    write = 0;
    memRead = 0;
    bank = 2'b00;
    cacheOffset = addrLatch[2:0];
    nextState = state;
    cacheDataIn = dataInLatch;
    flip = 0;
    casex (state)
        4'b0000: begin		//idle state
            nextState = (~action | (action & trueHit)) ? 4'b0000 : 
                        (WRITE) ? 4'b0001 : (READ) ? 4'b0101 : 4'b1011;
            done = action & trueHit;
            cacheHit = action & trueHit;
            Stall = READ | WRITE;
            write = action & trueHit & wrLatch;
            flip = action;
            bank = 2'b00;
            memRead = READ;
            memWrite = WRITE;
            cacheOffset = (WRITE) ? 3'b000 : addrLatch[2:0];
            comp = 1;
            latch = 1;
        end
        4'b0001: begin		//Write 0
            nextState = 4'b0010;
            Stall = 1;
            memWrite = 1;
            bank = 2'b01;
            cacheOffset = 3'b010;
        end
        4'b0010: begin		//Write 1
            nextState = 4'b0011;
            Stall = 1;
            memWrite = 1;
            bank = 2'b10;
            cacheOffset = 3'b100;
        end
        4'b0011: begin		//Write 2
            nextState = 4'b0100;
            Stall = 1;
            memWrite = 1;
            bank = 2'b11;
            cacheOffset = 3'b110;
        end
        4'b0100: begin		//Write 3
            nextState = 4'b0101;
            Stall = 1;
            bank = 2'b00;
            memRead = 1;
        end
        4'b0101: begin		//Read 0
            nextState = 4'b0110;
            Stall = 1;
            bank = 2'b01;
            memRead = 1;    
        end
        4'b0110: begin		//Read 1
            nextState = 4'b0111;
            Stall = 1;
            bank = 2'b10;
            memRead = 1;
            cacheDataIn = memDataOut;
            write = 1;
            cacheOffset = 3'b000;
        end
        4'b0111: begin		//Read 2
            nextState = 4'b1000;
            Stall = 1;
            bank = 2'b11;
            memRead = 1;
            cacheDataIn = memDataOut;
            write = 1;
            cacheOffset = 3'b010;
        end
        4'b1000: begin		//Read 3
            nextState = 4'b1001;
            Stall = 1;
            cacheDataIn = memDataOut;
            write = 1;
            cacheOffset = 3'b100;
        end
        4'b1001: begin		//Wb 2    
            nextState = 4'b1010;
            Stall = 1;
            cacheDataIn = memDataOut;
            write = 1;
            cacheOffset = 3'b110;
        end
        4'b1010: begin		//Wb 3
            nextState = 4'b0000;
            Stall = 1;
            done = 1;
            comp = 1;
            write = wrLatch;
        end
        4'b1011: FSMErr = 1;	//ERR        
        default: FSMErr = 1;
    endcase  
end

endmodule

module cache_controller (//input
			clk, rst, addrIn, dataIn, readIn, writeIn, dirtyIn, hitIn,
			validIn,
			//output
			addrOut, dataOut, cacheOffset, memOffset, comp, cacheWrite,
			memWrite, memRead, cacheDataSrc, memTagSrc, cacheEnable,
			stall, err, getCache, done
			);

input clk, rst;
input [15:0] addrIn, dataIn;  //input address and data
input readIn, writeIn;   // cache input signal
input [1:0] dirtyIn, hitIn, validIn;    //cache output signal

output [15:0] addrOut, dataOut;      //address and data output 

output reg [2:0] cacheOffset, memOffset;   

output reg  comp, cacheWrite, memWrite, memRead;

output reg cacheDataSrc;  //which  source cache input data use, 0 from input, 1 from memory
output reg memTagSrc;     // which source the tag part of memory address uses, 0 from input, 1 from cache

output reg [1:0] cacheEnable;
output reg stall, err;
output reg getCache;       //1 if successfuly get data from cache to output
output reg done;           //one cycle before return to idle state

wire [3:0] currentState;
reg [3:0] nextState;
wire currentWrite, currentRead;        //store cache read and write signal

wire victimway_out, victimway_tmp;
reg victimway_in;

reg regEnable;

//convert from current state to next state
dff statechange [3:0]  (.q(currentState), .d(nextState), .clk(clk), .rst(rst));

//convert victimway
assign victimway_tmp = (rst == 1)? 1'b0 : victimway_in;
dff victimway (.q(victimway_out), .d(victimway_tmp), .clk(clk), .rst(rst));

//keep saving write, read, data, addr for future cycle, therefore only enable for idle state and save it for future state
register_1b regwrite(.clk(clk), .rst(rst), .en(regEnable), .in(writeIn), .out(currentWrite));
register_1b regread(.clk(clk), .rst(rst), .en(regEnable), .in(readIn), .out(currentRead));
register_16b regdata(.clk(clk), .rst(rst), .en(regEnable), .in(dataIn), .out(dataOut));
register_16b regaddr(.clk(clk), .rst(rst), .en(regEnable), .in(addrIn), .out(addrOut));




always @(readIn or writeIn or currentState) begin
    casex (currentState)
        4'b0000:begin      //idle state, initilization
            getCache = 0;    
            done = 0;  
            stall = 0;
            regEnable = 1;
            memWrite = 0;
            memRead = 0;
            nextState = (readIn | writeIn) ? 4'b0001 : 4'b0000;
            victimway_in = victimway_out;
            cacheEnable = (readIn | writeIn) ? 2'b11 : 2'b00;
        end
        4'b0001:begin     //compare state
            stall = 1;
            regEnable = 0;
            cacheOffset = addrOut[2:0];      //cache offset comes from the input
            comp = 1;
            cacheWrite = currentWrite;
            victimway_in = ~victimway_out;
            getCache = ((hitIn[0] & validIn[0]) | (hitIn[1] & validIn[1]));      //if succesfully fetch data
            done = getCache;
            nextState = getCache? 4'b0000 : 4'b0010;
        end
        4'b0010 : begin // enable
        cacheEnable = (~validIn[0]) ? 2'b01 :
        	      (~validIn[1]) ? 2'b10 :
        	      (victimway_out) ? 2'b10 : 2'b01;
        nextState = ((cacheEnable[0] & validIn[0] & dirtyIn[0]) | 
                    (cacheEnable[1] & validIn[1] & dirtyIn[1])) ? 4'b0011 : 4'b0111;
        	    
        end
        4'b0011 : begin        // read0
            cacheOffset = 3'b000;
            memOffset = 3'b000;
            comp = 0;
            cacheWrite = 0;
            memTagSrc = 1;             // the address of memory consists of tag from cache instead of address in
            memWrite = 1;
            memRead = 0;
            nextState = 4'b0100;
        end
        4'b0100: begin       //read1
            cacheOffset = 3'b010;
            memOffset = 3'b010;
            nextState = 4'b0101;
        end
        4'b0101: begin       //read2
            cacheOffset = 3'b100;
            memOffset = 3'b100;
            nextState = 4'b0110;
        end
        4'b0110: begin       //read3
            cacheOffset = 3'b110;
            memOffset = 3'b110;
            nextState = 4'b0111;
        end
        // fetch data from memory to cache, either cache is not valid or (clean and not hit),
        // or afther written dirty cache to memory
        4'b0111: begin        //write0    read from memory but can not still get the data
            memRead = 1;
            memWrite = 0;
            memTagSrc = 0;        //the tag of the memory address come from input address
            memOffset = 3'b000;
            nextState = 4'b1000;
        end
        4'b1000: begin       //write1     read from memory but can not still get the data
            memOffset = 3'b010;
            nextState = 4'b1001;
        end
        4'b1001: begin       //write2     read from memory and already get data after two cycle
            comp = 0;
            cacheWrite = 1;
            memOffset = 3'b100;
            cacheOffset = 3'b000;
            nextState = 4'b1010;
            cacheDataSrc = 1;              // the data written to cache come from memory
        end
        4'b1010: begin        //write3
            memOffset = 3'b110;
            cacheOffset = 3'b010;
            nextState = 4'b1011;
        end
        4'b1011: begin        //write4        finish fetching data from memory, still writing to cache
            memRead = 0;
            cacheOffset = 3'b100;
            nextState = 4'b1100;
        end
        4'b1100: begin        //write4        finish fetching data from memory, still writing to cache
            cacheOffset = 3'b110;
            nextState = 4'b1101;
        end
        4'b1101: begin        //fetch new cache data
            cacheWrite = currentWrite;
            cacheDataSrc = 0;                // the data wrte to cache come from input
            comp= 1;
            cacheOffset = addrOut[2:0];
            nextState = 4'b1110;
        end
        4'b1110: begin
            done = 1;
            nextState = 4'b0000;
        end


        default: begin
            nextState = 4'b0000;
        end
    endcase
    
end

// always @(readIn or writeIn or currentState) begin
//     $display("currentstate : %b , nextState : %b readIn : %b, writeIn : %b cacheWrite: %b currentWrite: %b done : %d, offset : %b", currentState, nextState, readIn, writeIn, cacheWrite, currentWrite, done, cacheOffset);
// end

endmodule

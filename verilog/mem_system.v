/* $Author: karu $ */
/* $LastChangedDate: 2009-04-24 09:28:13 -0500 (Fri, 24 Apr 2009) $ */
/* $Rev: 77 $ */

module mem_system(/*AUTOARG*/
   // Outputs
   DataOut, Done, Stall, CacheHit, err, 
   // Inputs
   Addr, DataIn, Rd, Wr, createdump, clk, rst
   );
   
   input [15:0] Addr;
   input [15:0] DataIn;
   input        Rd;
   input        Wr;
   input        createdump;
   input        clk;
   input        rst;
   
   output [15:0] DataOut;
   output Done;
   output Stall;
   output CacheHit;
   output err;
   
   output [15:0] DataOut;
   output Done;
   output Stall;
   output CacheHit;
   output err;

   wire [4:0] cacheTagOut, cacheTagOut0, cacheTagOut1;
   wire [1:0] cacheHitOut, cacheDirtyOut, cacheValidOut, cacheErrOut;
   wire [1:0] cacheEnable;
   
   wire [15:0] ccDataOut;
   wire [15:0] ccAddrOut;
   
   wire [2:0] memOffset;
   wire [2:0] cacheOffset;
   
   wire [15:0] cacheDataIn;
   wire comp, cacheWrite;
   wire [15:0] memDataOut;
   wire memErr;
   wire [15:0] memAddress;
   wire [15:0] cacheDataOut, cacheDataOut0, cacheDataOut1;
   wire memWrite, memRead;
   wire cacheDataSrc, memTagSrc;

   /* data_mem = 1, inst_mem = 0 *
    * needed for cache parameter */
   parameter memtype = 0;
   cache #(0 + memtype) c0(// Outputs
                          .tag_out              (cacheTagOut0),
                          .data_out             (cacheDataOut0),
                          .hit                  (cacheHitOut[0]),
                          .dirty                (cacheDirtyOut[0]),
                          .valid                (cacheValidOut[0]),
                          .err                  (cacheErrOut[0]),
                          // Inputs
                          .enable               (cacheEnable[0]),
                          .clk                  (clk),
                          .rst                  (rst),
                          .createdump           (createdump),
                          .tag_in               (ccAddrOut[15:11]),
                          .index                (ccAddrOut[10:3]),
                          .offset               (cacheOffset),
                          .data_in              (cacheDataIn),
                          .comp                 (comp),
                          .write                (cacheWrite),
                          .valid_in             (1'b1));
   cache #(2 + memtype) c1(// Outputs
                          .tag_out              (cacheTagOut1),
                          .data_out             (cacheDataOut1),
                          .hit                  (cacheHitOut[1]),
                          .dirty                (cacheDirtyOut[1]),
                          .valid                (cacheValidOut[1]),
                          .err                  (cacheErrOut[1]),
                          // Inputs
                          .enable               (cacheEnable[1]),
                          .clk                  (clk),
                          .rst                  (rst),
                          .createdump           (createdump),
                          .tag_in               (ccAddrOut[15:11]),
                          .index                (ccAddrOut[10:3]),
                          .offset               (cacheOffset),
                          .data_in              (cacheDataIn),
                          .comp                 (comp),
                          .write                (cacheWrite),
                          .valid_in             (1'b1));
   
   assign cacheDataOut = (cacheEnable[0]) ? cacheDataOut0 : cacheDataOut1;
   
   four_bank_mem mem(// Outputs
                     .data_out          (memDataOut),
                     .stall             (),
                     .busy              (),
                     .err               (memErr),
                     // Inputs
                     .clk               (clk),
                     .rst               (rst),
                     .createdump        (createdump),
                     .addr              (memAddress),
                     .data_in           (cacheDataOut),
                     .wr                (memWrite),
                     .rd                (memRead));
   
   // your code here
   cache_controller cc(//input
                       .clk		(clk),
                       .rst		(rst),
                       .addrIn		(Addr),
                       .dataIn  	(DataIn),
                       .readIn		(Rd),
                       .writeIn		(Wr),
                       .dirtyIn		(cacheDirtyOut),
                       .hitIn		(cacheHitOut),
                       .validIn		(cacheValidOut),
                       //output
                       .addrOut		(ccAddrOut),
                       .dataOut 	(ccDataOut),
                       .cacheOffset	(cacheOffset),
                       .memOffset	(memOffset),
                       .comp		(comp),
                       .cacheWrite	(cacheWrite),
                       .memWrite	(memWrite),
                       .memRead		(memRead),
                       .cacheDataSrc	(cacheDataSrc),
                       .memTagSrc	(memTagSrc),
                       .cacheEnable	(cacheEnable),
                       .stall		(Stall),
                       .err		(err),
                       .getCache	(CacheHit),
                       .done		(Done));

   mux2_1 muxdata [15:0] (.A	(ccDataOut),
   			  .B	(memDataOut),
   			  .S	(cacheDataSrc),
   			  .O	(cacheDataIn));
   
   assign cacheTagOut = (cacheEnable[0]) ? cacheTagOut0 : cacheTagOut1;
   
   mux2_1 muxmem [4:0] (.A	(ccAddrOut[15:11]),
   			.B	(cacheTagOut),
   			.S	(memTagSrc),
   			.O	(memAddress[15:11]));
   
   assign memAddress[10:3] = ccAddrOut[10:3];
   assign memAddress[2:0] = memOffset;
   assign DataOut = (cacheEnable[0] & cacheHitOut[0] & cacheValidOut[0]) ? 
		     cacheDataOut0 : cacheDataOut1;
   
endmodule // mem_system

`default_nettype wire   

// DUMMY LINE FOR REV CONTROL :9:

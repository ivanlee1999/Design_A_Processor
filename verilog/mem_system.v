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
   
   //cache input
   wire cacheHit0, cacheHit1;
   wire cacheValid0, cacheValid1;
   wire cacheDirty0, cacheDirty1;
   wire cacheWrite0, cacheWrite1;
   
   wire memHit, memValid, memDirty;
   wire action, trueHit, validWrite, trueMiss, invalidMiss,
   validNoWrite, READ, WRITE, cacheSel;
   
   //err
   wire memErr, cacheErr0, cacheErr1;
   
   //cache_controller
   wire FSMErr;
   wire memWrite, memRead;
   wire done, comp, latch, cacheHit, flip, write;
   wire [1:0] bank;
   wire [2:0] cacheOffset;
   
   //cache
   wire [15:0] cacheDataIn;
   
   wire [4:0] cacheTagOut0, cacheTagOut1, cacheTagOut;
   
   wire [15:0] memAddress, cacheDataOut, cacheDataOut0, cacheDataOut1;
   wire [15:0] memDataOut, addrLatch, dataInLatch;
   wire wrLatch, rdLatch;
   
   //victimway
   wire victim, victimway;
   

   /* data_mem = 1, inst_mem = 0 *
    * needed for cache parameter */
   parameter memtype = 0;
   cache #(0 + memtype) c0(// Outputs
                          .tag_out              (cacheTagOut0),
                          .data_out             (cacheDataOut0),
                          .hit                  (cacheHit0),
                          .dirty                (cacheDirty0),
                          .valid                (cacheValid0),
                          .err                  (cacheErr0),
                          // Inputs
                          .enable               (1'b1),
                          .clk                  (clk),
                          .rst                  (rst),
                          .createdump           (createdump),
                          .tag_in               (addrLatch[15:11]),
                          .index                (addrLatch[10:3]),
                          .offset               (cacheOffset),
                          .data_in              (cacheDataIn),
                          .comp                 (comp),
                          .write                (cacheWrite0),
                          .valid_in             (1'b1));
                          
   cache #(1 + memtype) c1(// Outputs
                          .tag_out              (cacheTagOut1),
                          .data_out             (cacheDataOut1),
                          .hit                  (cacheHit1),
                          .dirty                (cacheDirty1),
                          .valid                (cacheValid1),
                          .err                  (cacheErr1),
                          // Inputs
                          .enable               (1'b1),
                          .clk                  (clk),
                          .rst                  (rst),
                          .createdump           (createdump),
                          .tag_in               (addrLatch[15:11]),
                          .index                (addrLatch[10:3]),
                          .offset               (cacheOffset),
                          .data_in              (cacheDataIn),
                          .comp                 (comp),
                          .write                (cacheWrite1),
                          .valid_in             (1'b1));
   
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
   
   dff donedff(.q(Done), .d(done), .clk(clk), .rst(rst));
   dff hitdff(.q(CacheHit), .d(cacheHit), .clk(clk), .rst(rst));
   dff victimdff(.q(victimway), .d(victim), .clk(clk), .rst(rst));
   
   assign addrLatch = (latch) ? Addr : addrLatch;
   assign dataInLatch = (latch) ? DataIn : dataInLatch;
   assign wrLatch = (latch) ? Wr : wrLatch;
   assign rdLatch = (latch) ? Rd : rdLatch;
   
   assign err = (memErr | cacheErr0 | cacheErr1 | FSMErr) && action;
   assign cacheSel = (cacheHit1) ? 1 :  
                     (cacheHit0) ? 0 : 
                     (~cacheValid0) ? 0 : 
                     (~cacheValid1) ? 1 : victim;
   
   assign action = wrLatch | rdLatch;
   assign memHit = (cacheSel) ? cacheHit1 : cacheHit0;
   assign memValid = (cacheSel) ? cacheValid1 : cacheValid0;
   assign memDirty = (cacheSel) ? cacheDirty1 : cacheDirty0;
   
   assign trueHit = memHit & memValid;
   assign validWrite = ~memHit & memValid & memDirty;
   assign trueMiss = ~memHit & ~memValid;
   assign invalidMiss = memHit & ~memValid;
   assign validNoWrite = ~memHit & memValid & ~memDirty;
   
   assign WRITE = action & validWrite;
   assign READ = action & ((trueMiss) | (invalidMiss) | (validNoWrite));
   
   assign memAddress = {(memWrite) ? cacheTagOut : addrLatch[15:11], addrLatch[10:3], bank, 1'b0};
   assign victim = (flip) ? ~victimway : victimway;
   assign cacheDataOut = (cacheSel) ? cacheDataOut1 : cacheDataOut0;
   assign cacheTagOut = (cacheSel) ? cacheTagOut1 : cacheTagOut0;
   assign DataOut = cacheDataOut;
   assign cacheWrite0 = ~cacheSel & write;
   assign cacheWrite1 = cacheSel & write;
   
   cache_controller cc (//input
                       .clk		(clk),
                       .rst		(rst),
                       .addrLatch	(addrLatch),
                       .dataInLatch  	(dataInLatch),
                       .action		(action),
                       .trueHit		(trueHit),
                       .WRITE		(WRITE),
                       .READ		(READ),
                       .wrLatch		(wrLatch),
                       .memDataOut	(memDataOut),
                       //output
                       .FSMErr		(FSMErr),
                       .done	 	(done),
                       .cacheHit	(cacheHit),
                       .comp		(comp),
                       .latch		(latch),
                       .Stall		(Stall),
                       .memWrite	(memWrite),
                       .write		(write),
                       .memRead		(memRead),
                       .bank		(bank),
                       .cacheOffset	(cacheOffset),
                       .cacheDataIn	(cacheDataIn),
                       .flip		(flip));
 
endmodule // mem_system  

// DUMMY LINE FOR REV CONTROL :9:

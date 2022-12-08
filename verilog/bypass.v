module bypass (
    readData, writeEn, writeData, writeRegSel, readRegSel, regfiledata
);
output readData;
input writeEn, writeData,  regfiledata;
input[2:0] writeRegSel;
input[2:0] readRegSel;

assign readData = (writeEn & (writeRegSel == readRegSel) & writeData) | (writeEn & (writeRegSel != readRegSel) & regfiledata) | ((!writeEn) & regfiledata) ;
    
endmodule
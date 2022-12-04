lbi r1, 100
lbi r2, 22
lbi r3, 31
add r4, r2, r3
subi r5, r2, 22
beqz r5, 14
halt
roli r4, r3, 50
lbi r4, 30
lbi r2, 30
j -14
halt       
                                        

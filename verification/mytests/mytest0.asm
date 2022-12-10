// seed 1
lbi r0, 10 // icount 0
slbi r0, 116 // icount 1
lbi r1, 213 // icount 2
slbi r1, 86 // icount 3
lbi r2, 144 // icount 4
slbi r2, 0 // icount 5
lbi r3, 48 // icount 6
slbi r3, 253 // icount 7
lbi r4, 192 // icount 8
slbi r4, 93 // icount 9
lbi r5, 89 // icount 10
slbi r5, 146 // icount 11
lbi r6, 33 // icount 12
slbi r6, 16 // icount 13
lbi r7, 243 // icount 14
slbi r7, 39 // icount 15
lbi r6, 0 // icount 16
lbi r1, 0 // icount 17
nop // to align branch icount 18
beqz r4, 8 // icount 19
ror r7, r7, r2 // icount 20
slli r5, r7, 3 // icount 21
addi r7, r0, 1 // icount 22
andni r3, r5, 8 // icount 23
sll r6, r5, r5 // icount 24
roli r5, r7, 2 // icount 25
andni r3, r3, 1 // icount 26
ld r4, r3, 6 // icount 27
sco r5, r2, r4 // icount 28
lbi r1, 0 // icount 29
lbi r0, 0 // icount 30
bltz r2, 24 // icount 31
andni r4, r4, 1 // icount 32

lbi r0, 10
slbi r0, 116
lbi r1, 213
slbi r1, 86
lbi r2, 144
slbi r2, 0
lbi r3, 48
slbi r3, 253
lbi r4, 192
slbi r4, 93
lbi r5, 89
slbi r5, 146
lbi r6, 33
slbi r6, 16
lbi r7, 243
slbi r7, 39
lbi r6, 0
lbi r1, 0
nop
beqz r4, 8
ror r7, r7, r2
slli r5, r7, 3
addi r7, r0, 1
andni r3, r5, 8
sll r6, r5, r5
roli r5, r7, 2
andni r3, r3, 1
ld r4, r3, 6
sco r5, r2, r4
lbi r1, 0
lbi r0, 0
bltz r2, 24
andni r4, r4, 1

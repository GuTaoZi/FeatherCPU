.macro input(%addr, %name1) # using: t2, t6
	addi t6, zero, 1
	sw t6, 4(s11)
%name1 :
	lw t2, 12(s11)
	bne t2, t6, %name1

	lw %addr, 0(s11)

	sw zero, 4(s11)
	sw zero, 12(s11)
.end_macro
.text
	addi s11, zero, 255
	slli s11, s11, 8
	addi s11, s11, 192 # s11: MMIO base addr
	# s11 + 0 -> keybd
	# s11 + 4 -> led
	# s11 + 8 -> switch
	# s11 + 12 -> ack_btn

	input(s0, inp1)
	input(s1, inp2)
	
	add t0, zero, zero #0
	
	beq s0, s1, eq1 #8
	addi t0, t0, 1
eq1:
	bne s0, s1, ne2
	addi t0, t0, 2
ne2:
	sw t0, 4(s11)
	
lp:	jal lp

.macro input(%addr, %name1) # using: t2, t6
	addi t6, zero, 1
	add zero, zero, zero
	sw t6, 4(s11)
%name1 :
	add zero, zero, zero
	lw t2, 12(s11)
	add zero, zero, zero
	bne t2, t6, %name1
	add zero, zero, zero

	lw %addr, 0(s11)

	add zero, zero, zero
	sw zero, 4(s11)
	sw zero, 12(s11)
	add zero, zero, zero
.end_macro
.text
	addi s11, zero, 255
	slli s11, s11, 8
	addi s11, s11, 192 # s11: MMIO base addr
	# s11 + 0 -> keybd
	# s11 + 4 -> led
	# s11 + 8 -> switch
	# s11 + 12 -> ack_btn
	
	input(s0, ip1)
	
	addi t0, zero, 0
	addi t1, zero, 1
lp:
	add zero, zero, zero
	add t2, t0, t1
	add t0, t1, zero
	add t1, t2, zero
	addi s0, s0, -1
	add zero, zero, zero
	bne s0, zero, lp
	
	sw t1, 4(s11)
	add zero, zero, zero
pp:	jal pp
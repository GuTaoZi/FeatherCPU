.text
	addi s11, zero, 255
	slli s11, s11, 8
	addi s11, s11, 192 # s11: MMIO base addr
	# s11 + 0 -> keybd
	# s11 + 4 -> led
	# s11 + 8 -> switch
	# s11 + 12 -> ack_btn
	
	
lp0:
	addi t1, zero, 24
	addi t0, zero, 1
lp1:
	add zero, zero, zero
	sw t0, 4(s11)
	add zero, zero, zero
	slli t0, t0, 1
	addi t2, zero, 1
	lw t4, 8(s11)
	sll t2, t2, t4
lp2:
	add zero, zero, zero
	addi t2, t2, -1
	add zero, zero, zero
	bne t2, zero, lp2
	add zero, zero, zero
	addi t1, t1, -1
	add zero, zero, zero
	bne t1, zero, lp1
	add zero, zero, zero
	jal lp0
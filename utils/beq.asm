.text
	addi s11, zero, 255
	slli s11, s11, 8
	addi s11, s11, 192 # s11: MMIO base addr
	# s11 + 0 -> keybd
	# s11 + 4 -> led
	# s11 + 8 -> switch
	# s11 + 12 -> ack_btn
	
	lw t0, 4(s11)
	addi t0, t0, 5
	sw t0, 4(s11)

lp:	jal lp
.macro input(%addr, %name1) # using: t2, t6
	addi t6, x0, 1
	add x0, x0, x0
	sw t6, 4(s11)
%name1 :
	add x0, x0, x0
	lw t2, 12(s11)
	add x0, x0, x0
	bne t2, t6, %name1
	add x0, x0, x0

	lw %addr, 0(s11)

	add x0, x0, x0
	sw x0, 4(s11)
	sw x0, 12(s11)
	add x0, x0, x0
.end_macro
.text
	addi s11, zero, 255
	slli s11, s11, 8
	addi s11, s11, 192 # s11: MMIO base addr
	# s11 + 0 -> keybd
	# s11 + 4 -> led
	# s11 + 8 -> switch
	# s11 + 12 -> ack_btn
	input(x6, ipx6)
	addi x7, x0, 1
	
	add x12, x0, x0
	addi x13, x0, 1
	addi x14, x0, 1
	addi x15, x0, 1
	
	addi x24, x0, 1
	add x25, x0, x0
	add x26, x0, x0
	addi x27, x0, 1

loop:
	add x0, x0, x0
	beq x6, x0, done
	add x0, x0, x0
	
	add x16, x0, x12
	add x17, x0, x13
	add x18, x0, x14
	add x19, x0, x15
	
	and x5, x6, x7
	add x0, x0, x0
	bne x5, x7, skip
	add x0, x0, x0
	
	mul x20, x24, x16
	mul x21, x25, x18
	add x28, x20, x21
	
	mul x20, x24, x17
	mul x21, x25, x19
	add x29, x20, x21
	
	mul x20, x26, x16
	mul x21, x27, x18
	add x30, x20, x21
	
	mul x20, x26, x17
	mul x21, x27, x19
	add x31, x20, x21
	
	add x24, x0, x28
	add x25, x0, x29
	add x26, x0, x30
	add x27, x0, x31
skip:
	add x0, x0, x0
	srl x6, x6, x7
	
	mul x20, x16, x16
	mul x21, x17, x18
	add x12, x20, x21
	
	mul x20, x16, x17
	mul x21, x17, x19
	add x13, x20, x21
	
	mul x20, x18, x16
	mul x21, x19, x18
	add x14, x20, x21
	
	mul x20, x18, x17
	mul x21, x19, x19
	add x15, x20, x21
	
	jal x1, loop
	
done:
	add x0, x0, x0
	add x10, x0, x26
	add x0, x0, x0
	addi s11, zero, 255
	slli s11, s11, 8
	addi s11, s11, 192 # s11: MMIO base addr
	add x0, x0, x0
	# s11 + 0 -> keybd
	# s11 + 4 -> led
	# s11 + 8 -> switch
	# s11 + 12 -> ack_btn
	sw x10, 4(s11)
xp:	jal xp
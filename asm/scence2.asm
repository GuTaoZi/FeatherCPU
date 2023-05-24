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
	addi t1, zero, 1
	slli s10, t1, 16    # s10: end mask
	
	addi s11, zero, 255
	slli s11, s11, 16
	addi s11, s11, 192 # s11: MMIO base addr
	# s11 + 0 -> keybd
	# s11 + 4 -> led
	# s11 + 8 -> switch
	# s11 + 12 -> ack_btn

	lw t3, 8(s11)
	
	andi t3, t3, 7
	add t4, zero, zero
	beq t3, t4, case0
	addi t4, t4, 1
	beq t3, t4, case1
	addi t4, t4, 1
	beq t3, t4, case2
	addi t4, t4, 1
	beq t3, t4, case3
	addi t4, t4, 1
	beq t3, t4, case4
	addi t4, t4, 1
	beq t3, t4, case5
	addi t4, t4, 1
	beq t3, t4, case6
	addi t4, t4, 1
	beq t3, t4, case7
	jal end
	
case0:
		input(s0, case0_1)
		addi s1, zero, 1
		slli s1, s1, 7
		and s2, s1, s0
		beq s1, s2, case0_err
		add s1, zero, zero # i = 0
		add s2, zero, zero # sum = 0
	case0_loop1:
		addi s1, s1, 1
		add s2, s2, s1
		bne s1, s0, case0_loop1
		sw s2, 2(s11)
		jal end
	case0_err:
		add s1, zero, zero
		addi s2, zero, 1
		slli s2, s2, 20
	edl_lop:
		addi s1, s1, 1
		and s3, s1, s2
		beq s3, s2, lit
		sw zero, 2(s11)
		jal edl_lop
	lit:	sw s0, 2(s11)
		jal edl_lop
case1:
		jal end
case2:
		jal end
case3:
		jal end
case4:
		input(s0, case4_1)
		input(s1, case4_3)
		andi s0, s0, 255
		andi s1, s1, 255
		andi s2, s0, 128 # s2 = sign of s0
		andi s3, s0, 128 # s3 = sign of s1
		add s4, s0, s1
		andi s4, s4, 255
		andi s5, s4, 128 # s5 = sign of s0+s1
		
		bne s2, s3, case4_fail
		beq s3, s5, case4_fail
		addi s6, zero, 1
		slli s6, s6, 8
		or s6, s6, s4
		sw s6, 2(s11)
		jal end
	case4_fail: # no overflow
		sw s6, 2(s11)
		jal end
case5:
		input(s0, case5_1)
		input(s1, case5_3)
		andi s0, s0, 255
		andi s1, s1, 255
		andi s2, s0, 128 # s2 = sign of s0
		andi s3, s0, 128 # s3 = sign of s1
		sub s4, s0, s1
		andi s4, s4, 255
		andi s5, s4, 128 # s5 = sign of s0+s1
		
		beq s2, s3, case5_fail
		beq s2, s5, case5_fail
		addi s6, zero, 1
		slli s6, s6, 8
		or s6, s6, s4
		sw s6, 2(s11)
		jal end
	case5_fail: # no overflow
		sw s6, 2(s11)
		jal end
case6:
		input(s0, case6_1)
		input(s1, case6_3)
		andi s0, s0, 255
		andi s1, s1, 255
		mul s2, s0, s1
		sw s2, 2(s11)
		jal end
case7:
		input(s0, case7_1)
		input(s1, case7_3)
		andi s0, s0, 255
		andi s1, s1, 255
		div s4, s0, s1
		rem s5, s0, s1
		
		add s1, zero, zero
		addi s2, zero, 1
		slli s2, s2, 22
	edl_lp2:
		addi s1, s1, 1
		and s3, s1, s2
		beq s3, s2, remin
		sw s4, 2(s11)
		jal edl_lp2
	remin:	sw s5, 2(s11)
		jal edl_lp2

end:	jal end

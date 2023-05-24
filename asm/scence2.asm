.macro input(%addr, %shift, %name1, %name2) # using: t2, t6
%name1:
	lw %addr, %shift(s11)
	and t2, %addr, s10
	bne t2, s10, %name1
%name2:
	lw t6, %shift(t1)
	and t2, t6, s10
	beq t2, s10, %name2
.end_macro
.text
	addi t1, zero, 1
	slli s10, t1, 16    # s10: end mask
	
	addi s11, zero, 63
	slli s11, s11, 8
	addi s11, s11, 240 # s11: MMIO base addr

	input(t3, 4, ip1lp1, ip1lp2)
	
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
		input(s0, 0, case0_1, case0_2)
		addi s1, zero, 1
		sll s1, s1, 7
		andi s2, s1, s0
		beq s1, s2, case0_err
		addi s1, zero, zero # i = 0
		addi s2, zero, zero # sum = 0
	case0_loop1:
		addi s1, s1, 1
		add s2, s2, s1
		bne s1, s0, case0_loop1
		sw s2, 2(s11)
		jal end
	case0_err:
		add s1, zero, zero
		addi s2, zero, 1
		sll s2, s2, 20
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
		input(s0, 0, case4_1, case4_2)
		input(s1, 0, case4_3, case4_4)
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
		input(s0, 0, case4_1, case4_2)
		input(s1, 0, case4_3, case4_4)
		andi s0, s0, 255
		andi s1, s1, 255
		andi s2, s0, 128 # s2 = sign of s0
		andi s3, s0, 128 # s3 = sign of s1
		sub s4, s0, s1
		andi s4, s4, 255
		andi s5, s4, 128 # s5 = sign of s0+s1
		
		beq s2, s3, case5_fail
		beq s3, s5, case5_fail
		addi s6, zero, 1
		slli s6, s6, 8
		or s6, s6, s4
		sw s6, 2(s11)
		jal end
	case5_fail: # no overflow
		sw s6, 2(s11)
		jal end

end:	jal end
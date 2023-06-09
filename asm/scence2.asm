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

	lw t3, 8(s11)
	
	andi t3, t3, 7
	add t4, zero, zero
	add zero, zero, zero
	beq t3, t4, case0
	add zero, zero, zero
	addi t4, t4, 1
	add zero, zero, zero
	beq t3, t4, case1
	add zero, zero, zero
	addi t4, t4, 1
	add zero, zero, zero
	beq t3, t4, case2
	add zero, zero, zero
	addi t4, t4, 1
	add zero, zero, zero
	beq t3, t4, case3
	add zero, zero, zero
	addi t4, t4, 1
	add zero, zero, zero
	beq t3, t4, case4
	add zero, zero, zero
	addi t4, t4, 1
	add zero, zero, zero
	beq t3, t4, case5
	add zero, zero, zero
	addi t4, t4, 1
	add zero, zero, zero
	beq t3, t4, case6
	add zero, zero, zero
	addi t4, t4, 1
	add zero, zero, zero
	beq t3, t4, case7
	add zero, zero, zero
	jal end
	
case0:
		add zero, zero, zero
		input(s0, case0_1)
		addi s1, zero, 1
		slli s1, s1, 7
		and s2, s1, s0
		add zero, zero, zero
		beq s1, s2, case0_err
		add zero, zero, zero
		add s1, zero, zero # i = 0
		add s2, zero, zero # sum = 0
	case0_loop1:
		add zero, zero, zero
		addi s1, s1, 1
		add s2, s2, s1
		add zero, zero, zero
		bne s1, s0, case0_loop1
		add zero, zero, zero
		sw s2, 4(s11)
		add zero, zero, zero
		jal end
	case0_err:
		add zero, zero, zero
		add s1, zero, zero
		addi s2, zero, 1
		slli s2, s2, 20
	edl_lop:
		addi s1, s1, 1
		and s3, s1, s2
		add zero, zero, zero
		beq s3, s2, lit
		add zero, zero, zero
		add zero, zero, zero
		sw zero, 4(s11)
		add zero, zero, zero
		jal edl_lop
		add zero, zero, zero
	lit:	sw s0, 4(s11)
		add zero, zero, zero
		jal edl_lop
case1:
		add zero, zero, zero
		input(s0, case1_0)
		add a0, zero, s0
		add a2, zero, zero
		add a7, zero, zero
		jal ra, case1_rec
		add zero, zero, zero
		sw a2, 4(s11)
		add zero, zero, zero
		jal end
case1_rec:
		addi sp, sp, -8
		add zero, zero, zero
		sw ra, 0(sp)
		sw a0, 4(sp)
		add zero, zero, zero
		addi a2, a2, 1
		
		add zero, zero, zero
		beq a0, zero, case1_rec_end
		add zero, zero, zero
		addi a0, a0, -1
		jal ra, case1_rec
		lw a0, 4(sp)
		add a7, a7, a0
case1_rec_end:
		add zero, zero, zero
		addi a2, a2, 1
		lw ra, 0(sp)
		addi sp, sp, 8
		jalr ra

show_case:
		add zero, zero, zero
		sw a2, 4(s11)
		add zero, zero, zero
		add t6, zero, zero
		addi t5, zero, 1
		slli t5, t5, 22
		
	s_c_1:	add zero, zero, zero
		addi t5, t5, -1
		bne t5, zero, s_c_1
		add zero, zero, zero
		
		sw zero, 4(s11)
		add zero, zero, zero
		jalr ra
case2:
		input(s0, case2_0)
		add a0, zero, s0
		add a7, zero, zero
		jal ra, case2_rec
		add zero, zero, zero
		sw a1, 4(s11)
		add zero, zero, zero
		jal end
case2_rec:
		addi sp, sp, -8
		add zero, zero, zero
		sw ra, 0(sp)
		sw a0, 4(sp)
		add zero, zero, zero
		add a2, zero, a0
		jal show_case
		
		add zero, zero, zero
		beq a0, zero, case2_rec_end
		add zero, zero, zero
		addi a0, a0, -1
		jal ra, case2_rec
		lw a0, 4(sp)
		add a7, a7, a0
case2_rec_end:
		add zero, zero, zero
		lw ra, 0(sp)
		addi sp, sp, 8
		jalr ra

case3:
		add zero, zero, zero
		input(s0, case3_0)
		add a0, zero, s0
		add a7, zero, zero
		jal ra, case3_rec
		sw a1, 4(s11)
		jal end
case3_rec:
		addi sp, sp, -8
		add zero, zero, zero
		sw ra, 0(sp)
		sw a0, 4(sp)
		add zero, zero, zero
		
		add zero, zero, zero
		beq a0, zero, case3_rec_end
		add zero, zero, zero
		addi a0, a0, -1
		jal ra, case3_rec
		lw a0, 4(sp)
		add a2, zero, a0
		jal show_case
		add a7, a7, a0
case3_rec_end:
		add zero, zero, zero
		lw ra, 0(sp)
		addi sp, sp, 8
		jalr ra

case4:
		add zero, zero, zero
		input(s0, case4_1)
		input(s1, case4_3)
		andi s0, s0, 255
		andi s1, s1, 255
		andi s2, s0, 128 # s2 = sign of s0
		andi s3, s1, 128 # s3 = sign of s1
		add s4, s0, s1
		andi s4, s4, 255
		andi s5, s4, 128 # s5 = sign of s0+s1
		add s6, zero, zero
		
		add zero, zero, zero
		bne s2, s3, case4_fail
		add zero, zero, zero
		beq s3, s5, case4_fail
		add zero, zero, zero
		addi s6, zero, 1
	case4_fail: # no overflow
		add zero, zero, zero
		slli s6, s6, 8
		or s6, s6, s4
		add zero, zero, zero
		sw s6, 4(s11)
		add zero, zero, zero
		jal end
case5:
		add zero, zero, zero
		input(s0, case5_1)
		input(s1, case5_3)
		andi s0, s0, 255
		andi s1, s1, 255
		andi s2, s0, 128 # s2 = sign of s0
		andi s3, s1, 128 # s3 = sign of s1
		sub s4, s0, s1
		andi s4, s4, 255
		andi s5, s4, 128 # s5 = sign of s0+s1
		add s6, zero, zero
		
		beq s2, s3, case5_fail
		add zero, zero, zero
		beq s2, s5, case5_fail
		add zero, zero, zero
		addi s6, zero, 1
	case5_fail: # no overflow
		add zero, zero, zero
		slli s6, s6, 8
		or s6, s6, s4
		add zero, zero, zero
		sw s6, 4(s11)
		add zero, zero, zero
		jal end
case6:
		add zero, zero, zero
		input(s0, case6_1)
		input(s1, case6_3)
		andi s0, s0, 255
		andi s1, s1, 255
		andi t2, s0, 128
		andi t4, s1, 128
		add zero, zero, zero
		beq t2, zero, case6_n1
		add zero, zero, zero
		xori s0, s0, 255
		xori s0, s0, -1
case6_n1:
		add zero, zero, zero
		beq t4, zero, case6_n2
		add zero, zero, zero
		xori s1, s1, 255
		xori s1, s1, -1
case6_n2:
		add zero, zero, zero
		mul s2, s0, s1
		add zero, zero, zero
		sw s2, 4(s11)
		add zero, zero, zero
		jal end
case7:
		input(s0, case7_1)
		input(s1, case7_3)
		andi s0, s0, 255
		andi s1, s1, 255
		andi t2, s0, 128
		andi t4, s1, 128
		add zero, zero, zero
		beq t2, zero, case7_n1
		add zero, zero, zero
		xori s0, s0, 255
		xori s0, s0, -1
case7_n1:
		add zero, zero, zero
		beq t4, zero, case7_n2
		add zero, zero, zero
		xori s1, s1, 255
		xori s1, s1, -1
case7_n2:
		add zero, zero, zero
		div s4, s0, s1
		rem s5, s0, s1
		
		add s1, zero, zero
		addi s2, zero, 1
		slli s2, s2, 22
	edl_lp2:
		addi s1, s1, 1
		and s3, s1, s2
		add zero, zero, zero
		beq s3, s2, remin
		add zero, zero, zero
		sw s4, 4(s11)
		jal edl_lp2
	remin:	
		add zero, zero, zero
		sw s5, 4(s11)
		add zero, zero, zero
		jal edl_lp2

end:	jal end

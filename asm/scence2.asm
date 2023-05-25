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
		input(s0, case1_0)
		add a0, zero, s0
		add a2, zero, zero
		add a7, zero, zero
		jal ra, case1_rec
		sw a2, 4(s11)
		jal end
case1_rec:
		addi sp, sp, -8
		sw ra, 0(sp)
		sw a0, 4(sp)
		addi a2, a2, 1
		
		beq a0, zero, case1_rec_end
		addi a0, a0, -1
		jal ra, case1_rec
		lw a0, 4(sp)
		add a7, a7, a0
case1_rec_end:
		addi a2, a2, 1
		lw ra, 0(sp)
		addi sp, sp, 8
case1_rec_end:	jalr ra

show_case:
		sw a2, 4(s11)
		add t6, zero, zero
		addi t5, zero, 1
		slli t5, t5, 22
		
	s_c_1:	addi t5, t5, -1
		bne t5, zero, s_c_1
		
		sw zero, 4(s11)
		jalr ra
case2:
		input(s0, case2_0)
		add a0, zero, s0
		add a7, zero, zero
		jal ra, case2_rec
		sw a1, 4(s11)
		jal end
case2_rec:
		addi sp, sp, -8
		sw ra, 0(sp)
		sw a0, 4(sp)
		add a2, zero, a0
		jal show_case
		
		beq a0, zero, case2_rec_end
		addi a0, a0, -1
		jal ra, case2_rec
		lw a0, 4(sp)
		add a7, a7, a0
case2_rec_end:
		lw ra, 0(sp)
		addi sp, sp, 8
case2_rec_end:	jalr ra

case3:
		input(s0, case3_0)
		add a0, zero, s0
		add a7, zero, zero
		jal ra, case3_rec
		sw a1, 4(s11)
		jal end
case3_rec:
		addi sp, sp, -8
		sw ra, 0(sp)
		sw a0, 4(sp)
		
		beq a0, zero, case3_rec_end
		addi a0, a0, -1
		jal ra, case3_rec
		lw a0, 4(sp)
		add a2, zero, a0
		jal show_case
		add a7, a7, a0
case3_rec_end:
		lw ra, 0(sp)
		addi sp, sp, 8
case3_rec_end:	jalr ra

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

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
		input(t1, ip2lp1)
		andi t1, t1, 127
		add s0, t1, zero
		addi t2, zero, 1
	
	loop0:	beq t1, zero, end0
		andi t3, t1, 1
		xor t2, t2, t3
		srli t1, t1, 1
		jal loop0
	end0:
		slli t2, t2, 7
		or t2, t2, s0
		sw t2, 4(s11)
		jal end
case1:
		input(t1, ip3lp1)
		andi t1, t1, 255
		add s0, t1, zero
		addi t2, zero, 1
	
	loop1:	beq t1, zero, end1
		andi t3, t1, 1
		xor t2, t2, t3
		srli t1, t1, 1
		jal loop1
	end1:
		slli t2, t2, 8
		or t2, t2, s0
		sw t2, 4(s11)
		jal end
case2:
		input(t1, ip4lp1)
		input(t3, ip5lp1)
		andi t1, t1, 255
		andi t3, t3, 255
		or t4, t1, t3
		xori t4, t4, 255  # t4 = t1 nor t3
		andi t4, t4, 255
		slli t1, t1, 16
		slli t3, t3, 8
		or t4, t4, t1
		or t4, t4, t3
		sw t4, 4(s11)
		jal end
case3:
		input(t1, ip6lp1)
		input(t3, ip7lp1)
		andi t1, t1, 255
		andi t3, t3, 255
		or t4, t1, t3   # t4 = t1 or t3
		andi t4, t4, 255
		slli t1, t1, 16
		slli t3, t3, 8
		or t4, t4, t1
		or t4, t4, t3
		sw t4, 4(s11)
		jal end
case4:
		input(t1, ip8lp1)
		input(t3, ip9lp1)
		andi t1, t1, 255
		andi t3, t3, 255
		xor t4, t1, t3   # t4 = t1 xor t3
		andi t4, t4, 255
		slli t1, t1, 16
		slli t3, t3, 8
		or t4, t4, t1
		or t4, t4, t3
		sw t4, 4(s11)
		jal end
case5:
		input(t1, ip10lp1)
		input(t3, ip11lp1)
		andi t1, t1, 255
		andi t3, t3, 255
		sltu t4, t1, t3   # t4 = unsigned (t1 < t3)
		andi t4, t4, 255
		slli t1, t1, 16
		slli t3, t3, 8
		or t4, t4, t1
		or t4, t4, t3
		sw t4, 4(s11)
		jal end
case6:
		input(t1, ip12lp1)
		input(t3, ip13lp1)
		andi t1, t1, 255
		andi t3, t3, 255
		andi t2, t1, 128
		andi t4, t3, 128
		beq t2, zero, case6_n1
		xori t1, t1, 255
		xori t1, t1, -1
case6_n1:
		beq t4, zero, case6_n2
		xori t3, t3, 255
		xori t3, t3, -1
case6_n2:
		
		slt t4, t1, t3   # t4 = (t1 < t3)
		andi t4, t4, 255
		slli t1, t1, 16
		slli t3, t3, 8
		or t4, t4, t1
		or t4, t4, t3
		sw t4, 4(s11)
		jal end
case7:
		input(t1, ip14lp1)
		input(t3, ip15lp1)
		andi t1, t1, 255
		andi t3, t3, 255
		add t4, zero, zero
		andi t4, t4, 255
		slli t1, t1, 16
		slli t3, t3, 8
		or t4, t4, t1
		or t4, t4, t3
		sw t4, 4(s11)
		jal end

end:	jal end

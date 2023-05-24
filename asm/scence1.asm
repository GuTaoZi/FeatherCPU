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
		input(t1, 0, ip2lp1, ip2lp2)
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
		sw t2, 2(s11)
		jal end
case1:
		input(t1, 0, ip3lp1, ip3lp2)
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
		sw t2, 2(s11)
		jal end
case2:
		input(t1, 0, ip4lp1, ip4lp2)
		input(t3, 0, ip5lp1, ip5lp2)
		andi t1, t1, 255
		andi t3, t3, 255
		or t4, t1, t3
		xori t4, t4, 255  # t4 = t1 nor t3
		andi t4, t4, 255
		slli t1, t1, 16
		slli t3, t3, 8
		or t4, t4, t1
		or t4, t4, t3
		sw t4, 2(s11)
		jal end
case3:
		input(t1, 0, ip6lp1, ip6lp2)
		input(t3, 0, ip7lp1, ip7lp2)
		andi t1, t1, 255
		andi t3, t3, 255
		or t4, t1, t3   # t4 = t1 or t3
		andi t4, t4, 255
		slli t1, t1, 16
		slli t3, t3, 8
		or t4, t4, t1
		or t4, t4, t3
		sw t4, 2(s11)
		jal end
case4:
		input(t1, 0, ip8lp1, ip8lp2)
		input(t3, 0, ip9lp1, ip9lp2)
		andi t1, t1, 255
		andi t3, t3, 255
		xor t4, t1, t3   # t4 = t1 xor t3
		andi t4, t4, 255
		slli t1, t1, 16
		slli t3, t3, 8
		or t4, t4, t1
		or t4, t4, t3
		sw t4, 2(s11)
		jal end
case5:
		input(t1, 0, ip10lp1, ip10lp2)
		input(t3, 0, ip11lp1, ip11lp2)
		andi t1, t1, 255
		andi t3, t3, 255
		sltu t4, t1, t3   # t4 = unsigned (t1 < t3)
		andi t4, t4, 255
		slli t1, t1, 16
		slli t3, t3, 8
		or t4, t4, t1
		or t4, t4, t3
		sw t4, 2(s11)
		jal end
case6:
		input(t1, 0, ip12lp1, ip12lp2)
		input(t3, 0, ip13lp1, ip13lp2)
		andi t1, t1, 255
		andi t3, t3, 255
		slt t4, t1, t3   # t4 = (t1 < t3)
		andi t4, t4, 255
		slli t1, t1, 16
		slli t3, t3, 8
		or t4, t4, t1
		or t4, t4, t3
		sw t4, 2(s11)
		jal end
case7:
		input(t1, 0, ip14lp1, ip14lp2)
		input(t3, 0, ip15lp1, ip15lp2)
		andi t1, t1, 255
		andi t3, t3, 255
		add t4, zero, zero
		andi t4, t4, 255
		slli t1, t1, 16
		slli t3, t3, 8
		or t4, t4, t1
		or t4, t4, t3
		sw t4, 2(s11)
		jal end

end:	jal end
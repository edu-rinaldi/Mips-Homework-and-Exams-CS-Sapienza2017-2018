.data
mat: .word 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16

.text 
.globl main

massimoCornice:
	li $s0, 0	#max
	li $t0, 0	#y
	li $t1, 0	#x
	
	cicloR:
		beq $t0, $a1, fine_cicloR	#arriva a y=Y
		beqz $t0, cicloC		#se non sei sulla prima riga, scorrila tutta
		subi $t2, $a1, 1		
		beq $t0, $t2, cicloC		#se non sei sull'ultima riga, scorrila tutta
		#calcolo offset
		mul $s1, $t0, $a2		#X*y+0
		sll $s1, $s1, 2			# *4
		add $s1, $s1, $a0		# offset+indirizzo
		lw $s1, ($s1)			#s1 <- mat[y][0]
		ble $s1, $s0, altro_bordo	#se s1 < max passa all'altra colonna
		move $s0, $s1			# altrimenti max <- s1
		
		altro_bordo:
		mul $s1, $t0, $a2		#X*y
		subi $t3, $a2, 1
		add $s1, $s1, $t3		# + x
		sll $s1, $s1, 2			# * 4
		add $s1, $s1, $a0		# offset+indirizzo
		lw $s1, ($s1)			#s1 <- mat[y][X-1]
		
		ble $s1, $s0, fine_cicloC	#se s1 < max passa alla prossima riga
		move $s0, $s1			#max <- s1
		j fine_cicloC
		
		cicloC:
		beq $t1, $a2, fine_cicloC
		#calcolo offset
		mul $s1, $t0, $a2	#X*y
		add $s1, $s1, $t1	# +x
		sll $s1, $s1, 2		# * 4
		add $s1, $s1, $a0	#offset+indirizzo
		lw $s1, ($s1)		#s1 <- mat[y][x]
		ble $s1, $s0, incrX
		move $s0, $s1
		incrX:
		addi $t1, $t1, 1	#x++
		j cicloC		#next colonna
		
		fine_cicloC:
		li $t1, 0		#x = 0
		addi $t0, $t0, 1	#y++
		j cicloR		#next 
		
		fine_cicloR:
		move $v0, $s0
		jr $ra
		

main:
	la $a0, mat
	li $a1, 4
	li $a2, 4
	jal massimoCornice


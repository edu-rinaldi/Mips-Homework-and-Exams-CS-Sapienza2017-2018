.data
.align 1
mat: .half 12,2,34,4,5,6,36,8,9
.text
.globl main
#a0 = indirizzo matrice half-word    a1 = N
scambia:
	li $t0, 0	#y
	li $t1, 0	#x
	li $t4, 1	#n
	addi $t5, $a1, 1#len+1
	
	#ciclo righe
	cicloR:
		beq $t0, $a1, fine_cicloR
	#ciclo colonne
	cicloC:
		beq $t4, $t5, fine_cicloR
		beq $t1, $t4, fine_cicloC
		
		#calcolo offset per mat[y][x]
		mul $s0, $a1, $t0
		add $s0, $s0, $t1	#$s0 = (N*y)+x
		sll $s0, $s0, 1		#$s0 = ((N*y)+x)*dimHalfWord
		add $s0, $s0, $a0	#$s0 = ..+indirizzo
		# s2 <- mat[y][x]
		lh $s2, ($s0)
		
										
		#calcolo offset per mat[x][y]
		mul $s1, $a1, $t1
		add $s1, $s1, $t0	#$s1 = (N*x)+y
		sll $s1, $s1, 1		#$s1 = ((N*x)+y)*dimHalfWord
		add $s1, $s1, $a0	#$s1 = ...+indirizzo
		# s1 <- mat[x][y]
		lh $s3, ($s1)
		
		#if mat[y][x] % 2 == 0 && mat[x][y] % 2 == 0   -> scambia
		andi $t2, $s2, 1	# t2 = s2%2 ? 0 : 1
		andi $t3, $s3, 1	# t3 = s3%2 ? 0 : 1
		add $t2, $t2, $t3	# t2 = t2+t3	(somma i due bit)
		bnez $t2, next_col 	#se sono diversi da 2 passa alla colonna dopo
		sh  $s2, ($s1)		#altrimenti salva s2 in s1
		sh $s3, ($s0)		#e s3 in s0				
		next_col:
		addi $t1, $t1, 1
		j cicloC
	fine_cicloC:
		addi $t0, $t0, 1
		li $t1, 0
		addi $t4, $t4, 1
		j cicloR
	fine_cicloR:
		jr $ra

main:
	la $a0, mat
	li $a1, 3
	jal scambia
	
	
	li $v0, 10
	syscall


.data
grid: .byte ' ':64
coords: .space 3
.text
.globl main

#---------- MACRO ----------

.macro printString(%strAddr)	#print stringa %strAddr = string address
	la $a0, %strAddr
	li $v0, 4
	syscall
	.end_macro

.macro printIntegerImmediate(%val)	#print integer from Immediate value
	li $a0, %val
	li $v0, 1
	syscall
	.end_macro
.macro printIntegerReg(%val)	 	#print integer from Register value
	add $a0, $a0, %val
	li $v0, 1
	syscall
	.end_macro

.macro printChar(%c)
	li $a0, %c
	li $v0, 11
	syscall
	.end_macro

.macro insertValReg(%mat, %i, %j, %val)
	# mat = matrix address
	# i = row index
	# j = column index
	# val = value to insert
	
	# (8*i)+j	
	sll %i, %i, 3
	add %i, %i, %j
	
	sb %val, %mat(%i)	# insert value in matAddress[i][j]
	.end_macro

.macro insertVal(%mat,%i,%j,%val)
	# mat = matrix address
	# i = row index (immediate)
	# j = column index (immediate)
	# val = value to insert (immediate)
	
	# store i in $t0 register
	li $t0, %i
	# (8*i)+j	
	sll $t0, $t0, 3
	addi $t0, $t0, %j
	
	li $t1, %val		#store value in $t1
	sb $t1, %mat($t0)	# insert value in matAddress[i][j]
	.end_macro
	
.macro printCharMat(%mat,%i,%j)
	# mat = matrix address
	# i = row index (immediate)
	# j = column index (immediate)
	
	# store i in $t0 register
	li $t0, %i
	
	# (8*i)+j	
	sll $t0, $t0, 3
	addi $t0, $t0, %j
	
	# a0 <- mat[i][j]
	lb $a0, %mat($t0)
	li $v0, 11
	syscall
	.end_macro

.macro printMatrix(%mat)
	printChar('|')
	printCharMat(%mat,0,0)
	printCharMat(%mat,0,1)
	printCharMat(%mat,0,2)
	printCharMat(%mat,0,3)
	printCharMat(%mat,0,4)
	printCharMat(%mat,0,5)
	printCharMat(%mat,0,6)
	printCharMat(%mat,0,7)
	printChar('|')
	printChar('\n')
	printChar('|')
	printCharMat(%mat,1,0)
	printCharMat(%mat,1,1)
	printCharMat(%mat,1,2)
	printCharMat(%mat,1,3)
	printCharMat(%mat,1,4)
	printCharMat(%mat,1,5)
	printCharMat(%mat,1,6)
	printCharMat(%mat,1,7)
	printChar('|')
	printChar('\n')
	printChar('|')
	printCharMat(%mat,2,0)
	printCharMat(%mat,2,1)
	printCharMat(%mat,2,2)
	printCharMat(%mat,2,3)
	printCharMat(%mat,2,4)
	printCharMat(%mat,2,5)
	printCharMat(%mat,2,6)
	printCharMat(%mat,2,7)
	printChar('|')
	printChar('\n')
	printChar('|')
	printCharMat(%mat,3,0)
	printCharMat(%mat,3,1)
	printCharMat(%mat,3,2)
	printCharMat(%mat,3,3)
	printCharMat(%mat,3,4)
	printCharMat(%mat,3,5)
	printCharMat(%mat,3,6)
	printCharMat(%mat,3,7)
	printChar('|')
	printChar('\n')
	printChar('|')
	printCharMat(%mat,4,0)
	printCharMat(%mat,4,1)
	printCharMat(%mat,4,2)
	printCharMat(%mat,4,3)
	printCharMat(%mat,4,4)
	printCharMat(%mat,4,5)
	printCharMat(%mat,4,6)
	printCharMat(%mat,4,7)
	printChar('|')
	printChar('\n')
	printChar('|')
	printCharMat(%mat,5,0)
	printCharMat(%mat,5,1)
	printCharMat(%mat,5,2)
	printCharMat(%mat,5,3)
	printCharMat(%mat,5,4)
	printCharMat(%mat,5,5)
	printCharMat(%mat,5,6)
	printCharMat(%mat,5,7)
	printChar('|')
	printChar('\n')
	printChar('|')
	printCharMat(%mat,6,0)
	printCharMat(%mat,6,1)
	printCharMat(%mat,6,2)
	printCharMat(%mat,6,3)
	printCharMat(%mat,6,4)
	printCharMat(%mat,6,5)
	printCharMat(%mat,6,6)
	printCharMat(%mat,6,7)
	printChar('|')
	printChar('\n')
	printChar('|')
	printCharMat(%mat,7,0)
	printCharMat(%mat,7,1)
	printCharMat(%mat,7,2)
	printCharMat(%mat,7,3)
	printCharMat(%mat,7,4)
	printCharMat(%mat,7,5)
	printCharMat(%mat,7,6)
	printCharMat(%mat,7,7)
	printChar('|')
	printChar('\n')
	.end_macro

.macro initGame(%mat)
	#insert B
	insertVal(%mat,3,3,'B')
	insertVal(%mat,4,4,'B')
	#insert N
	insertVal(%mat,3,4,'N')
	insertVal(%mat,4,3,'N')
	.end_macro

#---------- END MACROS ----------

		

main:
	
	#initialize game
	initGame(grid)
	
	#initialize vars
	li $s0, 1	#exit condition
	li $s1, 'N'	#init player (Nero)
	startGame:
	beq $s0, $zero, endGame
	
	# read string in input
	la $a0, coords
	li $a1, 4
	li $v0, 8
	syscall
	
	# j = coords[0] - 97
	lb $t0, coords($zero)
	subi $t0, $t0, 97
	
	# i = coords[1] - 48
	lb $t1, coords($s0)
	subi $t1, $t1, 48
	
	# N || B ?
	beq $s1, 'N', toWhite
	li $s1, 'N'
	j afterChange
	toWhite:
	li $s1, 'B'
	
	#insertValReg
	afterChange:
	insertValReg(grid,$t1,$t0,$s1)
	printMatrix(grid)
	j startGame
	
	
	
	 
	
	endGame:
	
	




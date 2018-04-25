.data
grid: .byte 'o':64

.text
.globl main

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
	printCharMat(%mat,0,0)
	printCharMat(%mat,0,1)
	printCharMat(%mat,0,2)
	printCharMat(%mat,0,3)
	printCharMat(%mat,0,4)
	printCharMat(%mat,0,5)
	printCharMat(%mat,0,6)
	printCharMat(%mat,0,7)
	printChar('\n')
	printCharMat(%mat,1,0)
	printCharMat(%mat,1,1)
	printCharMat(%mat,1,2)
	printCharMat(%mat,1,3)
	printCharMat(%mat,1,4)
	printCharMat(%mat,1,5)
	printCharMat(%mat,1,6)
	printCharMat(%mat,1,7)
	printChar('\n')
	printCharMat(%mat,2,0)
	printCharMat(%mat,2,1)
	printCharMat(%mat,2,2)
	printCharMat(%mat,2,3)
	printCharMat(%mat,2,4)
	printCharMat(%mat,2,5)
	printCharMat(%mat,2,6)
	printCharMat(%mat,2,7)
	printChar('\n')
	printCharMat(%mat,3,0)
	printCharMat(%mat,3,1)
	printCharMat(%mat,3,2)
	printCharMat(%mat,3,3)
	printCharMat(%mat,3,4)
	printCharMat(%mat,3,5)
	printCharMat(%mat,3,6)
	printCharMat(%mat,3,7)
	printChar('\n')
	printCharMat(%mat,4,0)
	printCharMat(%mat,4,1)
	printCharMat(%mat,4,2)
	printCharMat(%mat,4,3)
	printCharMat(%mat,4,4)
	printCharMat(%mat,4,5)
	printCharMat(%mat,4,6)
	printCharMat(%mat,4,7)
	printChar('\n')
	printCharMat(%mat,5,0)
	printCharMat(%mat,5,1)
	printCharMat(%mat,5,2)
	printCharMat(%mat,5,3)
	printCharMat(%mat,5,4)
	printCharMat(%mat,5,5)
	printCharMat(%mat,5,6)
	printCharMat(%mat,5,7)
	printChar('\n')
	printCharMat(%mat,6,0)
	printCharMat(%mat,6,1)
	printCharMat(%mat,6,2)
	printCharMat(%mat,6,3)
	printCharMat(%mat,6,4)
	printCharMat(%mat,6,5)
	printCharMat(%mat,6,6)
	printCharMat(%mat,6,7)
	printChar('\n')
	printCharMat(%mat,7,0)
	printCharMat(%mat,7,1)
	printCharMat(%mat,7,2)
	printCharMat(%mat,7,3)
	printCharMat(%mat,7,4)
	printCharMat(%mat,7,5)
	printCharMat(%mat,7,6)
	printCharMat(%mat,7,7)
	printChar('\n')
	.end_macro
	

main:

	printMatrix(grid)





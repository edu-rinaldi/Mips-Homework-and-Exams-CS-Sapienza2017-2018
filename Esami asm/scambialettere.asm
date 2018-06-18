.globl main
.data
str: .asciiz "Ciabatta"
.text
.macro letterInRange(%l,%rs,%re)
	blt %l, %rs, fine
	bgt %l, %re, fine
	li $v0, 1
	j end_macroletter
	fine:
	li $v0, 0
	end_macroletter:
.end_macro



#a0 = str
#a1 = i
#a2 = j
scambialettere:
	blt $a1,$a2,controllaJ
	jr $ra
controllaJ:
	lb $t0, ($a2)
	letterInRange($t0,'a','z')
	bnez $v0, controllaI
	letterInRange($t0,'A','Z')
	bnez $v0, controllaI
	#salvo su stack
	subi $sp,$sp, 12
	sw $a1, ($sp)
	sw $a2, 4($sp)
	sw $ra, 8($sp)
	
	#chiamata ricorsiva
	subi $a2, $a2,1
	jal scambialettere
	
	#ripristino
	lw $a1, ($sp)
	lw $a2, 4($sp)
	lw $ra, 8($sp)
	addi $sp, $sp, 12
	jr $ra

controllaI:
	lb $t0, ($a1)
	letterInRange($t0,'a','z')
	bnez $v0, incrementaI
	letterInRange($t0,'A','Z')
	beqz $v0, scambiaChar
	incrementaI:
	#salvo su stack
	subi $sp,$sp, 12
	sw $a1, ($sp)
	sw $a2, 4($sp)
	sw $ra, 8($sp)
	
	#chiamata ricorsiva
	addi $a1, $a1,1
	jal scambialettere
	
	#ripristino
	lw $a1, ($sp)
	lw $a2, 4($sp)
	lw $ra, 8($sp)
	addi $sp, $sp, 12
	jr $ra
scambiaChar:
	#str[i]<->str[j]
	lb $t0, ($a1)	#t0<- str[j]
	lb $t1, ($a2)	#t1<- str[i]
	sb $t1, ($a1)	
	sb $t0, ($a2)
	
	#salvo su stack
	subi $sp,$sp, 12
	sw $a1, ($sp)
	sw $a2, 4($sp)
	sw $ra, 8($sp)
	
	#chiamata ricorsiva
	addi $a1, $a1, 1
	subi $a2, $a2, 1
	jal scambialettere
	
	#ripristino
	lw $a1, ($sp)
	lw $a2, 4($sp)
	lw $ra, 8($sp)
	addi $sp, $sp, 12
	jr $ra
	
main:
	la $a0, str
	la $a1, str
	la $a2, 8($a0)
	jal scambialettere
	
	li $v0, 4
	syscall
	
	li $v0, 10
	syscall

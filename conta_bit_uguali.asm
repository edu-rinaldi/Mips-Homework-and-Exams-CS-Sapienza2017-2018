.globl main
.data

.text

#a0=X   a1=Y
conta_bit_uguali:
	#if X==0 && Y==0: return 0
	#if Xand1 == Yand1: return conta_bit_uguali(X/2,Y/2)+1
	#else return conta_bit_uguali(X/2,Y/2)
	
	#if x==0 and y==0
	bnez $a0,secondoIf
	bnez $a1, secondoIf
	#return 0
	li $v0, 0
	jr $ra
secondoIf:
	#if Xand1 == Yand1: return conta_bit_uguali(X/2,Y/2)+1
	andi $t0,$a0,1
	andi $t1,$a1,1
	bne $t0,$t1, else
	
	#salvo su stack i parametri piu return address
	subi $sp,$sp,12
	sw $a0, ($sp)
	sw $a1, 4($sp)
	sw $ra, 8($sp)
	
	#X/2 e Y/2
	srl $a0,$a0,1
	srl $a1,$a1,1
	#chiamata ricorsiva
	jal conta_bit_uguali
	
	#ripristino da stack
	lw $a0, ($sp)
	lw $a1, 4($sp)
	lw $ra, 8($sp)
	addi $sp, $sp, 12
	
	addi $v0, $v0, 1
	jr $ra
	
else:
	#salvo su stack i parametri piu return address
	subi $sp,$sp,12
	sw $a0, ($sp)
	sw $a1, 4($sp)
	sw $ra, 8($sp)
	
	#X/2 e Y/2
	srl $a0,$a0,1
	srl $a1,$a1,1
	#chiamata ricorsiva
	jal conta_bit_uguali
	
	#ripristino da stack
	lw $a0, ($sp)
	lw $a1, 4($sp)
	lw $ra, 8($sp)
	addi $sp,$sp,12
	jr $ra
	

main:
	li $a0, 22
	li $a1, 20
	jal conta_bit_uguali
	
	move $a0, $v0
	li $v0, 1
	syscall

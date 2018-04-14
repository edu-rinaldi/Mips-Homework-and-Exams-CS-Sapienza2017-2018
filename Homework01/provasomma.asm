.data
	coda: .word 8,2,3,4,5,6,7
.text
.globl main
main:
	la $a0, coda
	li $a1, 5
	
	jal sum_k
	
	move $a0, $v0
	li $v0, 1
	syscall
	
	li $v0, 10
	syscall
	
sum_k:
	li $t3, 0	#index
	li $s0, 0	#somma
	for:
	beq $t3, $a1, end_for	#da index =0 a k-1
	sll $t4, $t3, 2	#calcolo offset
	add $t4, $t4, $a0	#offset+coda
	lw $t4, ($t4)	#salvo in t4, il valore della coda(index)
	add $s0, $s0, $t4 #somma+coda(index)
	addi $t3, $t3, 1	#index++
	j for
	end_for:
	move $v0, $s0
	jr $ra
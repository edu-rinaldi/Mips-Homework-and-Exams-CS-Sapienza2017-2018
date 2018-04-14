.data
	vet: .word -32,52,832
.text
	
.globl main
main:
	la $a0, vet
	li $a1, 3
	jal findMax
	move $a0, $v0
	li $v0, 1
	syscall
	
	li $v0, 10
	syscall
#$a0 = iterable	$a1 = len
findMin:
	#min = 0	
	#for i=0 -> len
	#	if( min > iterable[ i ])   min = iterable[ i ]
	#return min
	lw $v0, ($a0)
	li $t2, 1
	for_find_min:
	beq $t2, $a1, end_for_find_min	#for i=1 -> len
	addi $a0, $a0, 4
	lw $t5, ($a0)
	ble $v0, $t5, next_iter_for
	move $v0, $t5
	next_iter_for:
	addi $t2, $t2, 1
	j for_find_min
	end_for_find_min:
	jr $ra
	
findMax:
	#max = 0	
	#for i=0 -> len
	#	if( max < iterable[ i ])   max = iterable[ i ]
	#return max
	lw $v0, ($a0)
	li $t2, 1
	for_find_max:
	beq $t2, $a1, end_for_find_max	#for i=1 -> len
	addi $a0, $a0, 4
	lw $t5, ($a0)
	bge $v0, $t5, next_iter_for_max
	move $v0, $t5
	next_iter_for_max:
	addi $t2, $t2, 1
	j for_find_max
	end_for_find_max:
	jr $ra
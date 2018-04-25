.data
	str : .space 10

.text

	li $v0, 8
	li $a1 10
	la $a0, str
	syscall
	
	la $a0, str
	li $v0, 4
	syscall
	
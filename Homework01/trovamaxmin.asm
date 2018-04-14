.data

.text
.globl main
main:
#$a0 = a ,   $a1 = b

	li $a0, 20
	li $a1, 10
	jal findmax
	move $a0, $v0
	li $v0, 1
	syscall
	li $v0, 10
	syscall
findmin:
	ble $a0, $a1, return_a0
	move $v0, $a1
	jr $ra
	return_a0:
	move $v0, $a0
	jr $ra
findmax:
	ble $a0, $a1, return_a1
	move $v0, $a0
	jr $ra
	return_a1:
	move $v0, $a1
	jr $ra

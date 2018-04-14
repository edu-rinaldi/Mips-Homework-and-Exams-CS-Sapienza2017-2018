.data
str: .asciiz "Jamm bell ja"

.text
.globl main
#a0 indirizzo stringa
scorri_e_stampa:
	li $t0, 0	#inizializzo la i
	for:
	add $s0, $a0, $t0	#calcolo indirizzo	
	lb $s0, ($s0)	#s0<-str[i]
	beqz $s0, fine_for	#if(s0 == 0) fine for
	
	subi $sp, $sp, 4
	sw $a0, ($sp)
	
	move $a0, $s0
	li $v0, 11
	syscall
	
	lw $a0, ($sp)
	addi $sp, $sp, 4
	addi $t0, $t0, 1
	j for
	fine_for:
	jr $ra
main:
	sge $t4, 0, $zero
	la $a0, str
	jal scorri_e_stampa
	
	li $v0, 10
	syscall


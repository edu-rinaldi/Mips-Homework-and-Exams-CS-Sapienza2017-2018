.data
vet: .word 0:1000
vet2: .word 16,-2,-4,-2,-666,-666,10,-3,-666,-666,-666,-666,-666,-666,1,1,-666
vet24: .word 15, -1,-2, -3,3, -1, 7, -3,-666, -666, 5, 8, -666, -666, 6, 9
.text
.globl main

#------------ MACROS ------------

# isFoglia(vet,  i)
# controlla se il nodo in posizione i, e' una foglia
.macro isFoglia(%l, %i, %n)
	# l = indirizzo vettore
	# i = registro contenente i
	# n = registro contenente l[0]
	
	#inizializzo v0 a 0
	li $v0, 0
	
	#calcolo left (e right)
	sll $t0, %i, 1		#left
	#addi $t1, $t1, 1	#right < (inutile)
	
	#if left > l[0] cambioV0 in 1
	bgt $t0, %n, cambiaV0
	
	sll $t0, $t0, 2
	add $t0, $t0, %l
	lw $t0, ($t0)
	bne $t0, -666, endmacroisFoglia
	cambiaV0:
	li $v0, 1
	endmacroisFoglia:
	.end_macro
	 
.macro printChar(%c)
	li $a0, %c
	li $v0, 11
	syscall
	.end_macro


.macro pow(%x,%y,%d)
	li $t6, 0
	li %d, 1
	abs %y, %y
	cic:
	beq $t6, %y, fineCiclo
	mul %d, %d, %x
	addi $t6, $t6, 1
	j cic
	fineCiclo:
	.end_macro
#------------ END MACROS ------------

# a0 = l	a1 = i
funzRic1:
	#left e right
	sll $s0, $a1, 1
	addi $s1, $s0, 1
	
	#is foglia?
	isFoglia($a0, $a1, $s2)
	beqz $v0, elsefr1
	
	#sposto temporaneamente a0 in 
	add $t1, $a0, $zero
	
	li $a0, '('
	li $v0, 11
	syscall
	
	
	#leggo l[i] e lo metto in s3
	sll $t2, $a1, 2		#i*4
	add $t2, $t1, $t2	#i*4+vet
	lw $a0, ($t2)		# a0 <- l[i]
	
	#print l[i]
	li $v0, 1
	syscall
	
	li $a0, ')'
	li $v0, 11
	syscall
	
	#ripristino a0
	add $a0, $t1, $zero
	
	#return
	jr $ra
	
	elsefr1:
	
	#salvo a0
	add $t1, $a0, $zero
	
	li $a0, '('
	li $v0, 11
	syscall
	
	#ripristino a0
	add $a0, $t1, $zero
	
	
	#richiamo funzione ricorsiva su left
	subi $sp, $sp, 20
	sw $a0, ($sp)
	sw $a1, 4($sp)
	sw $ra, 8($sp)
	sw $s0, 12($sp)
	sw $s1, 16($sp)
	
	add $a1, $s0, $zero
	
	jal funzRic1
	
	lw $a0, ($sp)
	lw $a1, 4($sp)
	lw $ra, 8($sp)
	lw $s0, 12($sp)
	lw $s1, 16($sp)
	addi $sp, $sp, 20
	
	#leggo l[i] e lo metto in s3
	sll $t2, $a1, 2		#i*4
	add $t2, $a0, $t2	#i*4+vet
	lw $t2, ($t2)		# a0 <- l[i]
	
	#salvo a0
	add $t3, $a0, $zero
	
	beq $t2, -1, printPer
	beq $t2, -2, printPiu
	beq $t2, -3, printMeno
	beq $t2, -4, printPow
	printPer:
	printChar('*')
	j dopoIf
	printPiu:
	printChar('+')
	j dopoIf
	printMeno:
	printChar('-')
	j dopoIf
	printPow:
	printChar('^')
	dopoIf:
	
	#ripristino a0
	add $a0, $t3, $zero
	
	#richiamo la funzione sul figlio dx
	subi $sp, $sp, 20
	sw $a0, ($sp)
	sw $a1, 4($sp)
	sw $ra, 8($sp)
	sw $s0, 12($sp)
	sw $s1, 16($sp)
	
	add $a1, $s1, $zero
	
	jal funzRic1
	
	printChar(')')
	
	lw $a0, ($sp)
	lw $a1, 4($sp)
	lw $ra, 8($sp)
	lw $s0, 12($sp)
	lw $s1, 16($sp)
	addi $sp, $sp, 20
	
	jr $ra
	


funzRic2:
	#left e right
	sll $s0, $a1, 1
	addi $s1, $s0, 1
	
	#is foglia?
	isFoglia($a0, $a1, $s2)
	beqz $v0, nonFoglia
	jr $ra
	nonFoglia:
	isFoglia($a0, $s0, $s2)
	beqz $v0, chiamateRic
	isFoglia($a0, $s1, $s2)
	beqz $v0, chiamateRic
	
	#calcolo l[i]
	sll $t3, $a1, 2	#i*4
	add $t1, $a0, $t3
	
	lw $t2, ($t1)	#l[i]
	
	li $s4, -666
	#calcolo l[left]
	sll $t3, $t3, 1
	add $t3, $t3, $a0
	lw $t4, ($t3)
	sw $s4, ($t3)	#metti -666 in left
	#calcolo l[right]
	addi $t3, $t3, 4
	lw $t5, ($t3)
	sw $s4, ($t3)	#metti -666 in right 
	
	beq $t2, -1, assegnaMul
	beq $t2, -2, assegnaSum
	beq $t2, -3, assegnaSub
	beq $t2, -4, assegnaPow
	assegnaMul:
	mul $t2, $t4, $t5
	sw $t2, ($t1)
	j fineIf2
	assegnaSum:
	add $t2, $t4, $t5
	sw $t2, ($t1)
	j fineIf2
	assegnaSub:
	sub $t2, $t4, $t5
	sw $t2, ($t1)
	j fineIf2
	assegnaPow:
	pow($t4,$t5,$t2)
	sw $t2, ($t1)
	fineIf2:
	
	chiamateRic:
	
	#richiamo la funzione sul figlio sx
	subi $sp, $sp, 20
	sw $a0, ($sp)
	sw $a1, 4($sp)
	sw $ra, 8($sp)
	sw $s0, 12($sp)
	sw $s1, 16($sp)
	
	add $a1, $s0, $zero
	
	jal funzRic2
	
	lw $a0, ($sp)
	lw $a1, 4($sp)
	lw $ra, 8($sp)
	lw $s0, 12($sp)
	lw $s1, 16($sp)
	addi $sp, $sp, 20
	
	#richiamo la funzione sul figlio dx
	subi $sp, $sp, 20
	sw $a0, ($sp)
	sw $a1, 4($sp)
	sw $ra, 8($sp)
	sw $s0, 12($sp)
	sw $s1, 16($sp)
	
	add $a1, $s1, $zero
	
	jal funzRic2
	
	lw $a0, ($sp)
	lw $a1, 4($sp)
	lw $ra, 8($sp)
	lw $s0, 12($sp)
	lw $s1, 16($sp)
	addi $sp, $sp, 20
	
	jr $ra

main:
	#leggo N
	li $v0, 5
	syscall
	#salvo N in pos 0
	sw $v0, vet
	#setto un contatore a 1 e imposto N
	li $t0, 1
	addi $t1, $v0, 1
	
	cicloLettura:
	beq $t0, $t1, fineCicloLettura
	li $v0, 5
	syscall
	sll $t0, $t0, 2
	sw $v0, vet($t0)
	srl $t0, $t0, 2
	addi $t0, $t0, 1
	j cicloLettura
	
	fineCicloLettura:
	la $a0, vet
	li $a1, 1
	lw $s2, ($a0)
	jal funzRic1
	printChar('\n')
	beq $s2, 1, fineWhileTrue
	la $a0, vet
	whileFine:
	lw $t7, 8($a0)
	beq $t7, -666, fineWhileTrue
	jal funzRic2
	jal funzRic1
	printChar('\n')
	la $a0, vet
	j whileFine
	
	fineWhileTrue:
	li $v0, 10
	syscall



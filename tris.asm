.data
	matrice: 	.byte 'c':9
.text

.globl main
# matrice = $a0 	, index = $a1
print_matrice:
	#if 	i == 9*4:
	#	return
	#if i == 2 or i == 5: print('\n')
	#else: print(matrice[ i ])
	#	return print_matrice( matrice+1 )
	
	sub $sp, $sp, 4
	sw 	$ra, ($sp)
	
	
	
	bne $a1, 9,caso_2						#if  ( i==9)
	jr $ra								#return;
	
	caso_2:
	bne $a1,3, caso_3				#if ( i==3)
	move $t1, $a0
	li $v0, 11
	li $a0, '\n'
	syscall
	move $a0, $t1
	caso_3:
	bne $a1, 6, caso_ricorsivo_print		# or i == 5
	move $t1, $a0
	li $v0, 11
	li $a0, '\n'
	syscall
	move $a0, $t1
	caso_ricorsivo_print:
	add $t0, $a1, $a0			# $t0 = i+matriceAddress
	move $t1, $a0			#mi salvo l'indirizzo della matrice in un reg. temp
	lb $a0, ($t0)				#carico il byte in matrice
	li $v0, 11				#print(matrice[i])
	syscall
	
	move $a0, $t1			#ripristino l'indirizzo della matrice
	
	addi $a1, $a1, 1
	jal print_matrice

	lw $ra, ($sp)
	addi $sp, $sp, 4
			
	jr $ra
	

main:
	
	
	la $a0, matrice
	li $a1, 0
	jal print_matrice
	
	li $v0, 10
	syscall

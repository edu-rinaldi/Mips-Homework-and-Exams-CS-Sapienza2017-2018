.data
	coda: .word 0:20
.text
.globl main
main:
	.eqv $i, $t0
	.eqv $offset, $t1
	.eqv $k, $s1
	.eqv $flag, $s2
	.eqv $maxS, $s3
	.eqv $minS, $s4
	.eqv $maxY, $s5
	.eqv $minY, $s6
	#inizializzo i valori minimi con word piu grande rappresentabile
	li $minS, 2147483647
	li $minY, 2147483647
	#inizializzo i = 0
	li $i, 0
	#flag a 0
	li $flag, 0
	#leggo k
	li 		$v0, 5
	syscall
	move 	$k, $v0				#salvo k in un registro $k
	
	#leggo finche non ricevo 0
while_read:
	
	beqz	$flag, continuo_while
	la 		$a0, coda			#prendo l'indirizzo della coda e lo passo come parametro a0
	move	 $a1, $k				#prendo $k e lo passo come parametro $a1
	jal 		sum_k				#chiamo funzione sum_k
	addi		$sp, $sp, -4
	sw		$v0, ($sp)
	move	$a0, $v0
	move      $a1, $maxY
	jal		findmax
	move      $maxY, $v0
	move 	$a1, $minY
	jal		findmin
	move 	$minY, $v0
	lw		$v0, ($sp)
	addi		$sp, $sp, 4
	move 	$a0, $v0				#sposto il risultato in $a0 e printo
	li 		$v0, 1				#print
	syscall
	li $a0, '\n'
	li $v0, 11
	syscall
	continuo_while:
	li 	$v0, 5					#prendo in input un numero da S
	syscall
	
	move $a0, $v0
	move $a1, $maxS
	
	beqz $v0, end_while_read		#se e' 0 termino l'esecuzione

	sll 	$offset, $i, 2				#calcolo l'offset di i
	sw 	$v0, coda($offset)		#prendo il valore in v0 e lo sposto in coda($i+offset)
	addi $i, $i, 1  					#$i += 1
	
	jal findmax					#findmax(input, maxS)
	move $maxS, $v0
	
	move $a1, $minS
	jal findmin
	move $minS, $v0
	
	bne $i, $k, else_while			#se i == k allora 
	li 	$i, 0						#azzero i 
	li 	$flag, 1					#flag a true
		
	else_while:
	j while_read
end_while_read:
	move $a0, $minS				#stampo il minS
	li 	$v0, 1
	syscall
	li 	$a0, '\n'					#stampo		\n
	li 	$v0, 11
	syscall
	
	move 	$a0, $maxS			#stampo il maxS
	li 		$v0, 1
	syscall
	li 	$a0, '\n'					#stampo		\n
	li 	$v0, 11
	syscall
	
	move 	$a0, $minY			#stampo il minY
	li 		$v0, 1
	syscall
	li 	$a0, '\n'					#stampo		\n
	li 	$v0, 11
	syscall
	move 	$a0, $maxY			#stampo il maxY
	li 		$v0, 1
	syscall
	li $v0, 10					#end program
	syscall

#$a0 = coda[0]   $a1= k	
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

#a0 = a     a1 = b     trova max/min tra i due
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

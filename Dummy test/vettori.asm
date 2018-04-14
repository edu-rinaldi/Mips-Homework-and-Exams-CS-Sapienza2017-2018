.globl main
.data
	vet: .word 0:10


.text



main:
	#vet <- { n1, n2, ..., n9 }
	li 	$t0, 0
while_insert:
	beq $t0, 10, end_while_insert		#while( i < 10 )
	li 	$v0, 5						#read integer
	syscall
	sll 	$t1, $t0, 2					#calcolo offset = i*4
	sw 	$v0, vet($t1)					#salvo in vet[ i ] <-- input
	add $t0, $t0, 1					# i++
	j while_insert
end_while_insert:
	#ciclo su vet
	li	 $t0, 0						#reset i = 0
for_0_to_10:
	beq $t0, 10, end_for				#for(int i = 0; i< 10; i++)
	
	sll 	$t1, $t0, 2					#offset
	lw 	$t1, vet($t1)					#leggo dal vettore e salvo in $t1
	andi $t2, $t1, 1					#$t2 <-- mod2(v[ i ])
	bne $t2, 0, else_if					#if ( v[ i ] % 2 == 0)
	move $a0, $t1
	li 	$v0, 1						#print( v[ i ] )
	syscall
else_if:
	add $t0, $t0, 1					#	i++
	j for_0_to_10
	
end_for:
	li 	$v0, 10						#fine programma
	syscall



#------- print array ----
#	li 	$t0, 0
#while_print_array:
#	beq $t0, 10,	end_while_print_array	#while ( i<10)
#	sll 	$t1, $t0, 2						#calcolo offset i*4
#	lw 	$a0, vet($t1)						#load: a0 <-- vet[ i ]
#	li	$v0, 1							#print( $a0 )
#	syscall
#	add $t0, $t0, 1
#	j while_print_array
#end_while_print_array:
#	li	$v0, 10
#	syscall
	
	

.globl main
.data

.text
	#	f(x) = a(x) + b(y)
	#	a(x) = x + 3
	#	b(y) = c(y) - 100
	#	c(y) = y * 4
	# x= 4	y= 5
	# a(4) = 7	b(5) = 20 - 100 = 7 - 80 = -73
main:
	#leggo in input  x
	li $v0, 5
	syscall
	move $a0, $v0
	#leggo in input  y
	li $v0, 5
	syscall
	move $a1, $v0
	
	jal f
	
	move $a0, $v0
	li $v0, 1
	syscall
	
	li $v0, 10
	syscall
	
	
f:
	#f(x=$a0, y=$a1) = a(x) + b(y)
	addi $sp, $sp, -4	#alloco 4 byte per salvare $ra
	sw 	$ra, 0($sp)	#salvo $ra in memoria
	
	jal a				#richiamo la funzione a($a0=x)
	#move $t0, $v0	#salvo il valore in un registro temporaneo $t0
	
	jal b		#richiamo la funzione b($a1=y)
	
	add  $v0, $v0, $v1 #b(y) + a(x)
	
	
	lw $ra, 0($sp)	#ripristino $ra di f(x)
	addi $sp, $sp, 4	
	jr $ra
	
a:
	#x+3
	add $v1, $a0, 3
	jr $ra

b:
	#c(y) - 100
	addi $sp, $sp, -4	#salvo $ra
	sw $ra, 0($sp)
	
	jal c				#richiamo c (y)
	
	add $v0, $v0, -100	#c(y) - 100
	
	lw $ra, 0($sp)
	addi $sp, $sp, 4	#ripristino $ra
	jr $ra			#jmp a PC( jal b ) + 4
c:
	# y*4
	sll $v0, $a1, 2	
	mul $v0, $a1, 4	#y*4
	jr $ra			#jmp a PC( jal c ) +4
	

	
	
	
	
	
	
	
	
	
	
	
	
	

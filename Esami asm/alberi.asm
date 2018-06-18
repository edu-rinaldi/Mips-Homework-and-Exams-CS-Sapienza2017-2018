.globl main
.data
n: .word 10
p: .word 0
albero: .word 2, 4, -1, 8, -1, -1, -1, -1, 6, -1

.text

.macro left(%p,%albero)
	li $t0, 0
	sll $t0, %p, 2
	add $t0, $t0, %albero
	lw $v0, ($t0)
.end_macro

.macro right(%p,%albero)
	li $t0, 0
	addi $t0,%p,1
	sll $t0, $t0, 2
	add $t0, $t0, %albero
	lw $v0, ($t0)
.end_macro


#a0/s2 = albero: indirizzo di un vettore contenente un albero
#a1 = N: il numero di elementi del vettore (numero pari compreso tra 2 ed 100 inclusi)
#a2 = P: la posizione del nodo corrente (un numero pari) 
#s0 = count
#s1 = max
profonditaAlbero:
	move $a0, $a2
	li $v0, 1
	syscall
	ble $s0, $s1, controlliRicorsivi
	move $s1, $s0
controlliRicorsivi:
	left($a2,$s2)
	#if p.left!=-1
	beq $v0, -1, altroCaso
	
	#salvo su stack
	subi $sp,$sp, 12
	sw $a2, ($sp)
	sw $s0, 4($sp)
	sw $ra, 8($sp)
	
	#ric(albero,p.left,count+1,max)
	move $a2, $v0
	addi $s0, $s0, 1
	jal profonditaAlbero
	
	#ripristino
	lw $a2, ($sp)
	lw $s0, 4($sp)
	lw $ra, 8($sp)
	addi $sp, $sp, 12
altroCaso:
	right($a2,$s2)
	#if p.right!=-1
	beq $v0, -1, fineRic
	
	#salvo su stack
	subi $sp,$sp, 12
	sw $a2, ($sp)
	sw $s0, 4($sp)
	sw $ra, 8($sp)
	
	#ric(albero,p.right,count+1,max)
	move $a2, $v0
	addi $s0, $s0, 1
	jal profonditaAlbero
	
	#ripristino
	lw $a2, ($sp)
	lw $s0, 4($sp)
	lw $ra, 8($sp)
	addi $sp, $sp, 12
	
fineRic:
	jr $ra


main:
	la $s2, albero
	li $a1, 10
	li $a2, 0
	li $s0, 1
	li $s1, 1
	jal profonditaAlbero
	
	li $v0, 10
	syscall
	
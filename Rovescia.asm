.data
str1: .asciiz "ciao COME stai"
str2: .space 100
.text
.globl main
#return v0 = 1 if c e minuscolo else 0
isMinuscolo:
	blt $a0, 97, false
	li $v0, 1
	j fine_isminuscolo
	false: li $v0, 0
	fine_isminuscolo:
	jr $ra

#a0 str   a1 spazi 100 caratteri
rovesciaEScambia:
	li $t0, 0	#i = 0
	li $t1, 99	#j = 99
	for:
	add $s0, $a0, $t0	#in s0 metto l'indirizzo+i
	lb $s0, ($s0)		#prendo il carattere in pos i
	beqz $s0, fine_for	#se è fine stringa, finisce il for
	add $s1, $a1, $t1	#in s1 metto l'indirizzo+j
	
	beq $s0, ' ', inserisci
	
	subi $sp, $sp, 12	#salvo i parametri della funzione
	sw $a0, ($sp)
	sw $a1, 4($sp)
	sw $ra, 8($sp)
	move $a0, $s0
	jal isMinuscolo
	
	lw $a0, ($sp)		#ripristino
	lw $a1, 4($sp)
	lw $ra, 8($sp)
	addi $sp, $sp, 12
	
	beqz $v0, maiuscolo	#se v0 =0 allora e' maiuscolo
	subi $s0, $s0, 32	#altrimenti C=c-32
	j inserisci		#vai a inserisci
	maiuscolo:		#se e' maiuscolo
	addi $s0, $s0, 32	#aggiungi 32 e ottieni il minuscolo
	inserisci:
	sb $s0, ($s1)		#metti in str2[j] il carattere
	addi $t0, $t0, 1	#i++
	subi $t1, $t1, 1	#j--
	j for
	fine_for:
	jr $ra
	
scorri_e_stampa:
	li $t0, 0	#inizializzo la i
	for2:
	add $s0, $a0, $t0	#calcolo indirizzo	
	lb $s0, ($s0)	#s0<-str[i]
	beq $t0, 100 fine_for2	#if(t0 == len) fine for
	
	subi $sp, $sp, 4
	sw $a0, ($sp)
	
	move $a0, $s0
	li $v0, 11
	syscall
	
	lw $a0, ($sp)
	addi $sp, $sp, 4
	addi $t0, $t0, 1
	j for2
	fine_for2:
	jr $ra

main:
	la $a0, str1
	la $a1, str2
	jal rovesciaEScambia
	
	move $a0, $a1
	jal scorri_e_stampa
	
	li $v0, 10
	syscall
	



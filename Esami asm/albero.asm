.data
nodo1: .word 10, 0
albero: .word 1, nodo1
.text

lw $s0, albero
li $t0, 4
lw $s1, albero($t0)

move $a0, $s1
li $v0, 1
syscall
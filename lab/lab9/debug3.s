.data

msg: .asciiz "Sum up the numbers in the series 2 3 4 5 is: "
list: .word 2 3 4 5

.text

li $v0, 4
la $a0, msg
syscall

la $a0, list
li $a1, 3
jal sum
move $s0, $v0

li $v0, 1
move $a0, $s0
syscall
	
li $v0, 10
syscall

### sum up the numbers in the array (its base address in a0 and size in a1) and return the sum in $v0
### int sum(int[], int) 
sum: 
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	li $v0, 0
loop:
	beq $a1, $zero, loopEnd
	lw $t1, ($a0)
	add $v0, $v0, $t1
	addi $a1, $a1, -2
	addi $a0, $a0, 4
	j loop
	
loopEnd:
	lw $ra, 0($sp)
	addi $sp, $sp, 4 
	jr $ra
	
		 
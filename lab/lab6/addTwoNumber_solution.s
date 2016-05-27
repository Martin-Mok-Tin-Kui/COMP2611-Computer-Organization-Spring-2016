#------- DATA SEGMENT ----------------
	.data
msg1:   .asciiz "Please input A:"
msg2:   .asciiz "Please input B:"

#------- TEXT SEGMENT ----------------
	.text
	.globl __start
__start:

# Main function starts here
	li $v0, 4
	la $a0, msg1
	syscall
	li $v0, 5
	syscall
	add $a0, $v0, $zero

        addi $sp, $sp, -4  # preserve $a0 as it will be overrided by the start address of string
	sw $a0, 0($sp)

	li $v0, 4
	la $a0, msg2
	syscall
	li $v0, 5
	syscall
	add $a1, $v0, $zero
    
	jal addNum       # call a function that adds two numbers 
	add $a0, $v0, $zero      # output the return value 
	li $v0, 1
	syscall

# Terminate the program
	li $v0, 10
	syscall

### void addNum(int, int)
addNum:
	lw $a0, 0($sp)   # restore the value of $a0
	addi $sp, $sp, 4
	add $v0, $a0, $a1  
	jr $ra            # function returns

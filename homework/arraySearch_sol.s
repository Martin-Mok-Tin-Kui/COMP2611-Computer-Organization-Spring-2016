# Your name:
# Your student id:
# Your email address:

# Homework 2 Question 1
# Implement a program to search the existence of user-input key in a random generatd positive integer array
# User input: 
# For randome generated integer array: size of array between 1-100, value range of array element [1, max]
# For search: key value to search
# Program output:
# The random generated array
# Whether the key is found in the array

.data
# declare an array space with 100 words
array:  .word   0:100

# define the strings for any output messages
inputArraySizeMsg: .asciiz "\nPlease input array size (1-100): " 
maxArrayElementMsg: .asciiz "\nPlease input a positive integer for maximum possible value in the array: "
enterKeyMsg: .asciiz "\nPlease input a positive integer to search: "

arrayPrintMsg: .asciiz "\nThe random array generated is:\n"
keyPrintMsg: .asciiz "\nThe search key is:"
notFoundMsg: .asciiz "\nThe value does not exist in the array.\n"
foundMsg: .asciiz "\nThe value is found in the array.\n"

newline: .asciiz "\n"
tab: .asciiz "\t"

.text
.globl main

main:	

# Your code starts here

# Step 1: Take user inputs
# Ask user to input array size and save it in $s1
# check whether the input value is in valid range 1-100. If not, ask the user to input again.

array_size_input:
	la $a0, inputArraySizeMsg
	li $v0, 4
	syscall
	li $v0, 5
	syscall

	move $s1, $v0
	addi $t1, $s1, -1
	bltz $t1, array_size_input
	addi $t1, $s1, -100
	bgtz $t1, array_size_input

# Ask user to input the maximum possible value in the array and save it in $s2
# check whether the input value is a positive integer. If not, ask the user to input again.
# Here you may assume no overflow issue

max_value_input:
	la $a0, maxArrayElementMsg
	li $v0, 4
	syscall
	li $v0, 5
	syscall

	move $s2, $v0	
	blez $s2, max_value_input

# Step 2: Generate an random array of size $s1. Each element is randomly generated within range [1, $s2]
# load the starting address of the array to $s0

	la $s0, array
	
	li $t0, 0
	
# set random seed

	li $v0, 30
	syscall            
	move $a1, $a0
	li $a0, 0
	li $v0, 40
	syscall

# fill the array with $s1 random elements within range [1, $s2]

	move $a1, $s2
random_number_generate:
	li $a0, 0
	li $v0, 42
	syscall
	addi $a0, $a0, 1
	sll $t1, $t0, 2
	add $t1, $s0, $t1
	sw $a0, 0($t1)
	addi $t0, $t0, 1 
	bne $t0, $s1, random_number_generate

# Step 3: Search the key in the array

	la $a0, enterKeyMsg
	li $v0, 4
	syscall
	li $v0, 5
	syscall

	move $s3, $v0
	li $t0, 0
	
search_key:
	sll $t1, $t0, 2
	add $t1, $s0, $t1
	lw $t3, 0($t1)
	beq $s3, $t3, print_result
	addi $t0, $t0, 1
	bne $t0, $s1, search_key

# Step 4: Print out the random generated array, search key, and whether the key is found in the array
# print the random generated array, 10 elements in a row, seperated by tab

print_result:
	move $s4, $t0
	la $a0, arrayPrintMsg
	li $v0, 4
	syscall
	
	li $t0, 0
	li $t2, 10
print_array:
	sll $t1, $t0, 2
	add $t1, $s0, $t1
	lw $a0, 0($t1)
	li $v0, 1           # Print $a0 as an integer 
	syscall
	jal printtab
	addi $t0, $t0, 1
	addi $t2, $t2, -1
	bne $t2, $zero, not_new_row
	li $t2, 10
	jal printnewline
not_new_row:
	bne $t0, $s1, print_array
	jal printnewline      # Print the new line character

# print the search key

print_search_key:
	la $a0, keyPrintMsg
	li $v0, 4
	syscall
	move $a0, $s3
	li $v0, 1
	syscall
	jal printnewline      # Print the new line character
	
# print the search result

	bne $s4, $s1, key_found
key_not_found:
	la $a0, notFoundMsg
	li $v0, 4
	syscall
	jal printnewline      # Print the new line character
	j terminate
key_found:
	la $a0, foundMsg
	li $v0, 4
	syscall
	jal printnewline      # Print the new line character

# end of your code

terminate:
	li $v0, 10
	syscall

# Print a tab

printtab:
    la $a0, tab
	li $v0, 4
    syscall
	jr $ra

# Print a new line

printnewline:
    la $a0, newline
   	li $v0, 4
    syscall
	jr $ra

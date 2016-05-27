#------- Data Segment ----------
.data
# Define the string messages and the array
msg1:		.asciiz "The ascendingly sorted numbers are :"
space:		.asciiz " "
newline:	.asciiz "\n" 
a:		.word 3 5 7 11 14 -1 -9 13 9 80	

#------- Text Segment ----------
.text
.globl main
main:

	
	la $s0, a  		# $s0 stores the start address of array
	li $s1,10               # size of the array in $s1, i.e. $s1=n
	subi $s7,$s1,1          # $s7 is n-1
	addi $s2, $zero, 0  	# $s2 is the loop counter i, initialized to 0
	addi $s3, $zero, 0      # $s3 is the loop counter j, initialized to 0


# TODO: below assume $s1=n, $7=n-1, $s2=i, $s3=j write the bubble sort algorithm in MIPS, you can add labels as you wish

loop_i: 
    slt $t1,$s2,$s7       #check to see if $s2 (i) is still within the correct range (max value == n-1 == $s7)
	beq  $t1,$zero, printresult #if i>=n-1 end the loop 
	addi $s3,$zero, 0           #init j=0
	

loop_j:

	
	sub $s4, $s7, $s2       # $s4=$s7-$s2=n-1-i
    slt $t1, $s3, $s4       # check to see if $s3 (j) is still within the correct range (max value == n-1-i-1 == $s4-1)
	beq $t1, $zero, new_i_iter  # if i>=10 end the loop 

	sll $t2, $s3, 2       # $s3x2 to get the the byte offset 
	add $t3, $s0, $t2      # base+byte offset to get a[j]
	lw  $s5, ($t3)        # $s5=a[j]
	
	lw $s6, 4($t3)        # $s6=a[j+1] 



				
	slt $t1, $s6, $s5     #  check to see if $s6<$s5 i.e. a[j+1]<a[j]
	beq $t1, $zero, new_j_iter

	#swap a[j+1] and a[j] if a[j+1]<a[j]
	sw $s6, ($t3) 
	sw $s5, 4($t3)       
	
new_j_iter:

	addi $s3,$s3,1     # j=j+1
	j loop_j

new_i_iter:
 	addi $s2,$s2,1     # i=i+1
	j loop_i
# TODO: above 



#print the result
printresult:
	#Print msg1
	la $a0, msg1
	li $v0, 4
	syscall

#Print a new line
	la $a0, newline
	li $v0, 4
	syscall
    add $t1,$zero,$zero  #$t1 is the index for printing sorted A[i]
#Print the sorted list
printloop:
    slt  $t0,$t1,$s1     #check to see if $t1 (i) is still within the correct range 
    beq  $t0,$zero, endprintloop #if i>=10 end print numbers
	sll  $t2,$t1,2       #$t1*4 to get the byte offset
	add  $t3,$s0,$t2     #base+byte offset to get address of A[i]
	lw   $a0,($t3)
	li   $v0, 1
	syscall

#Print a space to separate the numbers
	la $a0, space
	li $v0, 4
	syscall
	
#i=i+1 and start another iteration of the loop	
	addi $t1,$t1,1      #i=i+1
	j printloop

endprintloop:	
#Print a new line
	la $a0, newline
	li $v0, 4
	syscall
	

#Terminate the program
	li $v0, 10 
	syscall

#------- Data Segment ----------
.data

# Define the string messages
msg0:   .asciiz "Please enter the date in YYYYMMDD format:"
msg1:	.asciiz "Midterm 1 date\n"
msg2:	.asciiz "Midterm 2 date\n"
msg3:   .asciiz "Not a midterm date\n"

#------- Text Segment ----------
.text
.globl main
main:

# Print msg1
Label:	la $a0, msg0
	li $v0, 4
	syscall

# Get the input value from user (and store in $v0)
	li $v0, 5
	syscall

# Copy the value 20160310 to $t0
# 20160310 = 0x01339F36
	lui $t0,0x0133
	ori $t0,0x9f36	

# Copy the value 20160414 to $t1
# 20160414 = 0x01339F9E
	lui $t1,0x0133
	ori $t1,0x9f9e

# make the decision to branch to the correct label from the labels "midterm1","midterm2","notmidterm"
	beq $v0,$t0, midterm1
	beq $v0,$t1, midterm2
	j notmidterm


# labels "midterm1","midterm2" and "notmidterm"
midterm1:
	la $a0,msg1
	li $v0,4
	syscall
        j end	
midterm2:
        la $a0,msg2
        li $v0,4
        syscall
        j end
notmidterm:
	la $a0,msg3
	li $v0,4
	syscall
end:
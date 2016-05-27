.data

quiz_time:	.word 0 # the remaining time (number of game iterations) of the Quiz mode
shield_time:	.word 0 # the remaining time (number of student movement inputs) of the Shield mode
quiz_answer:	.word 0 # choice no. of the correct answer of the quiz in Quiz mode 
input_key:	.word 0 # input key from the player
move_key:	.word 0 # last processed key for a student movement
buffered_move_key: .word 0 # latest buffered movement input during an in-progress student movement
move_iteration: .word 0 # remaining number of game iterations for last student movement    
background_sound_on: .word 0 # 1 if background sound is on, otherwise 0

initial_game_score:	.word 30 # the initial score of a game level
game_score:	.word 0 # the game score
game_level:	.word 1 # level of the game, initilized to be 1
game_win_text:	.asciiz "You Win! Enjoy the game brought by COMP2611!"
game_lose_text:	.asciiz "Try to improve your skill in the next trial!"
input_scorepoint: .asciiz "Enter the number of score point objects (in the range [1, 5]): "
input_teacher:	.asciiz "Enter the number of teachers (in the range [1, 5]): "

student_size:	.word 30 30 # width and height of student object
scorepoint_size:	.word 30 30 # width and height of score point object
teacher_size:	.word 30 30 # width and height of teacher object

maze_size:		.word 750 600 # width and height of the maze
grid_cell_size:		.word 30 30 # width and height of a grid cell
grid_row_num:		.word 20 # the number of rows in the grid of the maze
grid_col_num:		.word 25 # the number of columns in the grid of the maze

# bitmap for the 20-row by 25-column grid of the maze
# with each grid cell's value being: 1 for a wall or 0 for a path 
maze_bitmap: .byte
1 1 1 1 1 1 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1  # first row of the grid
1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1
1 0 1 1 1 1 0 1 1 0 1 1 0 1 1 1 1 1 1 0 1 1 1 0 1
1 1 1 0 0 0 0 1 0 0 0 1 0 1 1 1 1 1 1 0 0 0 1 0 1
1 0 1 0 1 1 0 1 0 1 0 1 0 1 0 1 1 0 1 0 1 0 1 0 1
1 0 1 0 1 1 0 0 0 1 0 0 0 1 0 1 1 0 1 0 1 1 1 0 1
1 0 0 0 1 1 0 1 0 1 0 1 0 1 0 1 1 0 1 0 1 0 0 0 1
1 0 1 0 0 0 0 1 0 0 0 1 0 1 0 1 1 0 1 0 1 0 1 1 1
1 0 1 1 1 1 0 1 1 0 1 1 0 1 0 1 1 0 1 0 1 0 1 1 1
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
1 0 1 1 1 1 0 1 1 1 1 0 1 1 1 0 1 1 1 0 1 1 0 1 1
1 0 0 0 0 1 0 1 0 1 1 0 1 1 1 0 1 1 1 0 1 1 0 0 1
1 0 1 1 0 1 0 1 0 0 0 0 0 1 1 0 0 1 1 0 0 1 1 0 1
1 0 0 0 0 1 0 1 1 1 1 1 0 1 1 1 0 1 1 1 0 0 0 0 1
1 0 1 1 1 1 0 1 0 0 0 1 0 1 1 1 0 1 1 1 0 1 0 1 1
1 0 1 0 0 0 0 1 0 1 0 1 0 1 1 1 0 1 1 1 0 0 0 0 1
1 0 1 0 1 1 0 0 0 0 0 1 0 1 1 1 0 1 1 1 0 1 1 0 1
1 0 1 1 1 1 0 1 1 1 1 1 0 1 1 1 0 1 1 1 0 0 0 0 1
1 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 0 1
1 1 1 1 1 1 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1

teacher_base:	.word 0 # base id of teachers
teacher_num: 	.word 0 # the number of teachers

scorepoint_base:	.word 0 # base id of score point objects
scorepoint_locs:	.word -1:100 # the array of initialized locations (x,y) of score point objects
scorepoint_time:	.word 0:50 # the remaining time (number of game iterations) of each score point object in its current (visible or hidden) status
scorepoint_sv:	.word 0:50 # the score value (SV) of each score point object
scorepoint_num: 	.word 0 # the number of score point objects

student_id: 	.word 0 # id of student object is set to 0
student_locs:	.word -1:2 # initialized location of student object
student_speed:	.word 3

loc_separation:	.word 150 # the minimum horizontal or vertical separation distance (in pixels) between the student object's current location and another object's initial location 
quiz_time_limit: .word 1000 # time limit ((30000ms/game iteration duration) number of game iterations) of the Quiz mode
shield_time_limit: .word 500 # time limit ((1500/student_speed) number of student movement inputs) of the Shield mode
quiz_alert_time:	.word 200 # the remaining time of the Quiz mode at which the player will be alerted about the mode near its expiration. 
shield_alert_time:	.word 100 # the remaining time of the Shield mode at which the player will be alerted about the mode near its expiration. 
initial_move_iteration: .word 10 # default number of game iterations for a student movement

.text
main:		jal input_game_params
		la $t0, scorepoint_num # number of score point objects input by user
		sw $v0, 0($t0)		
		la $t0, teacher_num # number of teacher objects input by user
		sw $v1, 0($t0)		
						
		li $v0, 200 # Create the Game Screen
		syscall
		li $a0, 0 # play the background sound repeatedly (in loop)
		li $a1, 1
		li $v0, 202
		syscall 
		la $t0, background_sound_on
		li $t1, 1
		sw $t1, 0($t0)

		# Initialize the game level
		jal init_game_level
	       		
game_loop:	jal get_time
		add $s6, $v0, $zero # $s6: starting time of the game
		jal get_keyboard_input

game_continue:	la $t0, quiz_time
		lw $t0, 0($t0)
		bne $t0, $zero, game_quiz_input # game is in Quiz mode
	 	jal check_scorepoint_collisions
		jal check_level_end
		bne $v0, $zero, game_loop # new game level started
		
		la $t0, shield_time
		lw $t0, 0($t0)
		bne $t0, $zero, game_move_teacher # game is in Shield mode
		jal check_teacher_collisions
		beq $v0, $zero, game_move_teacher # no collisions with any teachers
		jal trigger_quiz
		j game_refresh # game just entered Quiz mode, refresh screen to show it first

game_move_teacher: li $v0, 213 # move all teachers for one game iteration
		syscall
		jal update_scorepoint_status	
		jal process_status_input
		jal process_move_input
		j game_refresh

game_quiz_input: jal process_quiz_input
		jal check_level_end
		bne $v0, $zero, game_loop # new game level started
		jal update_quiz_status	
game_refresh:
		# refresh screen
		li $v0, 201
		syscall
		add $a0, $s6, $zero
		addi $a1, $zero, 30 # iteration gap: 30 milliseconds
		jal have_a_nap
		j game_loop

#--------------------------------------------------------------------
# procedure: trigger_quiz
# Trigger the Quiz mode.
#--------------------------------------------------------------------
trigger_quiz:
	li $v0, 211 # trigger Quiz mode
	li $a0, 1
	syscall
	la $t0, quiz_answer
	sw $v0, 0($t0) # save correct quiz answer choice
	la $t0, quiz_time_limit
	lw $t1, 0($t0)
	la $t0, quiz_time
	sw $t1, 0($t0)
	jr $ra

#--------------------------------------------------------------------
# procedure: check_level_end
# Check whether the current game level is still in the middle, is won or is lost. 
# Also, perform the corresponding action for that game status.
# $v0=1 if the game has advanced to the next level, otherwise $v0=0
#--------------------------------------------------------------------
check_level_end:
	addi $sp, $sp, -4
	sw $ra, 0($sp)

	li $v0, 0
	la $t0, game_score # check game score
	lw $t0, 0($t0)
	slt $t1, $zero, $t0
	beq $t1, $zero, cle_lose # game score <= 0
	slti $t1, $t0, 100
	bne $t1, $zero, cle_exit # game score < 100, so continue game level
	# handle game winning at any level
        la $t0, game_level
	lw $t3, 0($t0) # current game level
	li $t2, 2
        beq $t3, $t2, cle_win # winning at level 2 means winning the game
        # Winning at lower level, so advance game to the next level
	addi $t3, $t3, 1
        sw $t3, 0($t0) 
	li $a0, 4 # play the sound of passing a game level
	li $a1, 0
	li $v0, 202
	syscall
  	# start a new game level
        jal init_game_level
	li $v0, 1
	j cle_exit

cle_lose:      
	li $a0, 3 # play the sound of losing the game
	li $a1, 0
	li $v0, 202
	syscall
	la $a3, game_lose_text # display game losing message
	li $a0, -1 # special ID for this text object
	addi $a1, $zero, 100 # display the message at coordinate (100, 300)
	addi $a2, $zero, 300	
	j cle_end_game
cle_win:
	li $a0, 4 # play the sound of passing a game level
	li $a1, 0
	li $v0, 202
	syscall
	la $a3, game_win_text # display game winning message 
	li $a0, -2 # special ID for this text object
	addi $a1, $zero, 40 # display the message at coordinate (40, 300)
	addi $a2, $zero, 300	
cle_end_game:
	li $v0, 207 # create object of the game winning or losing message	
	syscall 
	# refresh screen
	li $v0, 201
	syscall
	li $a0, 0 # stop background sound
	li $a1, 2
	li $v0, 202
	syscall
	li $v0, 10 # terminate this program
	syscall

cle_exit:
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra

#--------------------------------------------------------------------
# procedure: input_game_params
# get the following information interactively from the user:
# 1) number of score point objects; 2) number of teachers;
# the results will be placed in $v0 and $v1, respectively.
#--------------------------------------------------------------------
input_game_params:
	la $a0, input_scorepoint
	li $v0, 4
	syscall # print string
	li $v0, 5
	syscall # read integer
	addi $t0, $v0, 0 # back up number of score point objects
	la $a0, input_teacher
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	addi $v1, $v0, 0 # keep number of teachers in $v1
	addi $v0, $t0, 0
	jr $ra

#--------------------------------------------------------------------
# procedure: init_game_level
# Initialize a new game level:
# 1. end any Shield mode and any last movement of the student object
# 2. set game level from game_level
# 3. initialize game score to initial_game_score
# 4. create the student object: located at the point (360, 540)
# 5. create num_scorepoint score point objects and num_teacher teacher objects; 
#    their locations are random on the paths of the game maze.
#--------------------------------------------------------------------
init_game_level:
	addi $sp, $sp, -12
	sw $ra, 8($sp)
	sw $s0, 4($sp)
	sw $s1, 0($sp)

	la $t0, move_iteration
	sw $zero, 0($t0) # reset any last movement of student
	la $t0, buffered_move_key
	sw $zero, 0($t0) # reset latest buffered movement input of student

	la $t0, shield_time
	lw $t1, 0($t0) # remaining time of Shield mode
	beq $t1, $zero, igl_start
	sw $zero, 0($t0)
	li $v0, 212 # end Shield mode
	li $a0, 0
	syscall  

igl_start:		
	la $t0, game_level
	lw $a0, 0($t0)
	li $v0, 204 # set game level
	syscall	
	
	la $t0, initial_game_score # initialize game score
	lw $a0, 0($t0)
	la $t0, game_score
	sw $a0, 0($t0)
	li $v0, 203 # set game score
	syscall	
	
	# 1. create the student object
	li $v0, 205
	la $t0, student_id
	lw $a0, 0($t0) # the id of student object
	li $a1, 360 # x_loc of student object (grid cell with column index 12)
	li $a2, 540 # y_loc of student object (grid cell with row index 18)
	li $a3, 1 # object type
	la $t0, student_locs
	sw $a1, 0($t0) 
	sw $a2, 4($t0) 	
	syscall

	# 2. create the specified number of score point objects
	la $t0, scorepoint_num 
	lw $a0, 0($t0) # num of score point objects
	jal create_multi_scorepoints

	# 3. create the specified number of teachers
	la $t0, teacher_num
	lw $a0, 0($t0) # num of teacher objects
	jal create_multi_teachers

igl_exit:
	# refresh screen
	li $v0, 201
	syscall
	lw $ra, 8($sp)
	lw $s0, 4($sp)
	lw $s1, 0($sp)
	addi $sp, $sp, 12
	jr $ra

#--------------------------------------------------------------------
# procedure: get_random_path
# Get a random location that is a path and is vertically or horizontally
# separated in at least loc_separation pixels from the current location of the student object.    
# The x- and y-coordinate of the random location are returned in $v0 and $v1, respectively. 
#--------------------------------------------------------------------
get_random_path:
	la $t0, student_locs
	lw $t4, 0($t0) # x_loc of student
	lw $t5, 4($t0) # y_loc of student
	la $t0, loc_separation
	lw $t7, 0($t0) # separation distance between student location and random location
	sub $t8, $zero, $t7 # -ve separation distance

grp_rand: li $v0, 209 # get random path location
	syscall

	sub $t2, $v0, $t4 # difference between student xloc and random xloc
	slt $t3, $t8, $t2 # greater than -ve separation distance
	beq $t3, $zero, grp_exit
	slt $t3, $t2, $t7 # less than +ve separation distance
	beq $t3, $zero, grp_exit

	sub $t2, $v1, $t5 # difference between student yloc and random yloc
	slt $t3, $t8, $t2 # greater than -ve separation distance
	beq $t3, $zero, grp_exit
	slt $t3, $t2, $t7 # less than +ve separation distance
	bne $t3, $zero, grp_rand
	
grp_exit:	
	jr $ra

#--------------------------------------------------------------------
# procedure: scorepoint_duplicate_loc(num, x, y, skip_id)
# Check whether the given coordinate (x, y) is equal to the location
# of any one of the first num score point objects (in the objects' location array).
# The location of the object with ID skip_id is skipped in the checking. 
# $v0=1 if the equality has been found, otherwise $v0=0.
#--------------------------------------------------------------------
scorepoint_duplicate_loc:
	la $t1, scorepoint_base
	lw $t0, 0($t1) # id of object 
	add $t8, $a0, $zero # remaining number of objects for checking
	la $t9, scorepoint_locs # locations of score point objects
	li $v0, 0

sdl_be:	beq $t8, $zero, sdl_exit # whether num <= 0
	beq $a3, $t0, sdl_next # skip this object of id equal to skip_id
	lw $t2, 0($t9) # x_loc of object 
	lw $t3, 4($t9) # y_loc of object	
	bne $a1, $t2, sdl_next # x_locs differ
	bne $a2, $t3, sdl_next # y_locs differ
	li $v0, 1
	j sdl_exit
	
sdl_next:  # check next object
	addi $t8, $t8, -1
	addi $t0, $t0, 1
	addi $t9, $t9, 8
	j sdl_be
	
sdl_exit:	
	jr $ra

#--------------------------------------------------------------------
# procedure: teacher_duplicate_loc(num, x, y, skip_id)
# Check whether the given coordinate (x, y) is equal to the location
# of any one of the first num teacher objects (based on the increasing oject IDs).
# The location of the object with ID skip_id is skipped in the checking. 
# $v0=1 if the equality has been found, otherwise $v0=0.
#--------------------------------------------------------------------
teacher_duplicate_loc:
	la $t1, teacher_base
	lw $t0, 0($t1) # id of object 
	add $t8, $a0, $zero # remaining number of objects for checking
	li $t9, 0 # checking result

tdl_be:	beq $t8, $zero, tdl_exit # whether num <= 0
	beq $a3, $t0, tdl_next # skip this object of id equal to skip_id
	li $v0, 208 # get teacher location
	addi $a0, $t0, 0
	syscall
	bne $a1, $v0, tdl_next # x_locs differ
	bne $a2, $v1, tdl_next # y_locs differ
	li $t9, 1 
	j tdl_exit
	
tdl_next:  # check next object
	addi $t8, $t8, -1
	addi $t0, $t0, 1
	j tdl_be
	
tdl_exit:	
	addi $v0, $t9, 0
	jr $ra

#--------------------------------------------------------------------
# procedure: create_multi_scorepoints(num)
# @num: the number of score point objects
# Create multiple score point objects
#--------------------------------------------------------------------
create_multi_scorepoints:
	addi $sp, $sp, -36
	sw $ra, 0($sp)
	sw $s0, 4($sp) 
	sw $s1, 8($sp) 
	sw $s2, 12($sp) 
	sw $s3, 16($sp) 
	sw $s4, 20($sp) 
	sw $s5, 24($sp) 
	sw $s6, 28($sp) 
	sw $s7, 32($sp) 

	addi $s0, $a0, 0 # number of objects for creation
	la $t0, scorepoint_base
	lw $s1, 0($t0) # id of a score point object
	la $s2, scorepoint_locs # locations of score point objects
	la $s3, scorepoint_time # remaining time of the visible status of score point objects
	la $s4, scorepoint_sv # SV of score point objects
	li $s5, 0 # number of created objects   

cms_be:	beq $s5, $s0, cms_exit # whether num objects were created 
cms_iter:
	jal get_random_path
	addi $s6, $v0, 0 # x_loc
	addi $s7, $v1, 0 # y_loc
	addi $a0, $s5, 0
	addi $a1, $s6, 0
	addi $a2, $s7, 0
	addi $a3, $s1, 0
	jal scorepoint_duplicate_loc
	bne $v0, $zero, cms_iter

	addi $a1, $s6, 0 # x_loc 
	addi $a2, $s7, 0 # y_loc 
	li $v0, 205 
	addi $a0, $s1, 0 # the id of object
	li $a3, 0 # object type
	sw $a1, 0($s2) 
	sw $a2, 4($s2) 	
	syscall # create object

	sw $v0, 0($s4) 
	li $v0, 210 # get random duration for visible or hidden status of the object 
	syscall
	sw $v0, 0($s3) 	
	
	# create next object
	addi $s5, $s5, 1
	addi $s1, $s1, 1
	addi $s2, $s2, 8
	addi $s3, $s3, 4
	addi $s4, $s4, 4
	j cms_be
	
cms_exit:	
	lw $ra, 0($sp)
	lw $s0, 4($sp) 
	lw $s1, 8($sp) 
	lw $s2, 12($sp) 
	lw $s3, 16($sp) 
	lw $s4, 20($sp) 
	lw $s5, 24($sp) 
	lw $s6, 28($sp) 
	lw $s7, 32($sp) 
	addi $sp, $sp, 36
	jr $ra

#--------------------------------------------------------------------
# procedure: create_multi_teachers(num)
# @num: the number of teacher objects
# Create multiple teacher objects
#--------------------------------------------------------------------
create_multi_teachers:
	addi $sp, $sp, -24
	sw $ra, 0($sp)
	sw $s0, 4($sp) 
	sw $s1, 8($sp) 
	sw $s5, 12($sp) 
	sw $s6, 16($sp) 
	sw $s7, 20($sp) 

	addi $s0, $a0, 0 # number of objects for creation
	la $t0, teacher_base
	lw $s1, 0($t0) # id of a teacher object
	li $s5, 0 # number of created objects   

cmt_be:	beq $s5, $s0, cmt_exit # whether num objects were created 
cmt_iter:
	jal get_random_path  
	addi $s6, $v0, 0 # x_loc
	addi $s7, $v1, 0 # y_loc
	addi $a0, $s5, 0
	addi $a1, $s6, 0
	addi $a2, $s7, 0
	addi $a3, $s1, 0
	jal teacher_duplicate_loc
	bne $v0, $zero, cmt_iter

	addi $a1, $s6, 0 # x_loc 
	addi $a2, $s7, 0 # y_loc 
	li $v0, 205 
	addi $a0, $s1, 0 # the id of object
	li $a3, 2 # object type
	syscall # create object
	
	# create next object
	addi $s5, $s5, 1
	addi $s1, $s1, 1
	j cmt_be
	
cmt_exit:	
	lw $ra, 0($sp)
	lw $s0, 4($sp) 
	lw $s1, 8($sp) 
	lw $s5, 12($sp) 
	lw $s6, 16($sp) 
	lw $s7, 20($sp) 
	addi $sp, $sp, 24
	jr $ra

#--------------------------------------------------------------------
# procedure: get_bitmap_cell(x, y)
# Get the bitmap value for the grid cell containing the given pixel coordinate (x, y). 
# The value will be returned in $v0, or -1 will be returned in $v0 if (x, y) is outside the maze.   
#--------------------------------------------------------------------
get_bitmap_cell:
	la $t0, grid_cell_size
	lw $t1, 0($t0) # cell width	
	lw $t2, 4($t0) # cell height	
	la $t0, grid_col_num
	lw $t3, 0($t0) 
	la $t0, maze_size
	lw $t7, 0($t0) # maze width	
	lw $t8, 4($t0) # maze height	
	li $v0, -1 # initialize the return value to -1

	slti $t5, $a0, 0 # check whether x is outside the maze
	bne $t5, $zero, gbc_exit
	slt $t5, $a0, $t7 
	beq $t5, $zero, gbc_exit
	slti $t5, $a1, 0 # check whether y is outside the maze
	bne $t5, $zero, gbc_exit
	slt $t5, $a1, $t8 
	beq $t5, $zero, gbc_exit

	div $a0, $t1
	mflo $t1 # column no. for given x-coordinate
	div $a1, $t2
	mflo $t2 # row no. for given y-coordinate

	# get the cell from the array
	mult $t3, $t2  
	mflo $t3
	add $t3, $t3, $t1 # index of the cell in 1D-array of bitmap
	la $t0, maze_bitmap
	add $t0, $t0, $t3
	lb $v0, 0($t0)

gbc_exit: 
	jr $ra  

#--------------------------------------------------------------------
# procedure: process_status_input
# Perform the action of the saved keyboard input if it is a valid input
# for changing the game status.
#--------------------------------------------------------------------
process_status_input:	
	la $t0, input_key 
	lw $t1, 0($t0) # input key
	li $t0, 48 # corresponds to key '0'
	beq $t1, $t0, psi_check_shield  
	li $t0, 109 # corresponds to key 'm'
	bne $t1, $t0, psi_exit
	la $t4, background_sound_on
	lw $t0, 0($t4)
	beq $t0, $zero, psi_sound_on # background sound is currently off
	sw $zero, 0($t4) # turn off background sound
	li $a1, 2
	j psi_sound
psi_sound_on: 
	li $t0, 1 # turn on background sound
	sw $t0, 0($t4)
	li $a1, 1
psi_sound: 
	li $a0, 0 # turn on or off background sound
	li $v0, 202
	syscall
	j psi_exit 

psi_check_shield: 
	la $t5, shield_time # check whether game is in Shield mode
	lw $t0, 0($t5)
	bne $t0, $zero, psi_exit # game is already in Shield mode, so no action 			
	la $t0, shield_time_limit # trigger Shield mode
	lw $t0, 0($t0)
	sw $t0, 0($t5)
	li $v0, 212 
	li $a0, 1
	syscall
		 
psi_exit:
	jr $ra

#--------------------------------------------------------------------
# procedure: process_move_input
# Continue any last in-progress movement repesented by move_key, and 
# save any latest movement input key during that process to the
# buffer buffered_move_key.
# If no in-progress movement, perform the action of the new keyboard
# input input_key if it is a valid movement input for the student object,
# otherwise perform the action of any buffered movement input key
# if it is a valid movement input.
# If an input is processed but it cannot actually move the student
# object (e.g. due to a wall), no more movements will be made in later
# iterations for this input. 
#--------------------------------------------------------------------
process_move_input:	
	addi $sp, $sp, -4
	sw $ra, 0($sp)

	la $t6, move_iteration
	lw $t5, 0($t6) # remaining number of game iterations for last movement
	bne $t5, $zero, pmi_last_move # last movement is not completed, so process it
	la $t0, input_key 
	lw $t1, 0($t0) # new input key
	la $t0, initial_move_iteration
	lw $t2, 0($t0)
	addi $t2, $t2, -1 # count this game iteration for any new movement
	sw $t2, 0($t6) # first assume new input key is valid
	la $t8, move_key 
	sw $t1, 0($t8) # save new input key in case it is a movement key
	j pmi_check_buffer
pmi_last_move:
	la $t0, input_key 
	lw $t7, 0($t0) # new input key
	li $t0, 119 # corresponds to key 'w'
	beq $t7, $t0, pmi_buffer  
	li $t0, 115 # corresponds to key 's'
	beq $t7, $t0, pmi_buffer
	li $t0, 97 # corresponds to key 'a'
	beq $t7, $t0, pmi_buffer
	li $t0, 100 # corresponds to key 'd'
	beq $t7, $t0, pmi_buffer
	j pmi_start_move
pmi_buffer:
	la $t0, buffered_move_key
	sw $t7, 0($t0) # buffer latest movement input of student during the in-progress movement
pmi_start_move:
	addi $t5, $t5, -1 # process last movement for one more game iteration
	sw $t5, 0($t6)
	la $t0, move_key 
	lw $t1, 0($t0) # last movement key
	li $a0, 0 # no needs to check again whether this movement can actually move the object 
	j pmi_check
pmi_check_buffer:
	li $a0, 1 # check whether this movement can actually move the student object
	la $t0, buffered_move_key
	lw $t9, 0($t0) # check whether buffered movement input is valid
	sw $zero, 0($t0) # reset buffer
	li $t0, 119 # corresponds to key 'w'
	beq $t1, $t0, pmi_move_up  
	li $t0, 115 # corresponds to key 's'
	beq $t1, $t0, pmi_move_down
	li $t0, 97 # corresponds to key 'a'
	beq $t1, $t0, pmi_move_left
	li $t0, 100 # corresponds to key 'd'
	beq $t1, $t0, pmi_move_right
	sw $t9, 0($t8) # save buffered input key in case it is a movement key
	addi $t1, $t9, 0
pmi_check:
	li $t0, 119 # corresponds to key 'w'
	beq $t1, $t0, pmi_move_up  
	li $t0, 115 # corresponds to key 's'
	beq $t1, $t0, pmi_move_down
	li $t0, 97 # corresponds to key 'a'
	beq $t1, $t0, pmi_move_left
	li $t0, 100 # corresponds to key 'd'
	beq $t1, $t0, pmi_move_right
	sw $zero, 0($t6) # above assumption of new input key or buffered key being valid is wrong
	j pmi_exit

pmi_move_up: 
	jal move_student_up
	j pmi_after_move
pmi_move_down:
	jal move_student_down
	j pmi_after_move
pmi_move_left:
	jal move_student_left
	j pmi_after_move
pmi_move_right:
	jal move_student_right		

pmi_after_move:
	bne $v0, $zero, pmi_shield # actual movement has been made
	la $t6, move_iteration
	sw $zero, 0($t6) # current movement is blocked by a wall, so no more movements in later iterations for the move_key
	j pmi_exit

pmi_shield: jal update_shield_status
pmi_exit: 
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra

#--------------------------------------------------------------------
# procedure: process_quiz_input
# Perform the action of the saved keyboard input if it is a valid input
# for the Quiz mode, assuming the game is currently in the Quiz mode.
#--------------------------------------------------------------------
process_quiz_input:	
	addi $sp, $sp, -4
	sw $ra, 0($sp)

	la $t0, input_key 
	lw $t1, 0($t0) # input key
	addi $t1, $t1, -48 # selected choice no. (input - '0')
	slti $t2, $t1, 1
	bne $t2, $zero, pqi_exit # selected choice no. < 1
	slti $t2, $t1, 5
	beq $t2, $zero, pqi_exit # selected choice no. > 4
	la $t0, quiz_time # end Quiz mode after the valid input for a choice selection 
	sw $zero, 0($t0) 
	li $v0, 211 
	li $a0, 0
	syscall

	la $t0, quiz_answer # check correctness of selected choice
	lw $t0, 0($t0)
	beq $t0, $t1, pqi_shield # selected choice is correct answer 
	la $t0, game_score 
	lw $a0, 0($t0)
	addi $a0, $a0, -10 # decrease game score by 10
	sw $a0, 0($t0)
	li $v0, 203 # set game score
	syscall
	slt $a0, $zero, $a0	
	beq $a0, $zero, pqi_exit # skip the rest of actions because of game over

	li $a0, 2 
	li $a1, 0
	li $v0, 202 # play the sound of losing game score
	syscall
	jal teleport_student
	j pqi_exit

pqi_shield: 	
	la $t0, shield_time_limit # trigger Shield mode
	lw $t0, 0($t0)
	la $t2, shield_time
	sw $t0, 0($t2)
	li $v0, 212 
	li $a0, 1
	syscall
		 
pqi_exit:
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra

#--------------------------------------------------------------------
# procedure: teleport_student
# Teleport the student object by putting it in a random path cell of the
# maze, where it does not collide with any score point object or teacher object. 
# Any in-progress student movement will be stopped, and any student movement input 
# saved during the in-progress movement will be reset.   
#--------------------------------------------------------------------	
teleport_student:
	addi $sp, $sp, -16
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)
	sw $s2, 12($sp)

	la $s0, student_locs
	la $t0, scorepoint_num 
	lw $s1, 0($t0) # num of score point objects
	la $t0, scorepoint_base
	lw $s2, 0($t0)
	addi $s2, $s2, -1 # create a non-existing id of a score point object

	la $t0, move_iteration
	sw $zero, 0($t0) # stop any in-progress student movement
	la $t0, buffered_move_key
	sw $zero, 0($t0) # reset any buffered movement key

ts_new_loc: # get a new student location and check its validity
	li $v0, 209 # get random path location
	syscall
	sw $v0, 0($s0) # save new x_loc first
	sw $v1, 4($s0) # save new y_loc first
	addi $a0, $s1, 0
	addi $a1, $v0, 0
	addi $a2, $v1, 0
	addi $a3, $s2, 0
	jal scorepoint_duplicate_loc
	bne $v0, $zero, ts_new_loc
	jal check_teacher_collisions
	bne $v0, $zero, ts_new_loc # collision with a teacher

	la $t0, student_id
	lw $a0, 0($t0)
	lw $a1, 0($s0)
	lw $a2, 4($s0)
	li $a3, 1 # object type
	li $v0, 206
	syscall # set new object location
	
	lw $ra, 0($sp)
	lw $s0, 4($sp)
	lw $s1, 8($sp)
	lw $s2, 12($sp)
	addi $sp, $sp, 16
	jr $ra

#--------------------------------------------------------------------
# procedure: move_student_up(check_validity)
# Move the student object upward by one step which is its speed.
# If check_validity is not 0, move the object only when the object will not
# overlap with a wall cell afterward. 
# If the student object is completely above the upper-border of the maze after the movement,
# only change the y-coordinate of its location to the maze's height minus its height.
# $v0=1 if a movement has been made, otherwise $v0=0.
#--------------------------------------------------------------------	
move_student_up:
		addi $sp, $sp, -24
		sw $ra, 0($sp)
		sw $s0, 4($sp)
		sw $s1, 8($sp)
		sw $s2, 12($sp)
		sw $s3, 16($sp)
		sw $s4, 20($sp)

		la $t0, student_size
		lw $s3, 0($t0) # student width	
		lw $s4, 4($t0) # student height	
		la $t0, maze_size
		lw $t2, 4($t0) # maze height	

		la $t0, student_speed
		lw $t3, 0($t0) # student speed
		la $s2, student_locs
		lw $s0, 0($s2) # x_loc
		lw $s1, 4($s2) # y_loc
		sub $s1, $s1, $t3 # new y_loc

		add $t9, $s1, $s4
		addi $t9, $t9, -1 # y-coordinate of student's bottom corners		
		slt $t4, $t9, $zero # y-coordinate of upper-border is 0
		beq $t4, $zero, msu_check_path 
		sub $s1, $t2, $s4
		j msu_save_yloc

msu_check_path:	beq $a0, $zero, msu_save_yloc
		# check whether student's top-left corner is in a wall 
		addi $a0, $s0, 0
		addi $a1, $s1, 0
		jal get_bitmap_cell
		slt $v0, $zero, $v0 
		bne $v0, $zero, msu_no_move   

msu_save_yloc:	sw $s1, 4($s2) # save new y_loc
		la $t0, student_id
		lw $a0, 0($t0)
		addi $a1, $s0, 0
		addi $a2, $s1, 0
		li $a3, 1 # object type
		li $v0, 206
		syscall # set new object location
		li $v0, 1
		j msu_exit
	
msu_no_move:	li $v0, 0		 
msu_exit:	lw $ra, 0($sp)
		lw $s0, 4($sp)
		lw $s1, 8($sp)
		lw $s2, 12($sp)
		lw $s3, 16($sp)
		lw $s4, 20($sp)
		addi $sp, $sp, 24
		jr $ra

#--------------------------------------------------------------------
# procedure: move_student_down(check_validity)
# Move the student object downward by one step which is its speed.
# If check_validity is not 0, move the object only when the object will not
# overlap with a wall cell afterward. 
# If the student object is completely below the lower-border of the maze after the movement,
# only change the y-coordinate of its location to 0.
# $v0=1 if a movement has been made, otherwise $v0=0.
#--------------------------------------------------------------------	
move_student_down:
		addi $sp, $sp, -24
		sw $ra, 0($sp)
		sw $s0, 4($sp)
		sw $s1, 8($sp)
		sw $s2, 12($sp)
		sw $s3, 16($sp)
		sw $s4, 20($sp)

		la $t0, student_size
		lw $s3, 0($t0) # student width	
		lw $s4, 4($t0) # student height	
		la $t0, maze_size
		lw $t2, 4($t0) # maze height	

		la $t0, student_speed
		lw $t3, 0($t0) # student speed
		la $s2, student_locs
		lw $s0, 0($s2) # x_loc
		lw $s1, 4($s2) # y_loc
		add $s1, $s1, $t3 # new y_loc

		addi $t2, $t2, -1 # y-coordinate of lower-border is (height - 1)
		slt $t4, $t2, $s1
		beq $t4, $zero, msd_check_path 
		li $s1, 0
		j msd_save_yloc

msd_check_path:	beq $a0, $zero, msd_save_yloc
		# check whether student's bottom-left corner is in a wall
		addi $a0, $s0, 0
		add $a1, $s1, $s4
		addi $a1, $a1, -1 # y-coordinate of student's bottom corners	
		jal get_bitmap_cell
		slt $v0, $zero, $v0 
		bne $v0, $zero, msd_no_move  

msd_save_yloc:	sw $s1, 4($s2) # save new y_loc
		la $t0, student_id
		lw $a0, 0($t0)
		addi $a1, $s0, 0
		addi $a2, $s1, 0
		li $a3, 1 # object type
		li $v0, 206
		syscall # set new object location
		li $v0, 1
		j msd_exit
	
msd_no_move:	li $v0, 0				 
msd_exit:	lw $ra, 0($sp)
		lw $s0, 4($sp)
		lw $s1, 8($sp)
		lw $s2, 12($sp)
		lw $s3, 16($sp)
		lw $s4, 20($sp)
		addi $sp, $sp, 24
		jr $ra

#--------------------------------------------------------------------
# procedure: move_student_left(check_validity)
# Move the student object leftward by one step which is its speed.
# If check_validity is not 0, move the object only when the object will not
# overlap with a wall cell afterward. 
# If the student object is completely on the left of the left-border of the maze after the movement,
# only change the x-coordinate of its location to the maze's width minus its width.
# $v0=1 if a movement has been made, otherwise $v0=0.
#--------------------------------------------------------------------	
move_student_left:

# *****Task1: you need to complete this procedure move_student_left to perform its operations described in its comments above. 
# *****Your codes start here













# *****Your codes end here

#--------------------------------------------------------------------
# procedure: move_student_right(check_validity)
# Move the student object rightward by one step which is its speed.
# If check_validity is not 0, move the object only when the object will not
# overlap with a wall cell afterward. 
# If the student object is completely on the right of the right-border of the maze after the movement,
# only change the x-coordinate of its location to 0. 
# $v0=1 if a movement has been made, otherwise $v0=0.
#--------------------------------------------------------------------	
move_student_right:

# *****Task2: you need to complete this procedure move_student_right to perform its operations described in its comments above. 
# *****Your codes start here
















# *****Your codes end here

#--------------------------------------------------------------------
# procedure: update_scorepoint_status
# Decrement the remaining time of the current visible or hidden status
# of each score point object by one (one game iteration).
# If the time of an object becomes zero, then change its status from visible
# to hidden (using x-coordinate -9999) and vice versa, and finally re-initialize the time. 
#--------------------------------------------------------------------
update_scorepoint_status:
	addi $sp, $sp, -36
	sw $ra, 0($sp)
	sw $s0, 4($sp) 
	sw $s1, 8($sp) 
	sw $s2, 12($sp) 
	sw $s3, 16($sp) 
	sw $s4, 20($sp) 
	sw $s5, 24($sp) 
	sw $s6, 28($sp) 
	sw $s7, 32($sp) 

	la $t0, scorepoint_num
	lw $s0, 0($t0) # number of objects
	la $t0, scorepoint_base
	lw $s1, 0($t0) # id of a score point object
	la $s2, scorepoint_locs # locations of score point objects
	la $s3, scorepoint_time # remaining time of the visible status of score point objects
	la $s4, scorepoint_sv # SV of score point objects
	addi $s5, $s0, 0 # loop counter

uss_be:	beq $s5, $zero, uss_exit # whether num <= 0
	lw $v0, 0($s3)
	addi $v0, $v0, -1 
	bne $v0, $zero, uss_save # no status change for this object
	lw $s6, 0($s2) # x_loc of object 
	li $t4, -9999
	beq $s6, $t4, uss_show # current status is "hidden"

	# hide the object
	sw $t4, 0($s2) 
	lw $s7, 4($s2) # y_loc of object 
	addi $a1, $t4, 0 # x_loc 
	addi $a2, $s7, 0 # y_loc 
	li $v0, 206 
	addi $a0, $s1, 0 # the id of object
	li $a3, 0 # object type
	syscall # set object location
	j uss_time

uss_show: # create and show a new object to replace of the old one of the same id 
	jal get_random_path
	addi $s6, $v0, 0 # x_loc
	addi $s7, $v1, 0 # y_loc
	addi $a0, $s0, 0
	addi $a1, $s6, 0
	addi $a2, $s7, 0
	addi $a3, $s1, 0
	jal scorepoint_duplicate_loc
	bne $v0, $zero, uss_show # duplicate object locations occur

	 # create object
	addi $a1, $s6, 0 # x_loc 
	addi $a2, $s7, 0 # y_loc 
	li $v0, 205 
	addi $a0, $s1, 0 # the id of object
	li $a3, 0 # object type
	sw $a1, 0($s2) 
	sw $a2, 4($s2) 	
	syscall
	sw $v0, 0($s4) 

uss_time:
	li $v0, 210 # get random duration for visible or hidden status of the object 
	syscall
uss_save:
	sw $v0, 0($s3) # save the updated duration	
	
uss_next:
	# update next object
	addi $s5, $s5, -1
	addi $s1, $s1, 1
	addi $s2, $s2, 8
	addi $s3, $s3, 4
	addi $s4, $s4, 4
	j uss_be
	
uss_exit:	
	lw $ra, 0($sp)
	lw $s0, 4($sp) 
	lw $s1, 8($sp) 
	lw $s2, 12($sp) 
	lw $s3, 16($sp) 
	lw $s4, 20($sp) 
	lw $s5, 24($sp) 
	lw $s6, 28($sp) 
	lw $s7, 32($sp) 
	addi $sp, $sp, 36
	jr $ra

#--------------------------------------------------------------------
# procedure: update_quiz_status
# If the game is in the Quiz mode, decrement the mode's remaining time by one (one game iteration).
# After any decrement, if the time equals quiz_alert_time, change the
# screen to alert the player that; if the time equals zero, end the mode.
#--------------------------------------------------------------------
update_quiz_status:
	addi $sp, $sp, -4
	sw $ra, 0($sp)

	la $t0, quiz_time
	lw $t1, 0($t0) # remaining time of Quiz mode
	beq $t1, $zero, uqs_exit
	addi $t1, $t1, -1 
	sw $t1, 0($t0)
	la $t0, quiz_alert_time
	lw $t0, 0($t0)
	beq $t1, $t0, uqs_alert 
	bne $t1, $zero, uqs_exit
	li $v0, 211 # Quiz mode has expired, so end it
	li $a0, 0
	syscall 

	la $t0, game_score 
	lw $a0, 0($t0)
	addi $a0, $a0, -10 # decrease game score by 10
	sw $a0, 0($t0)
	li $v0, 203 # set game score
	syscall	
	slt $a0, $zero, $a0	
	beq $a0, $zero, uqs_exit # skip the rest of actions because of game over

	li $a0, 2 
	li $a1, 0
	li $v0, 202 # play the sound of losing game score
	syscall
	jal teleport_student
	j uqs_exit
uqs_alert: 
	li $v0, 211 # Quiz mode is near its expiration, so alert player that
	li $a0, 2
	syscall 
uqs_exit:
	lw $ra, 0($sp)
	addi $sp, $sp, 4	
	jr $ra

#--------------------------------------------------------------------
# procedure: update_shield_status
# If the game is in the Shield mode, decrement the mode's remaining
# time by one (one movement input of the student object).
# After any decrement, if the time equals shield_alert_time, change the
# screen to alert the player that; if the time equals zero, end the mode. 
#--------------------------------------------------------------------
update_shield_status:
	la $t0, shield_time
	lw $t1, 0($t0) # remaining time of Shield mode
	beq $t1, $zero, uks_exit
	addi $t1, $t1, -1 
	sw $t1, 0($t0)
	la $t0, shield_alert_time
	lw $t0, 0($t0)
	beq $t1, $t0, uks_alert 
	bne $t1, $zero, uks_exit
	li $v0, 212 # Shield mode has expired, so end it
	li $a0, 0
	syscall
	li $a0, 5 # play sound of ending Shield mode
	li $a1, 0
	li $v0, 202
	syscall
	j uks_exit  
uks_alert: 
	li $v0, 212 # Shield mode is near its expiration, so alert player that
	li $a0, 2
	syscall 
uks_exit:	
	jr $ra

#--------------------------------------------------------------------
# procedure: check_scorepoint_collisions
# Check whether the student object collides with any visible score point objects.
# After a collision is found, increment the game score by the SV of the collided
# score point object and hide it, and then skip further collision checking for any other
# score point objects.
#--------------------------------------------------------------------
check_scorepoint_collisions:
	addi $sp, $sp, -36
	sw $ra, 0($sp)
	sw $s0, 4($sp) 
	sw $s1, 8($sp) 
	sw $s2, 12($sp) 
	sw $s3, 16($sp) 
	sw $s4, 20($sp) 
	sw $s5, 24($sp) 
	sw $s6, 28($sp) 
	sw $s7, 32($sp) 

	la $t0, scorepoint_num
	lw $s0, 0($t0) # number of objects
	la $t0, scorepoint_base
	lw $s1, 0($t0) # id of a score point object
	la $s2, scorepoint_locs # locations of score point objects
	la $t0, scorepoint_size
	lw $s3, 0($t0) # score point object width	
	lw $s4, 4($t0) # score point object height	
	la $s5, student_locs # location of student object
	la $t0, student_size
	lw $s6, 0($t0) # student width	
	lw $s7, 4($t0) # student height	

csc_be:	beq $s0, $zero, csc_exit # whether num <= 0
	lw $t6, 0($s2) # x_loc of score point object 
	li $t4, -9999
	beq $t6, $t4, csc_next # object is hidden, so no collision checking for it
	lw $t7, 4($s2) # y_loc of score point object
	lw $t0, 0($s5) # x_loc of student object 
	lw $t1, 4($s5) # y_loc of student object 

# *****Task5.1: you need to check if the student object intersects the score point object.
# You should call procedure: check_intersection to check the intersection.

# Hints:
# The student rectangle's top-left point: (x1, y1), x1 is in $t0, y1 is in $t1
# The student rectangle's bottom-right point: (student width + x1 - 1, student height + y1 - 1)
# The score-point rectangle's top-left point: (x2, y2), x2 is in $t6, y2 is in $t7
# The score-point rectangle's bottom-right point: (score-point width + x2 - 1, score-point height + y2 - 1)

# Those points' coordinates should be stored in stack before calling procedure: check_intersection
# @params: the coordinates of RectA(rectangle of student) and RectB(rectangle of score point object) are passed through stack.
# 	   In total, 8 words are passed. RectA is followed by RectB in the stack, as shown below. 
#	
#	| RectA.topleft_x |
#	| RectA.topleft_y |
#	| RectA.botrigh_x |
#	| RectA.botrigh_y |
#	| RectB.topleft_x |
#	| RectB.topleft_y |
#	| RectB.botrigh_x |
#	| RectB.botrigh_y | <-- $sp 
# *****Your codes start here
		








	
# *****Your codes end here

        # After calling procedure check_intersection, $v0=0 if the student has not intersected the score point object
	beq $v0, $zero, csc_next 
	# hide the object
	li $a1, -9999
	sw $a1, 0($s2) # x_loc
	lw $a2, 4($s2) # y_loc 
	li $v0, 206 
	addi $a0, $s1, 0 # the id of object
	li $a3, 0 # object type
	syscall # set object location

	# get offset for this object in array memory
	la $t0, scorepoint_base
	lw $t0, 0($t0)
	sub $t0, $s1, $t0 # array index
	sll $t0, $t0, 2 # memory offset

	li $v0, 210 # get random duration for the hidden status
	syscall
	la $t1, scorepoint_time	
	add $t1, $t1, $t0
	sw $v0, 0($t1) 	

# *****Task5.2: you need to increase the game score by the SV of the score point object in collision with the student.
# *****Your codes start here










# *****Your codes end here

	li $a0, 1 
	li $a1, 0
	li $v0, 202 # play the sound of obtaining game score
	syscall
	j csc_exit # skip collision checking for other objects
	
csc_next:
	# update next object
	addi $s0, $s0, -1
	addi $s1, $s1, 1
	addi $s2, $s2, 8
	j csc_be
	
csc_exit:	
	lw $ra, 0($sp)
	lw $s0, 4($sp) 
	lw $s1, 8($sp) 
	lw $s2, 12($sp) 
	lw $s3, 16($sp) 
	lw $s4, 20($sp) 
	lw $s5, 24($sp) 
	lw $s6, 28($sp) 
	lw $s7, 32($sp) 
	addi $sp, $sp, 36
	jr $ra

#--------------------------------------------------------------------
# procedure: check_teacher_collisions
# Check whether the student object collides with a teacher object.
# After a collision has been found, skip further
# collision checking for any other teacher objects.
# $v0=1 if a collision has been found, otherwise $v0=0.
#--------------------------------------------------------------------
check_teacher_collisions:
	addi $sp, $sp, -32
	sw $ra, 0($sp)
	sw $s0, 4($sp) 
	sw $s1, 8($sp) 
	sw $s7, 12($sp) 
	sw $s3, 16($sp) 
	sw $s4, 20($sp) 
	sw $s5, 24($sp) 
	sw $s6, 28($sp) 


	la $t0, teacher_num
	lw $s0, 0($t0) # number of objects
	la $t0, teacher_base
	lw $s1, 0($t0) # id of a teacher object

	la $t0, teacher_size
	lw $s3, 0($t0) # teacher object width	
	lw $s4, 4($t0) # teacher object height	
	la $s5, student_locs # location of student object
	la $t0, student_size
	lw $s6, 0($t0) # student width	
	lw $s7, 4($t0) # student height	

ctc_be:	beq $s0, $zero, ctc_no_collision # whether num <= 0
	li $v0, 208 # get location of teacher object
	addi $a0, $s1, 0
	syscall
	lw $t0, 0($s5) # x_loc of student object 
	lw $t1, 4($s5) # y_loc of student object 

# *****Task4: you need to check if the student object intersects the teacher object.
# You should call procedure: check_intersection to check the intersection.

# Hints:
# The student rectangle's top-left point: (x1, y1), x1 is in $t0, y1 is in $t1
# The student rectangle's bottom-right point: (student width + x1 - 1, student height + y1 - 1)
# The teacher rectangle's top-left point: (x2, y2), x2 is in $v0, y2 is in $v1
# The teacher rectangle's bottom-right point: (teacher width + x2 - 1, teacher height + y2 - 1)

# Those points' coordinates should be stored in stack before calling procedure: check_intersection
# @params: the coordinates of RectA(rectangle of student) and RectB(rectangle of teacher) are passed through stack.
# 	   In total, 8 words are passed. RectA is followed by RectB in the stack, as shown below. 
#	
#	| RectA.topleft_x |
#	| RectA.topleft_y |
#	| RectA.botrigh_x |
#	| RectA.botrigh_y |
#	| RectB.topleft_x |
#	| RectB.topleft_y |
#	| RectB.botrigh_x |
#	| RectB.botrigh_y | <-- $sp 
# *****Your codes start here
		












	
# *****Your codes end here

        # After calling procedure: check_intersection, $v0=0 if the student missed the teacher object
	beq $v0, $zero, ctc_next 
	li $v0, 1 
	j ctc_exit # skip collision checking for other objects
	
ctc_next:
	# update next object
	addi $s0, $s0, -1
	addi $s1, $s1, 1
	j ctc_be

ctc_no_collision:
	li $v0, 0 	
ctc_exit:	
	lw $ra, 0($sp)
	lw $s0, 4($sp) 
	lw $s1, 8($sp) 
	lw $s7, 12($sp) 
	lw $s3, 16($sp) 
	lw $s4, 20($sp) 
	lw $s5, 24($sp) 
	lw $s6, 28($sp) 
	addi $sp, $sp, 32
	jr $ra
	
#--------------------------------------------------------------------
# procedure: check_intersection(RectA, RectB)
# @RectA: ((x1, y1), (x2, y2))
# @RectB: ((x3, y3), (x4, y4))
# these 8 parameters are passed through stack!
# @params: the coordinates of RectA and RectB are passed through stack.
# 	   In total, 8 words are passed. RectA is followed by RectB, as shown below. 
#	
#	| RectA.topleft_x |
#	| RectA.topleft_y |
#	| RectA.botrigh_x |
#	| RectA.botrigh_y |
#	| RectB.topleft_x |
#	| RectB.topleft_y |
#	| RectB.botrigh_x |
#	| RectB.botrigh_y | <-- $sp 

# This procedure is to check whether the above two rectangles intersect each other!
# @return $v0=1: true(intersect with each other); 0: false
#--------------------------------------------------------------------
check_intersection:

#*****Task3:
# Hints:
# Firstly, load 8 parameters/coordinates from the stack.
# Secondly, check the conditions in which there could be no intersection:
#          condition1: whether RectA's left edge is to the right of RectB's right edge;
#          condition2: whether RectA's right edge is to the left of RectB's left edge;
#          condition3: whether RectA's top edge is below RectB's bottom edge;
#          condition4: whether RectA's bottom edge is above RectB's top edge.
# Thirdly, set the value of $v0 based on the check result. Then: jr $ra 
#*****Your codes start here

	# condition1: whether A's left edge is to the right of B's right edge,






	# condition2: whether A's right edge is to the left of B's left edge,






	
	# condition3: whether A's top edge is below B's bottom edge,







	# conditon4: whether A's bottom edge is above B's top edge,









#*****Your codes end here


#--------------------------------------------------------------------
# procedure: get_time
# Get the current time
# $v0 = current time
#--------------------------------------------------------------------
get_time:	li $v0, 30
		syscall # this syscall also changes the value of $a1
		andi $v0, $a0, 0x3FFFFFFF # truncated to milliseconds from some years ago
		jr $ra

#--------------------------------------------------------------------
# procedure: have_a_nap(last_iteration_time, nap_time)
#--------------------------------------------------------------------
have_a_nap:
	addi $sp, $sp, -8
	sw $ra, 4($sp)
	sw $s0, 0($sp)

	add $s0, $a0, $a1
	jal get_time
	sub $a0, $s0, $v0
	slt $t0, $zero, $a0 
	bne $t0, $zero, han_p
	li $a0, 1 # sleep for at least 1ms
han_p:	li $v0, 32 # syscall: let mars java thread sleep $a0 milliseconds
	syscall

	lw $ra, 4($sp)
	lw $s0, 0($sp)
	addi $sp, $sp, 8
	jr $ra
	
#--------------------------------------------------------------------
# procedure: get_keyboard_input
# If an input is available, save its ASCII value in the array input_key,
# otherwise save the value 0 in input_key.
#--------------------------------------------------------------------
get_keyboard_input:
		add $t2, $zero, $zero
		lui $t0, 0xFFFF
		lw $t1, 0($t0)
		andi $t1, $t1, 1
		beq $t1, $zero, gki_exit
		lw $t2, 4($t0)

gki_exit:	la $t0, input_key 
		sw $t2, 0($t0) # save input key
		jr $ra

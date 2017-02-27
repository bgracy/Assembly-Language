.data
	Reg4:		.asciiz "\nRegister $s4, user input, equals: "
	Reg2:		.asciiz "\nRegister $s2, words left, equals: "
	InvalidWord:	.asciiz "\nThe word you entered uses invalid characters."

.text
UpdateS2:
	# call the correct function number (ex: guessedSeven, guessedSix, etc)
	beq $a2, 7, guessedSeven
	beq $a2, 6, guessedSix
	beq $a2, 5, guessedFive
	beq $a2, 4, guessedFour
	beq $a2, 3, guessedThree
	beq $a2, 2, guessedTwo
CheckS2:
	# check $s2 to see if a user can guess a word of that size
	beq $a2, 7, getSeven
	beq $a2, 6, getSix
	beq $a2, 5, getFive
	beq $a2, 4, getFour
	beq $a2, 3, getThree
	beq $a2, 2, getTwo

guessedSeven:
	# change number of size 7 words left to guess & score += 7
	subi $s2, $s2, 1000000 
	addi $s3, $s3, 7
	jr $ra 
guessedSix:
	# change number of size 6 words left to guess & score += 6
	subi $s2, $s2, 100000
	addi $s3, $s3, 6
	jr $ra 
guessedFive:
	# change number of size 5 words left to guess & score += 5
	subi $s2, $s2, 10000
	addi $s3, $s3, 5
	jr $ra
guessedFour:
	# change number of size 4 words left to guess & score += 4
	subi $s2, $s2, 1000
	addi $s3, $s3, 4
	jr $ra 
guessedThree:
	# change number of size 3 words left to guess & score += 3
	subi $s2, $s2, 100
	addi $s3, $s3, 3
	jr $ra
guessedTwo:
	# change number of size 2 words left to guess & score += 2
	subi $s2, $s2, 10
	addi $s3, $s3, 2
	jr $ra 
#	
# getSize gets number of words of size "Size"	
#
getSeven: 
	# put the number of size 7 words left to guess in $a0
	li $t0, 1000000
	div $s2, $t0 # quotient is number of size 7 words and stored in LO
	mflo $a0 # move number of size 7 words into $a0
	jr $ra # $ra preserved since no calls made
getSix: 
	# preserve $ra 
	subiu $sp, $sp, 4 # make room for $ra
	sw $ra, ($sp) # save $ra to the top of the stack
#
	# ignore size 7 words
	jal getSeven
	li $t0, 1000000 
	mult $a0, $t0 
	mflo $t0 # move the lower 32 bits of multiplication into $t0
	sub $a1, $s2, $t0 # remove size 7 words from $s2 and store in $a0
#	
	# put the number of size 6 words left to guess in $a0
	li $t0, 100000
	div $a1, $t0 # quotient is number of size 6 words and stored in LO
	mflo $a0 # move number of size 6 words into $a0
#
	lw $ra, ($sp) # restore $ra 
	addiu $sp, $sp, 4 # remove room taken by $ra
	jr $ra # return to caller
getFive: 	
	# preserve $ra 
	subiu $sp, $sp, 4 # make room for $ra
	sw $ra, ($sp) # save $ra to the top of the stack
#
	# ignore size 7 words
	jal getSeven
	li $t0, 1000000 
	mult $a0, $t0 
	mflo $t0 # move the lower 32 bits of multiplication into $t0
	sub $a1, $s2, $t0 # remove size 7 words from $s2 and store in $a1
	# ignore size 6 words
	jal getSix
	li $t0, 100000 
	mult $a0, $t0 
	mflo $t0 # move the lower 32 bits of multiplication into $t0
	sub $a1, $a1, $t0 # remove size 6 words from $a1 and store in $a1
#	
	# put the number of size 5 words left to guess in $a0
	li $t0, 10000
	div $a1, $t0 # quotient is number of size 5 words and stored in LO
	mflo $a0 # move number of size 5 words into $a0
#
	lw $ra, ($sp) # restore $ra 
	addiu $sp, $sp, 4 # remove room taken by $ra
	jr $ra # return to caller
getFour: 
	# preserve $ra 
	subiu $sp, $sp, 4 # make room for $ra
	sw $ra, ($sp) # save $ra to the top of the stack
#
	# ignore size 7 words
	jal getSeven
	li $t0, 1000000 
	mult $a0, $t0 
	mflo $t0 # move the lower 32 bits of multiplication into $t0
	sub $a1, $s2, $t0 # remove size 7 words from $s2 and store in $a1
	# ignore size 6 words
	jal getSix
	li $t0, 100000 
	mult $a0, $t0 
	mflo $t0 # move the lower 32 bits of multiplication into $t0
	sub $a1, $a1, $t0 # remove size 6 words from $a1 and store in $a1
	# ignore size 5 words
	jal getFive
	li $t0, 10000 
	mult $a0, $t0 
	mflo $t0 # move the lower 32 bits of multiplication into $t0
	sub $a1, $a1, $t0 # remove size 5 words from $a1 and store in $a1
#	
	# put the number of size 4 words left to guess in $a0
	li $t0, 1000
	div $a1, $t0 # quotient is number of size 3 words and stored in LO
	mflo $a0 # move number of size 4 words into $a0
#
	lw $ra, ($sp) # restore $ra 
	addiu $sp, $sp, 4 # remove room taken by $ra
	jr $ra # return to caller
getThree: 
	# preserve $ra 
	subiu $sp, $sp, 4 # make room for $ra
	sw $ra, ($sp) # save $ra to the top of the stack
#
	# ignore size 7 words
	jal getSeven
	li $t0, 1000000 
	mult $a0, $t0 
	mflo $t0 # move the lower 32 bits of multiplication into $t0
	sub $a1, $s2, $t0 # remove size 7 words from $s2 and store in $a1
	# ignore size 6 words
	jal getSix
	li $t0, 100000 
	mult $a0, $t0 
	mflo $t0 # move the lower 32 bits of multiplication into $t0
	sub $a1, $a1, $t0 # remove size 6 words from $a1 and store in $a1
	# ignore size 5 words
	jal getFive
	li $t0, 10000 
	mult $a0, $t0 
	mflo $t0 # move the lower 32 bits of multiplication into $t0
	sub $a1, $a1, $t0 # remove size 5 words from $a1 and store in $a1
	# ignore size 4 words
	jal getFour
	li $t0, 1000 
	mult $a0, $t0 
	mflo $t0 # move the lower 32 bits of multiplication into $t0
	sub $a1, $a1, $t0 # remove size 4 words from $a1 and store in $a1
#	
	# put the number of size 3 words left to guess in $a0
	li $t0, 100
	div $a1, $t0 # quotient is number of size 3 words and stored in LO
	mflo $a0 # move number of size 3 words into $a0
#
	lw $ra, ($sp) # restore $ra 
	addiu $sp, $sp, 4 # remove room taken by $ra
	jr $ra # return to caller
getTwo: 
	# preserve $ra 
	subiu $sp, $sp, 4 # make room for $ra
	sw $ra, ($sp) # save $ra to the top of the stack
#
	# ignore size 7 words
	jal getSeven
	li $t0, 1000000 
	mult $a0, $t0 
	mflo $t0 # move the lower 32 bits of multiplication into $t0
	sub $a1, $s2, $t0 # remove size 7 words from $s2 and store in $a1
	# ignore size 6 words
	jal getSix
	li $t0, 100000 
	mult $a0, $t0 
	mflo $t0 # move the lower 32 bits of multiplication into $t0
	sub $a1, $a1, $t0 # remove size 6 words from $a1 and store in $a1
	# ignore size 5 words
	jal getFive
	li $t0, 10000 
	mult $a0, $t0 
	mflo $t0 # move the lower 32 bits of multiplication into $t0
	sub $a1, $a1, $t0 # remove size 5 words from $a1 and store in $a1
	# ignore size 4 words
	jal getFour
	li $t0, 1000 
	mult $a0, $t0 
	mflo $t0 # move the lower 32 bits of multiplication into $t0
	sub $a1, $a1, $t0 # remove size 4 words from $a1 and store in $a1
	# ignore size 3 words
	jal getThree
	li $t0, 100 
	mult $a0, $t0 
	mflo $t0 # move the lower 32 bits of multiplication into $t0
	sub $a1, $a1, $t0 # remove size 3 words from $a1 and store in $a1
#	
	# put the number of size 2 words left to guess in $a0
	li $t0, 10
	div $a1, $t0 # quotient is number of size 2 words and stored in LO
	mflo $a0 # move number of size 2 words into $a0
#
	lw $ra, ($sp) # restore $ra 
	addiu $sp, $sp, 4 # remove room taken by $ra
	jr $ra # return to caller
Jumbline_Motif:
	li $v0,33
	addi $a0, $zero, 100	#pitch (0-127)
	addi $a1, $zero, 100	#duration in milliseconds
	addi $a2, $zero, 98	#instrument (0-127)#109 #110 = good beep
	addi $a3, $zero, 70	#volume (0-127)
	syscall 
	li $v0,33
	addi $a0, $zero, 100	#pitch (0-127)
	addi $a1, $zero, 200	#duration in milliseconds
	addi $a2, $zero, 98	#instrument (0-127)#109 #110 = good beep
	addi $a3, $zero, 70	#volume (0-127)
	syscall 
		li $v0,33
	addi $a0, $zero, 100	#pitch (0-127)
	addi $a1, $zero, 200	#duration in milliseconds
	addi $a2, $zero, 98	#instrument (0-127)#109 #110 = good beep
	addi $a3, $zero, 70	#volume (0-127)
	syscall 
		li $v0,33
	addi $a0, $zero, 96	#pitch (0-127)
	addi $a1, $zero, 100	#duration in milliseconds
	addi $a2, $zero, 98	#instrument (0-127)#109 #110 = good beep
	addi $a3, $zero, 70	#volume (0-127)
	syscall 
		li $v0,33
	addi $a0, $zero, 100	#pitch (0-127)
	addi $a1, $zero, 200	#duration in milliseconds
	addi $a2, $zero, 98	#instrument (0-127)#109 #110 = good beep
	addi $a3, $zero, 70	#volume (0-127)
	syscall 
		li $v0,33
	addi $a0, $zero, 103	#pitch (0-127)
	addi $a1, $zero, 400	#duration in milliseconds
	addi $a2, $zero, 98	#instrument (0-127)#109 #110 = good beep
	addi $a3, $zero, 70	#volume (0-127)
	syscall 
	jr $ra

gunshot:
	li $v0,31		# ************* changed this to 31 so the program can continue while the sound is going off **********************
	addi $a0, $zero, 50	#pitch (0-127) #60's good too
	addi $a1, $zero, 1000	#duration in milliseconds
	addi $a2, $zero, 127	#instrument (0-127)#109 #110 = good beep
	addi $a3, $zero, 90	#volume (0-127)
	syscall 
	jr $ra


correctsound:
	li $v0,33
	addi $a0, $zero, 100	#pitch (0-127)
	addi $a1, $zero, 1000	#duration in milliseconds
	addi $a2, $zero, 98	#instrument (0-127)#109 #110 = good beep
	addi $a3, $zero, 70	#volume (0-127)
	syscall 
	jr $ra


CheckLetters:
	move $t0, $a0				# Place Generated Letters into $t0
	move $t1, $a1				# Place UserInput into t1
	move $t2, $a2				# Place the StrLen of the userinput to t2
	move $t5, $s4				# Store GameLength to $t5
	li $t6, 0				# Initialize $t6 counter
	cLettersLoop:
		lb $t3, 0($a1)			# Load byte (UserInput)into $t2		// Going to be redundant 2nd, 3rd, 4th, etc times through
		lb $t4, 0($a0)			# Load byte (GeneratedLetters) into $t4
		beq $t3, $t4, ValidCharacter	# If UserInput byte is equal to byte in GeneratedLetters then jump to ValidCharacter
		addi $a0, $a0, 1		# Move to next byte in GeneratedLetters string	
		addi $t6, $t6, 1		# Counter to keep track of how many GeneratedLetters we've moved through so we can go back afterwards
		subi $t5, $t5, 1		# Subtract 1 from counter ($t5)
		beqz $t5, InvalidCharacter	# If the counter is at 0 then the character was not valid so jump to InvalidCharacter
		j	cLettersLoop		# Jump back to cLettersLoop
		ValidCharacter:	
			subi $a2, $a2, 1	# StrLen--
			beq $a2, $zero, Return	# If all characters of UserInput have been checked then jump to return
			addi $a1, $a1, 1	# Move to next letter in UserInput string
			sub $a0, $a0, $t6	# Go back to first letter in GeneratedLetters string
			add $t5, $t5, $t6	# Reset t5 to GameLength (equivalent to $s2) again
			add $t6, $zero, $zero		# Reset t6 to 0 so it will reset in case of an invalid character
			j cLettersLoop		# Jump to cLettersLoop
		InvalidCharacter: 
			add $t6, $zero, $zero
			#jal gunshot		# Tossed this in for fun to let them know the letters used were not valid*********************** // this needs to be edited to restore a2
			la $a0, InvalidWord	# Load the address of InvalidWord
			li $v0, 4		# Prepare to print the string in InvalidWord
			syscall			# Print the string in InvalidWord "The word you entered uses invalid characters."
			j InGameLoop		# Jump back to MainLoop and ask for a new word
			Return:
				move $a0, $t0	# Restore a0
				move $a1, $t1	# Restore a1
				move $a2, $t2	# Restore a2
				jr $ra		# Jump back right after the line "jal CheckLetters"


StrLenUser:			 #takes a string from $a1, returns the length in $a2
	move $t3, $a1 		#store $a1
	move $t1, $zero 	#initialize counter
	move $t0, $zero 	#just to be sure, reset $t0
	move $a2, $zero 	#be sure to store your $a2 beforehand if necessary
	StrLenLoop:
		lbu $t0, 0($a1) 		#String should be in $a1
		addi $a1, $a1, 1		#Move through String
		addi $t1, $t1, 1 		#len++
		bne $t0, $zero, StrLenLoop 	#until last element
		subi $t1, $t1, 2 		#len-- for null
		move $a2, $t1 			#return strlen in $a2
		move $a1, $t3 			#restore $a1
		jr $ra 				#back to caller with strlen in $a2


randomize:
	# preserve $a0, $a1, & $ra
	subiu $sp, $sp, 4 # make room for $ra
	sw $ra, ($sp) # save $ra to the top of the stack
	subiu $sp, $sp, 4 # make room for $a1
	sw $a1, ($sp) # save $ra to the top of the stack
	subiu $sp, $sp, 4 # make room for $a0
	sw $a0, ($sp) # save argument ($a0) to the top of the stack	
	
	# set $a0 to random seed based on system time
	li $v0, 30 # 30 is syscall system time
	syscall
	
	#g enerate a random number based on $a0
	li $v0, 42 # 42 is syscall random
	move $a1, $s4  # $a1 contains upper bound for random int, x < $a0
	syscall
	
	# move the random number in $a0 into $t2
	add $t2, $zero, $a0

	# restore $a0 so that it can be modified
	lw $a0, ($sp)	# restore $a0
	addiu $sp, $sp, 4 # remove space taken by $a0

	# swap two character bytes of $a0
	lb $t0, ($a0) # load the first char in $a0 into $t0
	add $a0, $a0, $t2 # add by random number $t2 to get random position
	lb $t1, ($a0) # load a char from a random postition in $a0 into $t1
	sub $a0, $a0, $t2 # return to first char by subtracting random position
	sb $t1, ($a0) # replace the first char of $a0 with the randomly selected char in $t1
	add $a0, $a0, $t2 # add by random number $t2 to get random position
	sb $t0, ($a0) # replace the randomly selected char with the first char of $a0 
	sub $a0, $a0, $t2 # return to first char by subtracting random position
	
	# restore $a1 to check the looping count
	lw $a1, ($sp)	# restore $a1
	addiu $sp, $sp, 4 # remove space taken by $a1
		
	# check if done looping
	subi $a1, $a1, 1 # decrement the counter
	beq  $a1, $zero, exit # exit if counter is zero
	j randomize
	
exit:	
	li $t0, 0
	li $t1, 0
	li $t2, 0
	# restore $ra and return to the caller
	lw $ra, ($sp) # restore $ra 
	addiu $sp, $sp, 4 # remove room taken by $ra
	jr $ra		# return to the caller

setS2:
	li $a1, 1244540
	addi $a3, $s4, -1	#counter in $a3 initialized to user input
	addi $a2, $zero, 1	#$t0=1
	addi $t2, $zero, 7	#$t2=7
	blt $s4, $t2, powerU	#if the user has entered a number less than 7, powerU #Changed from S1 to S4
	add $s2, $a1, $zero	#otherwise, stick with 1244540 or whatever is in $a1 
	jr $ra			#and return
powerU:
	addi $t1, $zero, 10	#$t1=10
	multu $a2, $t1
	mflo $a2		#$a2=10*$a2		
	subi $a3, $a3, 1	#counter--
	bge $a3, $zero, powerU	#once $a2=10^user input, cont
#cont: ***********commented this out because I didn't see a need for it***************
	div $a1, $a2	#effectively this whole code reads #s2=$a1mod10^userinput
	mfhi $s2	#s2 is now correct
	jr $ra
	
printSetS2:	
	la $a0, Reg4
	li $v0, 4
	syscall
	add $a0, $s4, $zero
	li $v0, 1
	syscall
	
	la $a0, Reg2
	li $v0, 4
	syscall
	add $a0, $s2, $zero
	li $v0, 1
	syscall
	
	jr $ra
	
GetRandomWord:
	# call the correct random word grabber
	beq $s4, 5, Get5Word
	beq $s4, 6, Get6Word
	beq $s4, 7, Get7Word

.include "RandomWordGrabber.asm"

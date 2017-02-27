.data
# Data for file IO
Words5File:	.asciiz "Data\\words5.dat"
Words6File:	.asciiz "Data\\words6.dat"
Words7File:	.asciiz "Data\\words7.dat"
RanWords5:	.space 7			# Read each line, 5 for the characters + 1 for Carriage Return + 1 more for NewLine
RanWords6:	.space 8			# Read each line, 6 for the characters + 1 for Carriage Return + 1 more for NewLine
RanWords7:	.space 9			# Read each line, 7 for the characters + 1 for Carriage Return + 1 more for NewLine
UserInput5:	.asciiz "     "			# Used to replace the the spaces with the new word, length of game (5)
UserInput6:	.asciiz "      "		# Used to replace the the spaces with the new word, lenght of game (6)
UserInput7:	.asciiz "       "		# Used to replace the the spaces with the new word, length of game (7)
#
PrintNewLine:	.asciiz "\n"			# Only used for testing here so we can print the random # and then print the word
.text

#### Get random word of size 5 ####
Get5Word:			
	la $s0, UserInput5
	li $a3, 0		# Reset a3 to 0 just in case
	
	li $a1, 8938		# Number of lines in file - 1, see 2 comments down to understand why - 1
	li $v0, 42
	syscall			# $a0 contains the random number
	addi $a0, $a0, 1	# add 1 to the number b/c 0 could be generated and thats not valid
	move $a3, $a0		# Put the random number in s7
	
	la $a0, Words5File
	li $a1, 0
	li $a2, 0
	li $v0, 13
	syscall			# Open the file located at Words7File
	move $s6, $v0		# Used to read the file and to close the file laterzero
	li $t2, 0		# Initialize counter
	
	GenWord5:
	move $a0, $s6
	la $a1, RanWords5
	li $a2, 7
	li $v0, 14		# Read the first word in the text file and store in Words7
	syscall
	addi $t1, $t1, 1	# Counter to know when we have reached the word
	beq $t1, $a3, GetWordFive	# If we have reached the word then go get it
	j GenWord5
	
	GetWordFive:		# This function just takes the word and puts it into UserInput7
	lb $t1, ($a1)
	sb $t1, ($s0)
	addi $a1, $a1, 1
	addi $s0, $s0, 1
	addi $t2, $t2, 1
	beq $t2, 5, Done5	 
	j GetWordFive
	
	Done5:
	subi $s0, $s0, 5
	li $v0, 16
	move $a0, $s6
	syscall			# Close the file
	li $a3, 0		# Reset a3 to 0 just in case
	jr $ra			# uncomment this when we toss into functions file
	
#### Get random word of size 6 ####
Get6Word:			
	la $s0, UserInput6
	li $a3, 0		# Reset a3 to 0 just in case
	
	li $a1, 15787		# Number of lines in file - 1, see 2 comments down to understand why - 1
	li $v0, 42
	syscall			# $a0 contains the random number
	addi $a0, $a0, 1	# add 1 to the number b/c 0 could be generated and thats not valid
	move $a3, $a0		# Put the random number in s7
	
	la $a0, Words6File
	li $a1, 0
	li $a2, 0
	li $v0, 13
	syscall			# Open the file located at Words7File
	move $s6, $v0		# Used to read the file and to close the file laterzero
	li $t2, 0		# Initialize counter
	
	GenWord6:
	move $a0, $s6
	la $a1, RanWords6
	li $a2, 8
	li $v0, 14		# Read the first word in the text file and store in Words7
	syscall
	addi $t1, $t1, 1	# Counter to know when we have reached the word
	beq $t1, $a3, GetWordSix	# If we have reached the word then go get it
	j GenWord6
	
	GetWordSix:		# This function just takes the word and puts it into UserInput7
	lb $t1, ($a1)
	sb $t1, ($s0)
	addi $a1, $a1, 1
	addi $s0, $s0, 1
	addi $t2, $t2, 1
	beq $t2, 6, Done6	 
	j GetWordSix
	
	Done6:
	subi $s0, $s0, 6
	li $v0, 16
	move $a0, $s6
	syscall			# Close the file
	li $a3, 0		# Reset a3 to 0 just in case
	jr $ra			# uncomment this when we toss into functions file

#### Get random word of size 7 ####
Get7Word:		
	la $s0, UserInput7
	li $a3, 0		# Reset a3 to 0 just in case
	
	li $a1, 24036		# Number of lines in file - 1, see 2 comments down to understand why - 1
	li $v0, 42
	syscall			# $a0 contains the random number
	addi $a0, $a0, 1	# add 1 to the number b/c 0 could be generated and thats not valid
	move $a3, $a0		# Put the random number in s7

	la $a0, Words7File
	li $a1, 0
	li $a2, 0
	li $v0, 13
	syscall			# Open the file located at Words7File
	move $s6, $v0		# Used to read the file and to close the file later
	li $t2, 0		# Initialize counter
	
	GenWord7:
	move $a0, $s6
	la $a1, RanWords7
	li $a2, 9
	li $v0, 14		# Read the first word in the text file and store in Words7
	syscall
	addi $t1, $t1, 1	# Counter to know when we have reached the word
	beq $t1, $a3, GetWordSeven	# If we have reached the word then go get it
	j GenWord7
	
	GetWordSeven:		# This function just takes the word and puts it into UserInput7
	lb $t1, ($a1)
	sb $t1, ($s0)
	addi $a1, $a1, 1
	addi $s0, $s0, 1
	addi $t2, $t2, 1
	beq $t2, 7, Done7	 
	j GetWordSeven
	
	Done7:
	subi $s0, $s0, 7
	li $v0, 16
	move $a0, $s6
	syscall			# Close the file
	li $a3, 0		# Reset a3 to 0 just in case
	jr $ra			# uncomment this when we toss into functions file

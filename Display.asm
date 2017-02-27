.data
Dashes:		.asciiz "\n--------------------------------------------------------------------------------------------------------------------------------" # 128 dashes across
MainFrame:	.asciiz "\n                                                        J U M B L I N E                                         " # this is 110 spaces, then we will call Score, then print s3 after that
Score:		.asciiz "Score: "
YourLetters:	.asciiz "\n---7--------------------6---------------5--------------4------------3-----------2--------------------Your Letters are: "
WordDashes7:	.asciiz "-------"
WordDashes6:	.asciiz "                      ------"
WordDashes5:	.asciiz "                                      -----"
WordDashes4:	.asciiz "                                                     ----"
WordDashes3:	.asciiz "                                                                   ---"
WordDashes2:	.asciiz "                                                                                --"
SpaceFor6:	.asciiz "                      "								# 7 spaces for 7 letter word + 15 more = 22 spaces
SpaceFor5:	.asciiz "                                      "						# 17 + 6 for word + 15 = 38 spaces
SpaceFor4:	.asciiz "                                                     "					# 33 + 5 for word + 15 = 53 spaces	The next column of words is always 7 spaces
SpaceFor3:	.asciiz "                                                                   "			# 48 + 4 for word + 15 = 67 spaces	away from the previous column
SpaceFor2:	.asciiz "                                                                                "	# 62 + 3 + 10 = 80 spaces
NewLine:	.asciiz "\n"
AlrdyGWords:	.asciiz "Data//alreadyguessed.dat"
FileWords:	.space 117		# Changed from 118 to 117 b/c the last 2 bytes after the last word in file are just 0 instead of d and a. The file is done, so only need 117 vs 118
#Remaining7:	.asciiz "There is "
#Remaining7More:	.asciiz " remaining 7-letter word(s)."
#Remaining6:	.asciiz "There is "
#Remaining6More:	.asciiz " remaining 6-letter word(s)."
#Remaining5:	.asciiz "There is "
#Remaining5More:	.asciiz " remaining 5-letter word(s)."
#Remaining4:	.asciiz "There is "
#Remaining4More:	.asciiz " remaining 4-letter word(s)."
#Remaining3:	.asciiz "There is "
#Remaining3More:	.asciiz " remaining 3-letter word(s)."
#Remaining2:	.asciiz "There is "
#Remaining2More:	.asciiz " remaining 2-letter word(s)."
Word7:		.space 9
Word6:		.space 8
Word5:		.space 7
Word4:		.space 6
Word3:		.space 5
Word2:		.space 4
EOF:		.asciiz "\nEnd Of File reached."		# This was just used for testing
ClearBuffer:	.byte '\0'
.text
DisplayMain:
	li $t0, 0
	li $t1, 0
	li $t2, 0
	li $t3, 0
	li $t4, 0
	li $t5, 0
	li $t6, 0
	li $t7, 0
	li $t8, 0
	li $t9, 0
	li $s5, 0
	li $s6, 0
	la $a3, Word7
	
	# Preserve $ra #
	subiu $sp, $sp, 4
	sw $ra, ($sp)
	
	# Printing top half of display (before any guessed words) #
	la $a0, Dashes
	li $v0, 4
	syscall
	
	la $a0, MainFrame
	li $v0, 4
	syscall
	
	la $a0, Score
	li $v0, 4					# all this is just printing the top border along with the score and the users letters
	syscall
	
	la $a0, ($s3)
	li $v0, 1
	syscall
	
	la $a0, YourLetters
	li $v0, 4
	syscall
	
	la $a0, ($s0)
	li $v0, 4
	syscall
	# Done printing top half of display #
	
	# Open File #
	la $a0, AlrdyGWords
	li $a1, 0
	li $a2, 0
	li $v0, 13
	syscall			# this is just opening the file that holds the users already guessed words
	move $s6, $v0
	# Open File Done #
	
	# Read all words # 
	move $a0, $s6
	la $a1, FileWords	# Since this file is not going to be over 117 bytes and all the words are of different length, I just read all the words in at 1 time
	li $a2, 117
	li $v0, 14
	syscall
	# Done reading file #
	
	# The entire staircase below is just checking the file for 7 letter words and then printing them as it comes across them.
	# Each staircase does the same as this one, they just do it for their respective sizes (6 letter words, 5 letters, etc)
	Get7LetterWord:			
	lb $t1, ($a1)				# Load first byte of the word
	addi $t2, $t2, 1			# Counter to keep track of the word length since all the words in the file are of different length
	addi $t8, $t8, 1			# Counter to keep track of how many bytes we've gone threw so we can go back to first byte in EOF1 function at bottom#####################
	addi $a1, $a1, 1			# Point a1 to next byte
	beq $t1, 10, CheckCount7		# if the byte is 10 (in decimal, which corresponds to New Line feed) then go to CheckCount7. NL feed is always 2 bytes after the last letter
	beq $t1, 0, CheckEOF7			# if the byte is 0 (null, meaning we have hit the end of the file) then go to CheckEOF7
	j Get7LetterWord		
		CheckCount7:
		beq $t2, 9, Restore7		# If t2 (the word length counter) = 9 then the word is 7 letters long, so go to Restore 7
		li $t2, 0			# It's not a 7 letter word so reset the counter and go to the next word				
		j Get7LetterWord
			Restore7:
			sub $a1, $a1, $t2	# We have verified that the word is 7 letters long, so point a1 back at the first byte of that word
				GetWord7:
				lb $t3, ($a1)				# Load the byte into t3
				sb $t3, ($a3)				# save the byte onto a3 (which points to .space 9)
				addi $a1, $a1, 1			# Point a1 to next byte
				addi $a3, $a3, 1			# Point a3 to next byte
				addi $t4, $t4, 1			# Counter to know when I have copied in the whole word
				beq $t4, 7, PrintWord7			# When the whole word is copied go to PrintWord7
				j GetWord7				# Whole word is not copied so keep looping (go to GetWord7)
					PrintWord7:
					sub $a3, $a3, $t4		# Point a3 back to first byte
					addi $a1, $a1, 2		# Restoring a1 to the first letter of next word, b/c now it points at hex d (which is Carriage Return) and that is always 1 character after the last letter of the word
					la $a0, NewLine			
					li $v0, 4
					syscall				# Printing a new line
					la $a0, ($a3)
					li $v0, 4
					syscall				# Printing the word
					li $t2, 0			# Reset Word length counter
					li $t4, 0			# Reset word counter
					addi $t6, $t6, 1		# Counter so we know how many 7 letter words have been printed, compared against s2, so we know if we need to print dashes
					beq $t1, 0, CheckDashes7	# if t1 = end of file then go to CheckDashes7	############was beg $t1, 0 EOF1
					j Get7LetterWord
						CheckEOF7:		# All this EOF has to be done because the last word in the file only has a 0 after it and not a carriage return and a newline feed
						beq $t2, 8, Restore7EOF	# if t2 = 8 then the word is 7 letters long (7 letters + EOF) and is the last word in the file so go to Restore7EOF
						li $t2, 0		# If the word is not 7 letters longer then reset t2
						j CheckDashes7			# and jump to CheckDashes7
							Restore7EOF:
							sub $a1, $a1, $t2	# Point a1 back to the first byte in the word
								GetWord7EOF:
								lb $t3, ($a1)	# Load the byte		
								sb $t3, ($a3)	# Save it to a3
								addi $a1, $a1, 1	# Point a1 to next byte
								addi $a3, $a3, 1	# Point a3 to next byte
								addi $t4, $t4, 1	# Counter to know when I have copied all the letters into a3
								beq $t4, 7, PrintWord7EOF	# If the counter = 7 (the word has been copied) then go to PrintWord7EOF
								j GetWord7EOF		# if the counter is not to 7 yet then keep looping (go to GetWord7EOF)
									PrintWord7EOF:
									sub $a3, $a3, $t4		# Point a3 back to first byte
									la $a0, NewLine			
									li $v0, 4
									syscall				# Printing a new line
									la $a0, ($a3)
									li $v0, 4
									syscall				# Printing the word
									li $t2, 0			# Reset Word length counter
									li $t4, 0			# Reset word counter
									addi $t6, $t6, 1		# Counter so we know how many 7 letter words have been printed, compared against s2, so we know if we need to print dashes
									addi $a1, $a1, 1 		# This needs to point ahead 1 byte to be consistent with t8 (its different here b/c its at the end of file)
									beq $t1, 0, CheckDashes7	# if t1 = end of file then go to CheckDashes7	############was beg $t1, 0 EOF1
									j Get7LetterWord
										CheckDashes7:	# Function that prints the dashes, could call Darren's functions, but I would have to use the stack for all the jumping and stuff
										# Save a1 (at the same byte it is now) onto stack
										subiu $sp, $sp, 4 	# Make room for $a1 restored in EOF1
										sw $a1, ($sp) 		# Store pointer
										jal getSeven0	# Returns number of 7 letter words in a0
										# Move a0 (which was just returned) into a1
										move $a1, $a0
										beq $a1, 0, EOF1
											PrintDashes7:
											addi $t7, $t7, 1	# Counter for loop so I will know when to stop printing lines of dashes
											la $a0, NewLine
											li $v0, 4
											syscall			# Print a newline
											la $a0, WordDashes7	#WordDashes7
											li $v0, 4
											syscall			# Print a line of dashes
											beq $a1, $t7, EOF1	# If I have printed the right amount of lines with dasheses then go to EOF1
											j PrintDashes7		# If I have not printed all the lines of dashes yet then jump back to loop and do it again
	Start6:
	la $a3, Word6				
	Get6LetterWord:			
	lb $t1, ($a1)
	addi $t2, $t2, 1
	addi $t8, $t8, 1
	addi $a1, $a1, 1
	beq $t1, 10, CheckCount6
	beq $t1, 0, CheckEOF6
	j Get6LetterWord
		CheckCount6:
		beq $t2, 8, Restore6
		li $t2, 0
		j Get6LetterWord
			Restore6:
			sub $a1, $a1, $t2
				GetWord6:
				lb $t3, ($a1)
				sb $t3, ($a3)
				addi $a1, $a1, 1
				addi $a3, $a3, 1
				addi $t4, $t4, 1
				beq $t4, 6, PrintWord6
				j GetWord6
					PrintWord6:
					sub $a3, $a3, $t4
					addi $a1, $a1, 2
					la $a0, NewLine
					li $v0, 4
					syscall
					la $a0, SpaceFor6
					li $v0, 4
					syscall
					la $a0, ($a3)
					li $v0, 4
					syscall
					li $t2, 0
					li $t4, 0
					addi $t6, $t6, 1
					beq $t1, 0, CheckDashes6
					j Get6LetterWord
						CheckEOF6:
						beq $t2, 7, Restore6EOF
						li $t2, 0
						j CheckDashes6
							Restore6EOF:
							sub $a1, $a1, $t2
								GetWord6EOF:
								lb $t3, ($a1)			
								sb $t3, ($a3)
								addi $a1, $a1, 1
								addi $a3, $a3, 1
								addi $t4, $t4, 1
								beq $t4, 6, PrintWord6EOF
								j GetWord6EOF
									PrintWord6EOF:
									sub $a3, $a3, $t4
									la $a0, NewLine
									li $v0, 4
									syscall
									la $a0, SpaceFor6
									li $v0, 4
									syscall
									la $a0, ($a3)
									li $v0, 4
									syscall
									li $t2, 0
									li $t4, 0
									addi $t6, $t6, 1
									addi $a1, $a1, 1 
									beq $t1, 0, CheckDashes6
									j Get6LetterWord
										CheckDashes6:
										# Save a1 (at the same byte it is now) onto stack
										subiu $sp, $sp, 4 	# Make room for $a1 restored in EOF1
										sw $a1, ($sp) 		# Store pointer
										jal getSix0	# Returns number of 7 letter words in a0
										# Move a0 (which was just returned) into a1
										move $a1, $a0
										beq $a1, 0, EOF1
											PrintDashes6:
											addi $t7, $t7, 1	# Counter for loop so I will know when to stop printing lines of dashes
											la $a0, NewLine
											li $v0, 4
											syscall			# Print a newline
											la $a0, WordDashes6	#WordDashes7
											li $v0, 4
											syscall			# Print a line of dashes
											beq $a1, $t7, EOF1	# If I have printed the right amount of lines with dasheses then go to EOF1
											j PrintDashes6
	Start5:
	la $a3, Word5				
	Get5LetterWord:			
	lb $t1, ($a1)
	addi $t2, $t2, 1
	addi $t8, $t8, 1
	addi $a1, $a1, 1
	beq $t1, 10, CheckCount5
	beq $t1, 0, CheckEOF5
	j Get5LetterWord
		CheckCount5:
		beq $t2, 7, Restore5
		li $t2, 0
		j Get5LetterWord
			Restore5:
			sub $a1, $a1, $t2
				GetWord5:
				lb $t3, ($a1)
				sb $t3, ($a3)
				addi $a1, $a1, 1
				addi $a3, $a3, 1
				addi $t4, $t4, 1
				beq $t4, 5, PrintWord5
				j GetWord5
					PrintWord5:
					sub $a3, $a3, $t4
					addi $a1, $a1, 2
					la $a0, NewLine
					li $v0, 4
					syscall
					la $a0, SpaceFor5
					li $v0, 4
					syscall
					la $a0, ($a3)
					li $v0, 4
					syscall
					li $t2, 0
					li $t4, 0
					addi $t6, $t6, 1
					beq $t1, 0, CheckDashes5
					j Get5LetterWord
						CheckEOF5:
						beq $t2, 6, Restore5EOF
						li $t2, 0
						j CheckDashes5
							Restore5EOF:
							sub $a1, $a1, $t2
								GetWord5EOF:
								lb $t3, ($a1)			
								sb $t3, ($a3)
								addi $a1, $a1, 1
								addi $a3, $a3, 1
								addi $t4, $t4, 1
								beq $t4, 5, PrintWord5EOF
								j GetWord5EOF
									PrintWord5EOF:
									sub $a3, $a3, $t4
									la $a0, NewLine
									li $v0, 4
									syscall
									la $a0, SpaceFor5
									li $v0, 4
									syscall
									la $a0, ($a3)
									li $v0, 4
									syscall
									li $t2, 0
									li $t4, 0
									addi $t6, $t6, 1
									addi $a1, $a1, 1 
									beq $t1, 0, CheckDashes5
									j Get5LetterWord
										CheckDashes5:
										# Save a1 (at the same byte it is now) onto stack
										subiu $sp, $sp, 4 	# Make room for $a1 restored in EOF1
										sw $a1, ($sp) 		# Store pointer
										jal getFive0	# Returns number of 7 letter words in a0
										# Move a0 (which was just returned) into a1
										move $a1, $a0
										beq $a1, 0, EOF1
											PrintDashes5:
											addi $t7, $t7, 1	# Counter for loop so I will know when to stop printing lines of dashes
											la $a0, NewLine
											li $v0, 4
											syscall			# Print a newline
											la $a0, WordDashes5	#WordDashes7
											li $v0, 4
											syscall			# Print a line of dashes
											beq $a1, $t7, EOF1	# If I have printed the right amount of lines with dasheses then go to EOF1
											j PrintDashes5
	Start4:
	la $a3, Word4				
	Get4LetterWord:			
	lb $t1, ($a1)
	addi $t2, $t2, 1
	addi $t8, $t8, 1
	addi $a1, $a1, 1
	beq $t1, 10, CheckCount4
	beq $t1, 0, CheckEOF4
	j Get4LetterWord
		CheckCount4:
		beq $t2, 6, Restore4
		li $t2, 0
		j Get4LetterWord
			Restore4:
			sub $a1, $a1, $t2
				GetWord4:
				lb $t3, ($a1)
				sb $t3, ($a3)
				addi $a1, $a1, 1
				addi $a3, $a3, 1
				addi $t4, $t4, 1
				beq $t4, 4, PrintWord4
				j GetWord4
					PrintWord4:
					sub $a3, $a3, $t4
					addi $a1, $a1, 2
					la $a0, NewLine
					li $v0, 4
					syscall
					la $a0, SpaceFor4
					li $v0, 4
					syscall
					la $a0, ($a3)
					li $v0, 4
					syscall
					li $t2, 0
					li $t4, 0
					addi $t6, $t6, 1
					beq $t1, 0, CheckDashes4
					j Get4LetterWord
						CheckEOF4:
						beq $t2, 5, Restore4EOF
						li $t2, 0
						j CheckDashes4
							Restore4EOF:
							sub $a1, $a1, $t2
								GetWord4EOF:
								lb $t3, ($a1)			
								sb $t3, ($a3)
								addi $a1, $a1, 1
								addi $a3, $a3, 1
								addi $t4, $t4, 1
								beq $t4, 4, PrintWord4EOF
								j GetWord4EOF
									PrintWord4EOF:
									sub $a3, $a3, $t4
									la $a0, NewLine
									li $v0, 4
									syscall
									la $a0, SpaceFor4
									li $v0, 4
									syscall
									la $a0, ($a3)
									li $v0, 4
									syscall
									li $t2, 0
									li $t4, 0
									addi $t6, $t6, 1
									addi $a1, $a1, 1
									beq $t1, 0, CheckDashes4
									j Get4LetterWord
										CheckDashes4:
										# Save a1 (at the same byte it is now) onto stack
										subiu $sp, $sp, 4 	# Make room for $a1 restored in EOF1
										sw $a1, ($sp) 		# Store pointer
										jal getFour0	# Returns number of 7 letter words in a0
										# Move a0 (which was just returned) into a1
										move $a1, $a0
										beq $a1, 0, EOF1
											PrintDashes4:
											addi $t7, $t7, 1	# Counter for loop so I will know when to stop printing lines of dashes
											la $a0, NewLine
											li $v0, 4
											syscall			# Print a newline
											la $a0, WordDashes4	#WordDashes7
											li $v0, 4
											syscall			# Print a line of dashes
											beq $a1, $t7, EOF1	# If I have printed the right amount of lines with dasheses then go to EOF1
											j PrintDashes4
	Start3:
	la $a3, Word3				
	Get3LetterWord:			
	lb $t1, ($a1)
	addi $t2, $t2, 1
	addi $t8, $t8, 1
	addi $a1, $a1, 1
	beq $t1, 10, CheckCount3
	beq $t1, 0, CheckEOF3
	j Get3LetterWord
		CheckCount3:
		beq $t2, 5, Restore3
		li $t2, 0
		j Get3LetterWord
			Restore3:
			sub $a1, $a1, $t2
				GetWord3:
				lb $t3, ($a1)
				sb $t3, ($a3)
				addi $a1, $a1, 1
				addi $a3, $a3, 1
				addi $t4, $t4, 1
				beq $t4, 3, PrintWord3
				j GetWord3
					PrintWord3:
					sub $a3, $a3, $t4
					addi $a1, $a1, 2
					la $a0, NewLine
					li $v0, 4
					syscall
					la $a0, SpaceFor3
					li $v0, 4
					syscall
					la $a0, ($a3)
					li $v0, 4
					syscall
					li $t2, 0
					li $t4, 0
					addi $t6, $t6, 1
					beq $t1, 0, CheckDashes3
					j Get3LetterWord
						CheckEOF3:
						beq $t2, 4, Restore3EOF
						li $t2, 0
						j CheckDashes3
							Restore3EOF:
							sub $a1, $a1, $t2
								GetWord3EOF:
								lb $t3, ($a1)			
								sb $t3, ($a3)
								addi $a1, $a1, 1
								addi $a3, $a3, 1
								addi $t4, $t4, 1
								beq $t4, 3, PrintWord3EOF
								j GetWord3EOF
									PrintWord3EOF:
									sub $a3, $a3, $t4
									la $a0, NewLine
									li $v0, 4
									syscall
									la $a0, SpaceFor3
									li $v0, 4
									syscall
									la $a0, ($a3)
									li $v0, 4
									syscall
									li $t2, 0
									li $t4, 0
									addi $t6, $t6, 1
									addi $a1, $a1, 1 
									beq $t1, 0, CheckDashes3
									j Get3LetterWord
										CheckDashes3:
										# Save a1 (at the same byte it is now) onto stack
										subiu $sp, $sp, 4 	# Make room for $a1 restored in EOF1
										sw $a1, ($sp) 		# Store pointer
										jal getThree0	# Returns number of 7 letter words in a0
										# Move a0 (which was just returned) into a1
										move $a1, $a0
										beq $a1, 0, EOF1
											PrintDashes3:
											addi $t7, $t7, 1	# Counter for loop so I will know when to stop printing lines of dashes
											la $a0, NewLine
											li $v0, 4
											syscall			# Print a newline
											la $a0, WordDashes3	#WordDashes7
											li $v0, 4
											syscall			# Print a line of dashes
											beq $a1, $t7, EOF1	# If I have printed the right amount of lines with dasheses then go to EOF1
											j PrintDashes3
	Start2:
	la $a3, Word2				
	Get2LetterWord:			
	lb $t1, ($a1)
	addi $t2, $t2, 1
	addi $t8, $t8, 1
	addi $a1, $a1, 1
	beq $t1, 10, CheckCount2
	beq $t1, 0, CheckEOF2
	j Get2LetterWord			
		CheckCount2:			
		beq $t2, 4, Restore2
		li $t2, 0
		j Get2LetterWord
			Restore2:
			sub $a1, $a1, $t2
				GetWord2:
				lb $t3, ($a1)
				sb $t3, ($a3)
				addi $a1, $a1, 1
				addi $a3, $a3, 1
				addi $t4, $t4, 1
				beq $t4, 2, PrintWord2
				j GetWord2
					PrintWord2:
					sub $a3, $a3, $t4
					addi $a1, $a1, 2
					la $a0, NewLine
					li $v0, 4
					syscall
					la $a0, SpaceFor2
					li $v0, 4
					syscall
					la $a0, ($a3)
					li $v0, 4
					syscall
					li $t2, 0
					li $t4, 0
					addi $t6, $t6, 1
					beq $t1, 0, CheckDashes2
					j Get2LetterWord
						CheckEOF2:
						beq $t2, 3, Restore2EOF
						li $t2, 0
						j CheckDashes2
							Restore2EOF:
							sub $a1, $a1, $t2
								GetWord2EOF:
								lb $t3, ($a1)			
								sb $t3, ($a3)
								addi $a1, $a1, 1
								addi $a3, $a3, 1
								addi $t4, $t4, 1
								beq $t4, 2, PrintWord2EOF
								j GetWord2EOF
									PrintWord2EOF:
									sub $a3, $a3, $t4
									la $a0, NewLine
									li $v0, 4
									syscall
									la $a0, SpaceFor2
									li $v0, 4
									syscall
									la $a0, ($a3)
									li $v0, 4
									syscall
									li $t2, 0
									li $t4, 0
									addi $t6, $t6, 1
									addi $a1, $a1, 1 
									beq $t1, 0, CheckDashes2
									j Get2LetterWord
										CheckDashes2:
										# Save a1 (at the same byte it is now) onto stack
										subiu $sp, $sp, 4 	# Make room for $a1 restored in EOF1
										sw $a1, ($sp) 		# Store pointer
										jal getTwo0	# Returns number of 7 letter words in a0
										# Move a0 (which was just returned) into a1
										move $a1, $a0
										beq $a1, 0, EOF1
											PrintDashes2:
											addi $t7, $t7, 1	# Counter for loop so I will know when to stop printing lines of dashes
											la $a0, NewLine
											li $v0, 4
											syscall			# Print a newline
											la $a0, WordDashes2	#WordDashes7
											li $v0, 4
											syscall			# Print a line of dashes
											beq $a1, $t7, EOF1	# If I have printed the right amount of lines with dasheses then go to EOF1
											j PrintDashes2
		EOF1:
		li $t6, 0		# Restore t6 to 0
		li $t7, 0
		# Restore a1 from stack
		lw $a1 ($sp)		# Restore value of $a1 pointer
		addiu $sp, $sp, 4	# Remove space taken by $a1
		sub $a1, $a1, $t8	# This restores a1 back to the very first byte in the file (b/c every function above searches all the way to the end of the file) ########## was 117 instead of t8
		li $t8, 0		# Reset t8 to 0
		addi $t5, $t5, 1	# counter so we can jump to the next function above
		beq $t5, 1, Start6	# if t5 = 1 go to Start6
		beq $t5, 2, Start5	# if t5 = 2 go to Start5
		beq $t5, 3, Start4	# etc...
		beq $t5, 4, Start3
		beq $t5, 5, Start2
		la $a0, NewLine
		li $v0, 4
		syscall			# Prints newline
		la $a0, Dashes
		li $v0, 4
		syscall			# This is to print the bottom dashes
	# Clear the buffer 
	subiu $sp, $sp, 4		# Make room for $t0
	sw $t0, ($sp)			# Store $t0
	li $t8, 0			# Initialize counter
	#
	
	ClearFileWords:
	lb $t0, ClearBuffer		# Load \n into $t0 to clear buffer
	sb $t0, ($a1)
	addi $t8, $t8, 1
	addi $a1, $a1, 1
	bne $t8, 117, ClearFileWords	# Clear all 117 bytes
	
	# Reset pointer & counters
	sub $a1, $a1, $t8		# Restore $a1
	lw $t0, ($sp)			# Restore $t0
	addiu $sp, $sp, 4		# Restore $sp
	li $t8, 0
	
	# Close the file 
	move $a0, $s6
	li $v0, 16
	syscall
	
	# Restore $ra from stack
	lw $ra ($sp)		# Restore value of $ra 
	addiu $sp, $sp, 4	# Remove space taken by $ra
	jr $ra			# Return to caller
	
	########################## ADDED JUST FOR TESTING ############################
	getSeven0: 
	# put the number of size 7 words left to guess in $a0
	li $t0, 1000000
	div $s2, $t0 # quotient is number of size 7 words and stored in LO
	mflo $a0 # move number of size 7 words into $a0
	jr $ra # $ra preserved since no calls made
	
	getSix0: 
	# preserve $ra 
	subiu $sp, $sp, 4 # make room for $ra
	sw $ra, ($sp) # save $ra to the top of the stack
#
	# ignore size 7 words
	jal getSeven0
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
getFive0: 	
	# preserve $ra 
	subiu $sp, $sp, 4 # make room for $ra
	sw $ra, ($sp) # save $ra to the top of the stack
#
	# ignore size 7 words
	jal getSeven0
	li $t0, 1000000 
	mult $a0, $t0 
	mflo $t0 # move the lower 32 bits of multiplication into $t0
	sub $a1, $s2, $t0 # remove size 7 words from $s2 and store in $a1
	# ignore size 6 words
	jal getSix0
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
getFour0: 
	# preserve $ra 
	subiu $sp, $sp, 4 # make room for $ra
	sw $ra, ($sp) # save $ra to the top of the stack
#
	# ignore size 7 words
	jal getSeven0
	li $t0, 1000000 
	mult $a0, $t0 
	mflo $t0 # move the lower 32 bits of multiplication into $t0
	sub $a1, $s2, $t0 # remove size 7 words from $s2 and store in $a1
	# ignore size 6 words
	jal getSix0
	li $t0, 100000 
	mult $a0, $t0 
	mflo $t0 # move the lower 32 bits of multiplication into $t0
	sub $a1, $a1, $t0 # remove size 6 words from $a1 and store in $a1
	# ignore size 5 words
	jal getFive0
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
getThree0: 
	# preserve $ra 
	subiu $sp, $sp, 4 # make room for $ra
	sw $ra, ($sp) # save $ra to the top of the stack
#
	# ignore size 7 words
	jal getSeven0
	li $t0, 1000000 
	mult $a0, $t0 
	mflo $t0 # move the lower 32 bits of multiplication into $t0
	sub $a1, $s2, $t0 # remove size 7 words from $s2 and store in $a1
	# ignore size 6 words
	jal getSix0
	li $t0, 100000 
	mult $a0, $t0 
	mflo $t0 # move the lower 32 bits of multiplication into $t0
	sub $a1, $a1, $t0 # remove size 6 words from $a1 and store in $a1
	# ignore size 5 words
	jal getFive0
	li $t0, 10000 
	mult $a0, $t0 
	mflo $t0 # move the lower 32 bits of multiplication into $t0
	sub $a1, $a1, $t0 # remove size 5 words from $a1 and store in $a1
	# ignore size 4 words
	jal getFour0
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
getTwo0: 
	# preserve $ra 
	subiu $sp, $sp, 4 # make room for $ra
	sw $ra, ($sp) # save $ra to the top of the stack
#
	# ignore size 7 words
	jal getSeven0
	li $t0, 1000000 
	mult $a0, $t0 
	mflo $t0 # move the lower 32 bits of multiplication into $t0
	sub $a1, $s2, $t0 # remove size 7 words from $s2 and store in $a1
	# ignore size 6 words
	jal getSix0
	li $t0, 100000 
	mult $a0, $t0 
	mflo $t0 # move the lower 32 bits of multiplication into $t0
	sub $a1, $a1, $t0 # remove size 6 words from $a1 and store in $a1
	# ignore size 5 words
	jal getFive0
	li $t0, 10000 
	mult $a0, $t0 
	mflo $t0 # move the lower 32 bits of multiplication into $t0
	sub $a1, $a1, $t0 # remove size 5 words from $a1 and store in $a1
	# ignore size 4 words
	jal getFour0
	li $t0, 1000 
	mult $a0, $t0 
	mflo $t0 # move the lower 32 bits of multiplication into $t0
	sub $a1, $a1, $t0 # remove size 4 words from $a1 and store in $a1
	# ignore size 3 words
	jal getThree0
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

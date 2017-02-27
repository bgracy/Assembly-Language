# All the sound bits need to be edited so that they restore $a2, should be a very quick fix
.data
	AskNumChars:		.asciiz "\n                              How many characters would you like to play with (5, 6, or 7)? "
	InvalidNumChars:	.asciiz "\n                                             You entered an invalid number."	# Will be used to make sure they only enter 5, 6, or 7 for the number of characters they want to play
	WordTooLong:		.asciiz "\n                                           The word you entered was too long."
	cPrompt1:		.asciiz "\n                                                  Your letters are: "
	cPrompt2:		.asciiz	"\n                              Enter a word (0 will quit, 1 will scramble your letters): "
	cPrompt3:		.asciiz	"                                                                                                  Preparing this game's round... "
	PEBCAK:			.asciiz "\n                                     Sorry, you can't guess a word of that size."
	RepeatGuess:		.asciiz "\n                                            You already guessed that word!."
	GuessedWords:		.asciiz "Data\\alreadyguessed.dat"
	YouWin:			.asciiz "\n                                        Congratulations, you have won the game!"
	PlayAgain:		.asciiz "\n                                   You can press 0 to quit or 1 to start a new game." #### Will be implmented later or 2 to continue and start a new round.
	PlayAgainCont:		.asciiz "\nIf you press choose to start a new round you will play with the same number of characters and your score will be carried over."
	PlayAgainCont2:		.asciiz "\nWhat would you like to do? "
	Exit:			.asciiz "\nExiting..."
	SpacingForEntry:	.asciiz "                                                                "
	InvalidNumEntry:	.asciiz "\nThat is an invalid number. Please enter 5, 6, or 7: "
	Press1ToPly0ToQuit:	.asciiz "\nPlease press 1 to play or 0 to quit: "
	WelcomeMessage:		.asciiz "                                                      Welcome to Jumbline!\nThis is a simple game in which we will provide you with a random string of characters, and you will try to make words out of them!"
	
	
	nullterminator0:	.byte '\n'
	carragereturn0:		.byte '\r'
	
	# The two lines below this are only used for testing
	Test:			.asciiz "You Entered: "
	UserLength:		.asciiz "The length of the word you entered is: "
	PrintS3:		.asciiz "\nYour score is: "
	
	Zero:			.ascii	"0"
	One:			.ascii 	"1"
	UserInput:		.space 9		# increase this to 10 so that if on the 7th char they accidentally hit 2 letters it wont go on and tell them word was too long???
							# Would also need to change this number down below where we cin the userinput "la $a1, 9"
.text
main:
MainLoop:
######### title   #########
	j titlescreen
	AfterTitle:
	jal Jumbline_Motif
	la $a0, SpacingForEntry
	li $v0, 4
	syscall
	AfterEntry:
	li $v0, 5
	syscall
	bne $v0, 1, Afterentryplay
	la $a0, WelcomeMessage
	li $v0, 4
	syscall
	j aPrompt
	Afterentryplay:
	beq $v0, 0, Exiting
	la $a0, Press1ToPly0ToQuit
	li $v0, 4
	syscall
	j AfterEntry
	
######### aPrompt #########
	aPrompt:
	li $s4, 0
	la $a0, AskNumChars
	li $v0, 4
	syscall
	
	li $v0, 5		
	syscall
	bge $v0, 8, aPrompt	# Was AfterTitle
	ble $v0, 4, aPrompt	#we think this might be a case of PEBCAK
	li $s2, 0	############# Added so that s2 resets after a round
	#li $s3, 0	############# Added so that s3 resets after a round
	
######### Setting s2 #########	
	move $s4, $v0
	jal setS2
	#jal printSetS2		# This is just used to test setS2, will also be used later to test that S2 is being updated correctly and to show the user what is left
######### Reinitialize GuessWords File #########	
 	la   $a0, GuessedWords  
  	li   $a1, 1		# Open for writing to clear file (flags are 0: read, 1: write, 9: write and append)
  	li   $a2, 0
  	li   $v0, 13 
 	syscall            
 	move $s6, $v0		# Save file descriptor
 	
 	# Close file
 	move $a0, $s6		# Load file descriptor into $a0
	li $v0, 16
	syscall
######### Get random word & scramble letters #########
	la $a0, cPrompt3	# Start loading game.
	li $v0, 4
	syscall			# Print cPrompt3 "Preparing this game round... "
	jal GetRandomWord	# Get random Word
	la $a0, ($s0)		# Put random word into $a0
	li $a1, 30		# Randomize 30 times
	jal randomize
	move $s0, $a0		# Put scrambled, generated letters in $s0
######### Generate Valid Word List #########
	j ValidWordList
	AfterValidWordList:
	#subiu $sp, $sp, 4	# Make room for ValidWords.txt filesize
	#sw $a0 ($sp)		# Filesize in $a0 after function call	
InGameLoop:
	jal DisplayMain	
	la $t8, Zero
	la $t9, One
######### cPrompt through Check Letters #########
	#la $a0, cPrompt1
	#li $v0, 4
	#syscall			# Print cPrompt1 "Your letters are: "
	#move $a0, $s0
	#li $v0, 4
	#syscall			# Print scrambled letters
	
	la $a0, cPrompt2
	li $v0, 4
	syscall			# Print cPrompt2 "Enter a word (0 will quit, 1 will scramble your letters): "
	
	la $a0, UserInput	# Putting the userinput into $a0
	la $a1, 9		
	li $v0, 8		
	syscall			
	move $s1, $a0		
	
	lb $a0, ($a0)		
	lb $t8, ($t8)	
	lb $t9, ($t9)	
	beq $a0, $t8, Exiting	# If the UserInput is equal to ascii 0, then exit
	beq $a0, $t9, RandomizeAnytime
	
	#la $a0, Test		
	#li $v0, 4		
	#syscall			# Print string in Test "You Entered: "
	#la $a0, ($s1)		
	#li $v0, 4		
	#syscall			# Print the string in UserInput // This block is only being used for testing, will not be in final project
	
	move $a1, $s1		# Put the UserInput ($s1) into ($a1) for the StrLen function
	jal StrLenUser
	
	#la $a0, UserLength
	#li $v0, 4
	#syscall			# Print UserLength "The length of the word you entered is: "
	#la $a0, ($a2)		
	#li $v0, 1		
	#syscall			# Print the integer in $a0 // This block is only being used for testing, will not be in final project
	
######### Check if User Input is of Valid Size #########
	bge $a2, 8, InvalidSize	# Can't guess a word bigger than seven
	ble $a2, 1, InvalidSize # Can't guess a word smaller than two
	jal CheckS2		# Put the number of user input sized words left to guess in $a0
	beq $a0, 0, InvalidSize	# No more user input sized words left to guess
######### Check User Input's Letters & Check against Word Bank #########
	move $a0, $s0		# Load the GeneratedLetters into $a0
	move $a1, $s1		# Load the UserInput into $a1
	jal CheckLetters	
	j CheckWordBank		#INSERT CONTROL FLOW TO FUNCTION
				#J CHECKALREADYCGUESSEDLIST
	AfterCheckWordBank:
######### Check User Input against Already Guessed Words #########
	j CheckAlreadyGuessed
	AfterCheckAlreadyGuessed:
	
######### User Input is valid, Update $s2 & play Sound #########
	move $a1, $s1		# Put the UserInput ($s1) into ($a1) for the StrLen function
	jal StrLenUser		# Put StringLength into $a2
	jal UpdateS2		# Update Score and Remaining words to guess
	jal correctsound	# The letters were valid so play a sound, tossed this in for fun and for testing // will not be here in final project // This needs to be edited to restore a2
######### Append User Input to GuessedWords #########	
 	la   $a0, GuessedWords  # Address of alreadyguessed.dat
  	li   $a1, 9       	# Open for writing (flags are 0: read, 1: write, 9: write and append)
  	li   $a2, 0
  	li   $v0, 13 
 	syscall            
 	move $s6, $v0      
 	
 	# Append file
	move $a1, $s1		# Put the UserInput ($s1) into ($a1) for the StrLen function
	jal StrLenUser		# Put StringLength into $a2
	la   $a1, ($s1)		# move user input into $a1
	add $a1, $a2, $a1	# move StringLength up (one byte after word ends)
	addi $a1, $a1, 1	# move one more byte up
	lb $t0, nullterminator0	# load \n into $t0
	sb $t0, ($a1)		# store \n into $a1 
	subi $a1, $a1, 1	# move down one to store \r
	lb $t0, carragereturn0	# load \r into $t0
	sb $t0, ($a1)		# store \r into $a1
	sub $a1, $a1, $a2	# move pointer String Length back to starting position
	li $v0, 15		# system call for write to file
	add $a2, $a2, 2		# string length in $a2 is buffersize, add two for terminators
	move $a0, $s6		# file descriptor 
	syscall			# write to file
 	
 	# Close file
 	move $a0, $s6
	li $v0, 16
	syscall
	
######### Print Score #########
	#la $a0, PrintS3		
	#li $v0, 4
	#syscall
	#la $a0, ($s3)
	#li $v0, 1
	#syscall
	#jal printSetS2		# This is just used to make sure that S2 is getting updated correctly
		#*********** NEED TO ADD IN THE GETSEVEN, GETSIX  ETC TO CHECK AND MAKE SURE THAT THE NUMBER ISN'T ALREADY 0 AND IF IT IS LET THEM KNOW AND JUMP BACK TO LOOP************
	#jal DisplayMain
	beq $s2, 0, YouWon
	j InGameLoop
	# Can't really use stringcompare or wordsleft yet.  stringcompare.asm, WordsLeft.asm
	
YouWon:
	#User has won the game, $s2 = 0
	jal DisplayMain
	la $a0, YouWin
	li $v0, 4
	syscall
	la $a0, PlayAgain
	li $v0, 4
	syscall
	addi $s3, $s3, 25
	#la $a0, PlayagainCont
	#li $v0, 4
	#syscall
	la $a0, PlayAgainCont2
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	beq $v0, 0, Exiting
	beq $v0, 1, aPrompt
	#beq $v0, 2, 		# Will be implemented later
InvalidSize:	
	#User Input is of invalid size
	la $a0, PEBCAK
	li $v0, 4
	syscall			# Print PEBCAK "\nSorry, you can't guess a word of that size."
	j InGameLoop
UserAlreadyGuessed:	
	#User Input was already guessed
	la $a0, RepeatGuess
	li $v0, 4
	syscall			# Print RepeatGuess "\nYou already guessed that word!"
	jal gunshot
	j InGameLoop
RandomizeAnytime:
	la $a0, ($s0)		# Put random word into $a0
	li $a1, 30		# Randomize 30 times
	jal randomize
	move $s0, $a0		# Put scrambled, generated letters in $s0
	j InGameLoop
Exiting:
	la $a0, Exit		# Load the address of Exit
	li $v0, 4		# Prepare to print the string in Exit
	syscall			# Print the string in Exit "Exiting..."
	li $v0, 10		# Prepare to exit the program
	syscall			# Exit the program
	
.include "Jumbline_Functions.asm"
.include "ValidWordList.asm"
.include "titlescreen.asm"
.include "CheckWordBank.asm"
.include "CheckAlreadyGuessed.asm"
.include "Display.asm"

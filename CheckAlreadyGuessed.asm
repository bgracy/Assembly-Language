.data
nullbyte0:	.byte '\0'
newlinebyte0:	.byte '\n'
newlinestring0:	.asciiz "\n"
returnbyte0:	.byte '\r'
Words0:		.asciiz "Data\\alreadyguessed.dat"
Wordbuf0:	.space 10000
testbank0:	.asciiz "swoon\r\n"
a1contains0:	.asciiz "a1 contains: "
dictionarycontains0:	.asciiz	"the dictionary contains: "
yougotit:	.asciiz "                                               Way to go!! We found your word!!"
#initialize registers to avoid error
.text
CheckAlreadyGuessed:
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
	li $a0, 0
	li $a1, 0
	li $s5, 0
	li $a2, 0
	
	#la $s1, testbank#
	add $a1, $s1, $zero
	
	#la $a0, a1contains#
	#li $v0, 4#
	#syscall#
	#add $a0, $a1, $zero#
	#syscall#

	jal StrLen0
	add $s5, $a2, $zero

##################################################################################FILEIO
FileIO0:
li   $v0, 13       # open the file called (see next line)
la   $a0, Words0
li   $a1, 0        # Flags
li   $a2, 0       # Mode
syscall
move $s6, $v0      # so the file can be closed later

loopRead0:
	li   $v0, 14       # read from file
	move $a0, $s6      # called $s6
	la   $a1, Wordbuf0   # of some length, doesnt appear to matter much
	li  $a2, 10000   # we are reading so many words...
	syscall            # read from file
	jal ProcessWords0 #prep for display

li   $v0, 16       # close the file from
move $a0, $s6      # $s6
syscall

ProcessWords0:
	add $s7, $zero, $zero #overall counter must be saved since were digging into functions
	addi $t1, $zero, -1 #byte counter
	lb $t8, newlinebyte0
bytecollector0:
	add $t0, $a1, $s7
	lb $t9, ($t0) #reading $a1 byte by byte into $t9
	beq $t9, $t8, bytecontinue0
	bytecontinue0:
	addi $s7, $s7, 1
	addi $t1, $t1, 1
	beq $t9, $t8, wordcollector0
	blt $s7, 40000, bytecollector0
	j notfound0
wordcollector0:
	j wordComp0 #compare these letters to user letters
	wordcollectordone0:
	addi $t1, $zero, -1 #byte counter, ignoring newline
	j bytecollector0
wordComp0:
	add $a0, $s5, $zero	#user word len in $s5
	bne $s5, $t1, wordcollectordone0 #if dictionary word is a different number of letters than user input, no need to compare
	sub $t0, $t0, $t1 #subtract the byte counter to get to start of word
	
	add $t5, $s1, $zero #counter for userword letter
	add $t6, $t0, $zero #counter for dictionary letter
	addi $t7, $zero, -1
		
		#li $v0, 4#
		#la $a0, newlinestring#
		#syscall#
		#move $a0, $t1
		#li $v0, 1
		#syscall
		
		lb $t2, newlinebyte0
	wordCompLoop0:
		lb $t3, ($t5)	#user letter in t3
		lb $t4, ($t6)	#dictionary letter in t4

		#li $v0, 11#		
		#add $a0, $t3, $zero#
		#syscall#
		#li $v0, 11#		
		#add $a0, $t4, $zero#
		#syscall#
		
		addi $t5, $t5, 1 #increment user letter letter address
		addi $t6, $t6, 1 #increment dictionary letter address
		addi $t7, $t7, 1 #count how many letters
		beq $t3, $t2, found0
		bne $t3, $t4, wordcollectordone0 #if user letter different than dictionary letter
		blt $t7, $s5, wordCompLoop0 #until all letters used up; t1 holds length

found0:
	# Close file
	li   $v0, 16       # close the file from
	move $a0, $s6      # $s6
	syscall
	
	# Clear the buffer 
	#li $t1, 0			# Initialize counter
	#la $a1, Wordbuf0
	#
	#ClearFileWords0:
	#lb $t0, nullbyte0		# Load \n into $t0 to clear buffer
	#sb $t0, ($a1)
	#addi $t1, $t1, 1
	#addi $a1, $a1, 1
	#bne $t1, 10000, ClearFileWords0	# Clear all 117 bytes
	
	# Reset pointer & counters
	#sub $a1, $a1, $t1
	#li $t0, 0
	#li $t1, 0
	
	j UserAlreadyGuessed
	li $v0, 10
	syscall
notfound0:
	# Close file
	li   $v0, 16       # close the file from
	move $a0, $s6      # $s6
	syscall
	la $a0, yougotit
	li $v0, 4
	syscall
	# Clear the buffer 
	#li $t1, 0			# Initialize counter
	#la $a1, Wordbuf0
	#
	#ClearFileWords1:
	#lb $t0, nullbyte0		# Load \n into $t0 to clear buffer
	#sb $t0, ($a1)
	#addi $t1, $t1, 1
	#addi $a1, $a1, 1
	#bne $t1, 10000, ClearFileWords1	# Clear all 117 bytes
	
	# Reset pointer & counters
	#sub $a1, $a1, $t1
	#li $t0, 0
	#li $t1, 0
	
	
	j AfterCheckAlreadyGuessed
	li $v0, 10
	syscall
####################################################################StrLen	
StrLen0: #takes a string from $a1, returns the length in $a2
	move $t3, $a1			#store $a1
	move $t1, $zero			#initialize counter
	move $t0, $zero			#just to be sure, reset $t0
	move $a2, $zero			#be sure to store your $a2 beforehand if necessary 
StrLenLoopBank0:
	lbu $t0, 0($a1) 		#String should be in $a1	
	addi $a1, $a1, 1 		#Move through String
	addi $t1, $t1, 1 		#len++
	bne $t0, $zero, StrLenLoopBank0	#until last element
	subi $t1, $t1, 1 		#len-- for '0'
	move $a2, $t1			#return strlen in $a2
	move $a1, $t3			#restore $a1
	jr $ra				#back to caller with strlen in $a2

.data
words2: .asciiz "Data\\words2.dat"
words3: .asciiz "Data\\words3.dat"
words4: .asciiz "Data\\words4.dat"
words5: .asciiz "Data\\words5.dat"      # filenames for input
words6: .asciiz "Data\\words6.dat"
words7: .asciiz "Data\\words7.dat"
buffer7:	.space 9
buffer6:	.space 8
buffer5:	.space 7
buffer4:	.space 6
buffer3:	.space 5
buffer2:	.space 4

teststr:	.asciiz "apricot"	# If the length of the letters gets changed then you need to change s4 down below in "Hard-Coded Stuff" to match the length
newline:	.asciiz "\n"

fout:   .asciiz "Data\\validoutput.dat"

.text
ValidWordList:
######### Open Output File #############     
 	la   $a0, fout     
  	li   $a1, 1        # Open for writing (flags are 0: read, 1: write, 9: write and append)
  	li   $a2, 0
  	li   $v0, 13 
 	syscall            
 	move $s5, $v0      
#########################################
	j Open2
	Edit20:
	addi $t0, $t0, 1		
	bgt $t0, 1, NextUserByte2
	sub $s0, $s0, $t4
	li $t4, 0
	j LetterWasValid2
		Edit21:
		addi $t5, $t5, 1		
		bgt $t5, 1, NextUserByte2
		sub $s0, $s0, $t4
		li $t4, 0
		j LetterWasValid2
			Edit22:
			addi $t8, $t8, 1		
			bgt $t8, 1, NextUserByte2
			sub $s0, $s0, $t4
			li $t4, 0
			j LetterWasValid2
				Edit23:
				addi $t9, $t9, 1		
				bgt $t9, 1, NextUserByte2
				sub $s0, $s0, $t4
				li $t4, 0
				j LetterWasValid2
					Edit24:
					addi $a3, $a3, 1		
					bgt $a3, 1, NextUserByte2
					sub $s0, $s0, $t4
					li $t4, 0
					j LetterWasValid2
						Edit25:
						addi $s7, $s7, 1		
						bgt $s7, 1, NextUserByte2
						sub $s0, $s0, $t4
						li $t4, 0
						j LetterWasValid2
							Edit26:
							addi $v1, $v1, 1
							bgt $v1, 1, NextUserByte2
							sub $s0, $s0, $t4
							li $t4, 0
							j LetterWasValid2
	
	Edit30:
	addi $t0, $t0, 1		
	bgt $t0, 1, NextUserByte3
	sub $s0, $s0, $t4
	li $t4, 0
	j LetterWasValid3
		Edit31:
		addi $t5, $t5, 1		
		bgt $t5, 1, NextUserByte3
		sub $s0, $s0, $t4
		li $t4, 0
		j LetterWasValid3
			Edit32:
			addi $t8, $t8, 1		
			bgt $t8, 1, NextUserByte3
			sub $s0, $s0, $t4
			li $t4, 0
			j LetterWasValid3
				Edit33:
				addi $t9, $t9, 1		
				bgt $t9, 1, NextUserByte3
				sub $s0, $s0, $t4
				li $t4, 0
				j LetterWasValid3
					Edit34:
					addi $a3, $a3, 1		
					bgt $a3, 1, NextUserByte3
					sub $s0, $s0, $t4
					li $t4, 0
					j LetterWasValid3
						Edit35:
						addi $s7, $s7, 1		
						bgt $s7, 1, NextUserByte3
						sub $s0, $s0, $t4
						li $t4, 0
						j LetterWasValid3
							Edit36:
							addi $v1, $v1, 1
							bgt $v1, 1, NextUserByte3
							sub $s0, $s0, $t4
							li $t4, 0
							j LetterWasValid3
	
	Edit40:
	addi $t0, $t0, 1		
	bgt $t0, 1, NextUserByte4
	sub $s0, $s0, $t4
	li $t4, 0
	j LetterWasValid4
		Edit41:
		addi $t5, $t5, 1		
		bgt $t5, 1, NextUserByte4
		sub $s0, $s0, $t4
		li $t4, 0
		j LetterWasValid4
			Edit42:
			addi $t8, $t8, 1		
			bgt $t8, 1, NextUserByte4
			sub $s0, $s0, $t4
			li $t4, 0
			j LetterWasValid4
				Edit43:
				addi $t9, $t9, 1		
				bgt $t9, 1, NextUserByte4
				sub $s0, $s0, $t4
				li $t4, 0
				j LetterWasValid4
					Edit44:
					addi $a3, $a3, 1		
					bgt $a3, 1, NextUserByte4
					sub $s0, $s0, $t4
					li $t4, 0
					j LetterWasValid4
						Edit45:
						addi $s7, $s7, 1		
						bgt $s7, 1, NextUserByte4
						sub $s0, $s0, $t4
						li $t4, 0
						j LetterWasValid4
							Edit46:
							addi $v1, $v1, 1
							bgt $v1, 1, NextUserByte4
							sub $s0, $s0, $t4
							li $t4, 0
							j LetterWasValid4
	
	Edit50:
	addi $t0, $t0, 1		
	bgt $t0, 1, NextUserByte5
	sub $s0, $s0, $t4
	li $t4, 0
	j LetterWasValid5
		Edit51:
		addi $t5, $t5, 1		
		bgt $t5, 1, NextUserByte5
		sub $s0, $s0, $t4
		li $t4, 0
		j LetterWasValid5
			Edit52:
			addi $t8, $t8, 1		
			bgt $t8, 1, NextUserByte5
			sub $s0, $s0, $t4
			li $t4, 0
			j LetterWasValid5
				Edit53:
				addi $t9, $t9, 1		
				bgt $t9, 1, NextUserByte5
				sub $s0, $s0, $t4
				li $t4, 0
				j LetterWasValid5
					Edit54:
					addi $a3, $a3, 1		
					bgt $a3, 1, NextUserByte5
					sub $s0, $s0, $t4
					li $t4, 0
					j LetterWasValid5
						Edit55:
						addi $s7, $s7, 1		
						bgt $s7, 1, NextUserByte5
						sub $s0, $s0, $t4
						li $t4, 0
						j LetterWasValid5
							Edit56:
							addi $v1, $v1, 1
							bgt $v1, 1, NextUserByte5
							sub $s0, $s0, $t4
							li $t4, 0
							j LetterWasValid5
	
	Edit60:
	addi $t0, $t0, 1		
	bgt $t0, 1, NextUserByte6
	sub $s0, $s0, $t4
	li $t4, 0
	j LetterWasValid6
		Edit61:
		addi $t5, $t5, 1		
		bgt $t5, 1, NextUserByte6
		sub $s0, $s0, $t4
		li $t4, 0
		j LetterWasValid6
			Edit62:
			addi $t8, $t8, 1		
			bgt $t8, 1, NextUserByte6
			sub $s0, $s0, $t4
			li $t4, 0
			j LetterWasValid6
				Edit63:
				addi $t9, $t9, 1		
				bgt $t9, 1, NextUserByte6
				sub $s0, $s0, $t4
				li $t4, 0
				j LetterWasValid6
					Edit64:
					addi $a3, $a3, 1		
					bgt $a3, 1, NextUserByte6
					sub $s0, $s0, $t4
					li $t4, 0
					j LetterWasValid6
						Edit65:
						addi $s7, $s7, 1		
						bgt $s7, 1, NextUserByte6
						sub $s0, $s0, $t4
						li $t4, 0
						j LetterWasValid6
							Edit66:
							addi $v1, $v1, 1
							bgt $v1, 1, NextUserByte6
							sub $s0, $s0, $t4
							li $t4, 0
							j LetterWasValid6
	
	Edit70:
	addi $t0, $t0, 1		
	bgt $t0, 1, NextUserByte7
	sub $s0, $s0, $t4
	li $t4, 0
	j LetterWasValid7
		Edit71:
		addi $t5, $t5, 1		
		bgt $t5, 1, NextUserByte7
		sub $s0, $s0, $t4
		li $t4, 0
		j LetterWasValid7
			Edit72:
			addi $t8, $t8, 1		
			bgt $t8, 1, NextUserByte7
			sub $s0, $s0, $t4
			li $t4, 0
			j LetterWasValid7
				Edit73:
				addi $t9, $t9, 1		
				bgt $t9, 1, NextUserByte7
				sub $s0, $s0, $t4
				li $t4, 0
				j LetterWasValid7
					Edit74:
					addi $a3, $a3, 1		
					bgt $a3, 1, NextUserByte7
					sub $s0, $s0, $t4
					li $t4, 0
					j LetterWasValid7
						Edit75:
						addi $s7, $s7, 1		
						bgt $s7, 1, NextUserByte7
						sub $s0, $s0, $t4
						li $t4, 0
						j LetterWasValid7
							Edit76:
							addi $v1, $v1, 1		
							bgt $v1, 1, NextUserByte7
							sub $s0, $s0, $t4
							li $t4, 0
							j LetterWasValid7

######## Open 2 Word Input File #########
	Open2:
	la   $a0, words2
	li   $a1, 0
	li   $a2, 0
	li $v0, 13
	syscall
	move $s6, $v0
	# make room for $sp counter and set to zero
	subi $sp, $sp, 4
	sw $zero, ($sp)
#########################################

######## Getting Valid 2 Length Words ###
	ValidWords2:
	move $a0, $s6
	la $a1, buffer2
	li $a2, 4
	li $v0, 14
	syscall		# Reading a word in
	addi $t1, $t1, 1
	beq $t1, 102, Verify2	# counter to make sure we check all words
		CheckWord2:
		lb $t2, ($a1)	# load word byte
		lb $t3, ($s0)	# load user byte
		beq $t2, 13, WordIsValid2	# Carriage return
		beq $t2, 0, Done		# end of file
		bne $t2, $t3, NextUserByte2	# not equal go to NextUserByte
		beq $t4, 0, Edit20
		beq $t4, 1, Edit21
		beq $t4, 2, Edit22
		beq $t4, 3, Edit23
		beq $t4, 4, Edit24
		beq $t4, 5, Edit25
		beq $t4, 6, Edit26
		LetterWasValid2:
		addi $a1, $a1, 1	# Go to next byte in read word
		addi $t6, $t6, 1	# Counter to know what byte we are on in read word
		j CheckWord2
			NextUserByte2:
			addi $t4, $t4, 1
			beq $t4, $s4, NotValidWord2
			addi $s0, $s0, 1
			j CheckWord2
				NotValidWord2:
				subi $t4, $t4, 1
				sub $s0, $s0, $t4
				li $t4, 0			
				li $t6, 0
				li $t0, 0
				li $t5, 0
				li $t8, 0
				li $t9, 0
				li $a3, 0
				li $s7, 0
				li $v1, 0			
				addi $a1, $a1, 1
				j ValidWords2
					WordIsValid2:
					sub $s0, $s0, $t4
					li $t4, 0
					sub $a1, $a1, $t6
					li $t6, 0
					move $a0, $s5
					la $a1, ($a1)
					li $a2, 4
					li $v0, 15
					syscall
					# Update $sp counter
					lw $t0, ($sp)
					addi $t0, $t0, 1
					sw $t0, ($sp)
					#
					li $t0, 0
					li $t5, 0
					li $t8, 0
					li $t9, 0
					li $a3, 0
					li $s7, 0
					li $v1, 0
					j ValidWords2
					
######## Verify $s2 for Size 2 Words ####
	Verify2:
	lw $t0, ($sp)		# load valid word counter into $s2
	addiu $sp, $sp, 4 	# restore $sp
	slti $t1, $t0, 4	# set $t1 to zero if default <= num valid words
	bne $t1, $zero, Update2	# if default > num valid words, update $s2
	j Done
		Update2:
		subi $s2, $s2, 40	# reset $s2's default to 0
		li $t1, 10 		# size 3 words are in the 100's place
		mult $t0, $t1 		# $t0 contains num valid words
		mflo $t0 		# move the lower 32 bits of multiplication into $t0
		add $s2, $s2, $t0	# replace $s2 with num valid words
		j Done
							
######## Open 3 Word Input File #########
	Open3:
	la   $a0, words3
	li   $a1, 0
	li   $a2, 0
	li $v0, 13
	syscall
	move $s6, $v0
	# make room for $sp counter and set to zero
	subi $sp, $sp, 4
	sw $zero, ($sp)
#########################################

######## Getting Valid 3 Length Words ###
	ValidWords3:
	move $a0, $s6
	la $a1, buffer3
	li $a2, 5
	li $v0, 14
	syscall		
	addi $t1, $t1, 1
	beq $t1, 1019, Verify3
		CheckWord3:
		lb $t2, ($a1)
		lb $t3, ($s0)
		beq $t2, 13, WordIsValid3
		beq $t2, 0, Done
		bne $t2, $t3, NextUserByte3
		beq $t4, 0, Edit30
		beq $t4, 1, Edit31
		beq $t4, 2, Edit32
		beq $t4, 3, Edit33
		beq $t4, 4, Edit34
		beq $t4, 5, Edit35
		beq $t4, 6, Edit36
		LetterWasValid3:
		addi $a1, $a1, 1
		addi $t6, $t6, 1
		j CheckWord3
			NextUserByte3:
			addi $t4, $t4, 1
			beq $t4, $s4, NotValidWord3
			addi $s0, $s0, 1
			j CheckWord3
				NotValidWord3:
				subi $t4, $t4, 1
				sub $s0, $s0, $t4
				li $t4, 0			
				li $t6, 0
				li $t0, 0
				li $t5, 0
				li $t8, 0
				li $t9, 0
				li $a3, 0
				li $s7, 0
				li $v1, 0			
				addi $a1, $a1, 1
				j ValidWords3
					WordIsValid3:
					sub $s0, $s0, $t4
					li $t4, 0
					sub $a1, $a1, $t6
					li $t6, 0
					move $a0, $s5
					la $a1, ($a1)
					li $a2, 5
					li $v0, 15
					syscall
					# Update $sp counter
					lw $t0, ($sp)
					addi $t0, $t0, 1
					sw $t0, ($sp)
					#
					li $t0, 0
					li $t5, 0
					li $t8, 0
					li $t9, 0
					li $a3, 0
					li $s7, 0
					li $v1, 0
					j ValidWords3

######## Verify $s2 for Size 3 Words ####
	Verify3:
	lw $t0, ($sp)		# load valid word counter into $s2
	addiu $sp, $sp, 4 	# restore $sp
	slti $t1, $t0, 5	# set $t1 to zero if default <= num valid words
	bne $t1, $zero, Update3	# if default > num valid words, update $s2
	j Done
		Update3:
		subi $s2, $s2, 500	# reset $s2's default to 0
		li $t1, 100 		# size 3 words are in the 100's place
		mult $t0, $t1 		# $t0 contains num valid words
		mflo $t0 		# move the lower 32 bits of multiplication into $t0
		add $s2, $s2, $t0	# replace $s2 with num valid words
		j Done
							
######## Open 4 Word Input File #########
	Open4:
	la   $a0, words4
	li   $a1, 0
	li   $a2, 0
	li $v0, 13
	syscall
	move $s6, $v0
	# make room for $sp counter and set to zero
	subi $sp, $sp, 4
	sw $zero, ($sp)
#########################################

######## Getting Valid 4 Length Words ###
	ValidWords4:
	move $a0, $s6
	la $a1, buffer4
	li $a2, 6
	li $v0, 14
	syscall
	addi $t1, $t1, 1
	beq $t1, 4036, Verify4
		CheckWord4:
		lb $t2, ($a1)
		lb $t3, ($s0)
		beq $t2, 13, WordIsValid4
		beq $t2, 0, Done
		bne $t2, $t3, NextUserByte4
		beq $t4, 0, Edit40
		beq $t4, 1, Edit41
		beq $t4, 2, Edit42
		beq $t4, 3, Edit43
		beq $t4, 4, Edit44
		beq $t4, 5, Edit45
		beq $t4, 6, Edit46
		LetterWasValid4:
		addi $a1, $a1, 1
		addi $t6, $t6, 1	
		j CheckWord4
			NextUserByte4:
			addi $t4, $t4, 1
			beq $t4, $s4, NotValidWord4
			addi $s0, $s0, 1
			j CheckWord4
				NotValidWord4:
				subi $t4, $t4, 1
				sub $s0, $s0, $t4
				li $t4, 0			
				li $t6, 0
				li $t0, 0
				li $t5, 0
				li $t8, 0
				li $t9, 0
				li $a3, 0
				li $s7, 0
				li $v1, 0			
				addi $a1, $a1, 1
				j ValidWords4
					WordIsValid4:
					sub $s0, $s0, $t4
					li $t4, 0
					sub $a1, $a1, $t6
					li $t6, 0
					move $a0, $s5
					la $a1, ($a1)
					li $a2, 6
					li $v0, 15
					syscall
					# Update $sp counter
					lw $t0, ($sp)
					addi $t0, $t0, 1
					sw $t0, ($sp)
					#
					li $t0, 0
					li $t5, 0
					li $t8, 0
					li $t9, 0
					li $a3, 0
					li $s7, 0
					li $v1, 0
					j ValidWords4							
					
######## Verify $s2 for Size 4 Words ####
	Verify4:
	lw $t0, ($sp)		# load valid word counter into $s2
	addiu $sp, $sp, 4 	# restore $sp
	slti $t1, $t0, 4	# set $t1 to zero if default <= num valid words
	bne $t1, $zero, Update4	# if default > num valid words, update $s2
	j Done
		Update4:
		subi $s2, $s2, 4000	# reset $s2's default to 0
		li $t1, 1000 		# size 3 words are in the 1000's place
		mult $t0, $t1 		# $t0 contains num valid words
		mflo $t0 		# move the lower 32 bits of multiplication into $t0
		add $s2, $s2, $t0	# replace $s2 with num valid words
		j Done
											
######## Open 5 Word Input File #########
	Open5:
	la   $a0, words5
	li   $a1, 0
	li   $a2, 0
	li $v0, 13
	syscall
	move $s6, $v0
	# make room for $sp counter and set to zero
	subi $sp, $sp, 4
	sw $zero, ($sp)
#########################################

######## Getting Valid 5 Length Words ###
	ValidWords5:
	move $a0, $s6
	la $a1, buffer5
	li $a2, 7
	li $v0, 14
	syscall
	addi $t1, $t1, 1
	beq $t1, 8939, Verify5
		CheckWord5:
		lb $t2, ($a1)
		lb $t3, ($s0)
		beq $t2, 13, WordIsValid5
		beq $t2, 0, Done
		bne $t2, $t3, NextUserByte5
		beq $t4, 0, Edit50
		beq $t4, 1, Edit51
		beq $t4, 2, Edit52
		beq $t4, 3, Edit53
		beq $t4, 4, Edit54
		beq $t4, 5, Edit55
		beq $t4, 6, Edit56
		LetterWasValid5:
		addi $a1, $a1, 1
		addi $t6, $t6, 1
		j CheckWord5
			NextUserByte5:
			addi $t4, $t4, 1
			beq $t4, $s4, NotValidWord5
			addi $s0, $s0, 1
			j CheckWord5
				NotValidWord5:
				subi $t4, $t4, 1
				sub $s0, $s0, $t4
				li $t4, 0			
				li $t6, 0
				li $t0, 0
				li $t5, 0
				li $t8, 0
				li $t9, 0
				li $a3, 0
				li $s7, 0
				li $v1, 0			
				addi $a1, $a1, 1
				j ValidWords5
					WordIsValid5:
					sub $s0, $s0, $t4
					li $t4, 0
					sub $a1, $a1, $t6
					li $t6, 0
					move $a0, $s5
					la $a1, ($a1)
					li $a2, 7
					li $v0, 15
					syscall
					# Update $sp counter
					lw $t0, ($sp)
					addi $t0, $t0, 1
					sw $t0, ($sp)
					#
					li $t0, 0
					li $t5, 0
					li $t8, 0
					li $t9, 0
					li $a3, 0
					li $s7, 0
					li $v1, 0
					j ValidWords5
					
######## Verify $s2 for Size 5 Words ####
	Verify5:
	lw $t0, ($sp)		# load valid word counter into $s2
	addiu $sp, $sp, 4 	# restore $sp
	slti $t1, $t0, 4	# set $t1 to zero if default <= num valid words
	bne $t1, $zero, Update5	# if default > num valid words, update $s2
	j Done
		Update5:
		subi $s2, $s2, 40000	# reset $s2's default to 0
		li $t1, 10000 		# size 3 words are in the 10000's place
		mult $t0, $t1 		# $t0 contains num valid words
		mflo $t0 		# move the lower 32 bits of multiplication into $t0
		add $s2, $s2, $t0	# replace $s2 with num valid words
		j Done
							
######## Open 6 Word Input File #########
	Open6:
	la   $a0, words6
	li   $a1, 0
	li   $a2, 0
	li $v0, 13
	syscall
	move $s6, $v0
	# make room for $sp counter and set to zero
	subi $sp, $sp, 4
	sw $zero, ($sp)
#########################################

######## Getting Valid 6 Length Words ###
	ValidWords6:
	move $a0, $s6
	la $a1, buffer6
	li $a2, 8
	li $v0, 14
	syscall
	addi $t1, $t1, 1
	beq $t1, 15788, Verify6
		CheckWord6:
		lb $t2, ($a1)
		lb $t3, ($s0)
		beq $t2, 13, WordIsValid6
		beq $t2, 0, Done
		bne $t2, $t3, NextUserByte6
		beq $t4, 0, Edit60
		beq $t4, 1, Edit61
		beq $t4, 2, Edit62
		beq $t4, 3, Edit63
		beq $t4, 4, Edit64
		beq $t4, 5, Edit65
		beq $t4, 6, Edit66
		LetterWasValid6:
		addi $a1, $a1, 1
		addi $t6, $t6, 1
		j CheckWord6
			NextUserByte6:
			addi $t4, $t4, 1
			beq $t4, $s4, NotValidWord6
			addi $s0, $s0, 1
			j CheckWord6
				NotValidWord6:
				subi $t4, $t4, 1
				sub $s0, $s0, $t4
				li $t4, 0			
				li $t6, 0
				li $t0, 0
				li $t5, 0
				li $t8, 0
				li $t9, 0
				li $a3, 0
				li $s7, 0
				li $v1, 0			
				addi $a1, $a1, 1
				j ValidWords6
					WordIsValid6:
					sub $s0, $s0, $t4
					li $t4, 0
					sub $a1, $a1, $t6
					li $t6, 0
					move $a0, $s5
					la $a1, ($a1)
					li $a2, 8
					li $v0, 15
					syscall
					# Update $sp counter
					lw $t0, ($sp)
					addi $t0, $t0, 1
					sw $t0, ($sp)
					#
					li $t0, 0
					li $t5, 0
					li $t8, 0
					li $t9, 0
					li $a3, 0
					li $s7, 0
					li $v1, 0
					j ValidWords6
					
######## Verify $s2 for Size 6 Words ####
	Verify6:
	lw $t0, ($sp)		# load valid word counter into $s2
	addiu $sp, $sp, 4 	# restore $sp
	slti $t1, $t0, 2	# set $t1 to zero if default <= num valid words
	bne $t1, $zero, Update6	# if default > num valid words, update $s2
	j Done
		Update6:
		subi $s2, $s2, 200000	# reset $s2's default to 0
		li $t1, 100000 		# size 3 words are in the 100000's place
		mult $t0, $t1 		# $t0 contains num valid words
		mflo $t0 		# move the lower 32 bits of multiplication into $t0
		add $s2, $s2, $t0	# replace $s2 with num valid words
		j Done
							
######## Open 7 Word Input File #########
	Open7:
	la   $a0, words7
	li   $a1, 0
	li   $a2, 0
	li $v0, 13
	syscall
	move $s6, $v0
	# make room for $sp counter and set to zero
	subi $sp, $sp, 4
	sw $zero, ($sp)
#########################################

######## Getting Valid 7 Length Words ###
	ValidWords7:
	move $a0, $s6
	la $a1, buffer7
	li $a2, 9
	li $v0, 14
	syscall
	addi $t1, $t1, 1
	beq $t1, 24037, Verify7
		CheckWord7:
		lb $t2, ($a1)
		lb $t3, ($s0)
		beq $t2, 13, WordIsValid7
		beq $t2, 0, Done
		bne $t2, $t3, NextUserByte7
		beq $t4, 0, Edit70
		beq $t4, 1, Edit71
		beq $t4, 2, Edit72
		beq $t4, 3, Edit73
		beq $t4, 4, Edit74
		beq $t4, 5, Edit75
		beq $t4, 6, Edit76
		LetterWasValid7:
		addi $a1, $a1, 1
		addi $t6, $t6, 1
		j CheckWord7
			NextUserByte7:
			addi $t4, $t4, 1
			beq $t4, $s4, NotValidWord7
			addi $s0, $s0, 1
			j CheckWord7
				NotValidWord7:
				subi $t4, $t4, 1
				sub $s0, $s0, $t4
				li $t4, 0			
				li $t6, 0
				li $t0, 0
				li $t5, 0
				li $t8, 0
				li $t9, 0
				li $a3, 0
				li $s7, 0
				li $v1, 0			
				addi $a1, $a1, 1
				j ValidWords7
					WordIsValid7:
					sub $s0, $s0, $t4
					li $t4, 0
					sub $a1, $a1, $t6
					li $t6, 0
					move $a0, $s5
					la $a1, ($a1)
					li $a2, 9
					li $v0, 15
					syscall
					# Update $sp counter
					lw $t0, ($sp)
					addi $t0, $t0, 1
					sw $t0, ($sp)
					#
					li $t0, 0
					li $t5, 0
					li $t8, 0
					li $t9, 0
					li $a3, 0
					li $s7, 0
					li $v1, 0
					j ValidWords7
					
######## Verify $s2 for Size 7 Words ####
	Verify7:
	lw $t0, ($sp)		# load valid word counter into $s2
	addiu $sp, $sp, 4 	# restore $sp
	slti $t1, $t0, 1	# set $t1 to zero if default <= num valid words
	bne $t1, $zero, Update7	# if default > num valid words, update $s2
	j Done
		Update7:
		subi $s2, $s2, 1000000	# reset $s2's default to 0
		li $t1, 1000000 	# size 3 words are in the 1000000's place
		mult $t0, $t1 		# $t0 contains num valid words
		mflo $t0 		# move the lower 32 bits of multiplication into $t0
		add $s2, $s2, $t0	# replace $s2 with num valid words
		j Done
		
#########################################
					
#########################################
	Done:
	move $a0, $s6
	li $v0, 16
	syscall					# Close the file that just got done (like words2, or words3, etc)
	li $t1, 0
	li $t0, 0
	li $t5, 0
	li $t8, 0
	li $t9, 0
	li $a3, 0
	li $s7, 0
	li $v1, 0
	addi $t7, $t7, 1			
	beq $t7, 1, Open3
	beq $t7, 2, Open4
	beq $t7, 3, Open5
	beq $s4, 5, ExitValidWordList		# No need to check for 6 or 7 letter words if the user is playing with 5 characters
	beq $t7, 4, Open6
	beq $s4, 6, ExitValidWordList
	beq $t7, 5, Open7
	
######## Closing Output File ##################	
	ExitValidWordList:
	move $a0, $s5
	li $v0, 16
	syscall
	
	j AfterValidWordList

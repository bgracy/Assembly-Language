.data
title1: .asciiz "\n                __      __      __      __        __      ________        __           __      __       __      ________ \n"
title2: .asciiz "    nnjlimuenml|  |ilie|  |mjne|  |mjun|   \\iejn/   |lmne|         \\iljnj|  |mjjnlimml|  |uilj|   \\nljl|  |euej|   _____|neu \n"
title3: .asciiz "    nenmjeiulnj|  |emue|  |jeil|  |mjne|    \\ui/    |ljnj|  |nlim>  |uejn|  |euiljnnlj|  |imue|    \\mju|  |nieu|  |emjneujnm \n"
title4: .asciiz "    lelminjnmlj|  |iuen|  |nmej|  |mjne|  |\\ \\/ /|  |lime|  ____   <mjjen|  |iulnmeuln|  |emjn|     \\eu|  |nlim|  |uemjunlen \n"
title5: .asciiz "    uem|  |niej|  |neui|  |nmjj|  |uilj|  |e\\__/n|  |euej|  |euil\\  |jnli|  |jnlimueen|  |euem|  |\\  \\j|  |limu|   _____|ejj \n"
title6: .asciiz "    enm|  |ilie|  |jneu|  |jnjn|  |ejne|  |uiljnm|  |nlim|  |mjun/  |ieue|  |mjneuilli|  |muem|  |j\\  \\|  |unie|  |julnmjenj \n"
title7: .asciiz "    lim|__________|mjnl|__________|lmin|__|jnmlje|__|uniu|_________/mjnme|_________|ej|__|eliu|__|mj\\__ __|neli|________|mmj \n"
title8: .asciiz "    ~~~~~j~~~~b~~~~~~~m~~~~~~~e~~~~~~i~~~~~~~~~~u~~~~~~~~~j~~~~l~~~n~~~~~i~~~m~~~~~~~b~~~e~~i~~~~~l~~~~u~~~~~e~~~~~~n~~~~~~e \n"
title9: .asciiz "    ~~~~~~~~m~~~e~~~|<        a Mips program by Josh Binkley, Daren Cheng, Brad Gracy, and Luke New        |~~~b~~~~~~~~m~~~ \n"
title10:.asciiz "   ~~~~n~~~~~~~~~i~~|        <:>C                                                 ><:>                     |~~~~~~~~j~~~~~~~~ \n"
title11:.asciiz "  ~~~u~~~~~~~i~~~~~~|                              A L P Y :   P R E S S   1                               |~~~u~~~~~~~~~i~~~~\n"
title12:.asciiz " ~~~~~~~~l~~~~~~b~~~|                      ><:>    U Q I T :   P R E S S   0                 <:>c          |~~~~~~~l~~~~~~n~~~~\n"
title13:.asciiz "~~~~~~~~~~~~~~~~~~~~|   ><:>                                                                         }<:>  |~~~~~~~~~~~~~~~~~~~~\n"

.text
titlescreen:
	li $v0, 4
	la $a0, title1
	syscall
	la $a0, title2
	syscall
	la $a0, title3
	syscall
	la $a0, title4
	syscall
	la $a0, title5
	syscall
	la $a0, title6
	syscall
	la $a0, title7
	syscall
	la $a0, title8
	syscall
	la $a0, title9
	syscall
	la $a0, title10
	syscall
	la $a0, title11
	syscall
	la $a0, title12
	syscall
	la $a0, title13
	syscall
	
	j AfterTitle
	

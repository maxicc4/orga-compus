	.file	1 "main.c"
	.section .mdebug.abi32
	.previous
	.abicalls
	.text
	.align	2
	.globl	is_palindrome
	.ent	is_palindrome
is_palindrome:
	.frame	$fp,24,$ra		# vars= 8, regs= 2/0, args= 0, extra= 8
	.mask	0x50000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$t9
	.set	reorder
	subu	$sp,$sp,24
	.cprestore 0
	sw	$fp,20($sp)
	sw	$gp,16($sp)
	move	$fp,$sp
	sw	$a0,24($fp)
	sw	$a1,28($fp)
	lw	$v0,28($fp)
	sltu	$v0,$v0,2
	beq	$v0,$zero,$L18
	sw	$zero,12($fp)
	b	$L17
$L18:
	sw	$zero,8($fp)
$L19:
	lw	$v0,28($fp)
	srl	$v1,$v0,1
	lw	$v0,8($fp)
	sltu	$v0,$v0,$v1
	bne	$v0,$zero,$L22
	b	$L20
$L22:
	lw	$v1,24($fp)
	lw	$v0,8($fp)
	addu	$v0,$v1,$v0
	lb	$v0,0($v0)
	sll	$v1,$v0,1
	lw	$v0,_tolower_tab_
	addu	$v0,$v1,$v0
	addu	$a0,$v0,2
	lw	$v1,28($fp)
	lw	$v0,8($fp)
	subu	$v1,$v1,$v0
	lw	$v0,24($fp)
	addu	$v0,$v1,$v0
	addu	$v0,$v0,-1
	lb	$v0,0($v0)
	sll	$v1,$v0,1
	lw	$v0,_tolower_tab_
	addu	$v0,$v1,$v0
	addu	$v0,$v0,2
	lh	$v1,0($a0)
	lh	$v0,0($v0)
	beq	$v1,$v0,$L21
	sw	$zero,12($fp)
	b	$L17
$L21:
	lw	$v0,8($fp)
	addu	$v0,$v0,1
	sw	$v0,8($fp)
	b	$L19
$L20:
	li	$v0,1			# 0x1
	sw	$v0,12($fp)
$L17:
	lw	$v0,12($fp)
	move	$sp,$fp
	lw	$fp,20($sp)
	addu	$sp,$sp,24
	j	$ra
	.end	is_palindrome
	.size	is_palindrome, .-is_palindrome
	.align	2
	.globl	processFile
	.ent	processFile
processFile:
	.frame	$fp,56,$ra		# vars= 16, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$t9
	.set	reorder
	subu	$sp,$sp,56
	.cprestore 16
	sw	$ra,48($sp)
	sw	$fp,44($sp)
	sw	$gp,40($sp)
	move	$fp,$sp
	sw	$a0,56($fp)
	sw	$a1,60($fp)
	li	$v0,32			# 0x20
	sw	$v0,24($fp)
	lw	$a0,24($fp)
	la	$t9,malloc
	jal	$ra,$t9
	sw	$v0,28($fp)
	sw	$zero,32($fp)
$L25:
	lw	$a0,56($fp)
	la	$t9,at_eof
	jal	$ra,$t9
	beq	$v0,$zero,$L27
	b	$L26
$L27:
	addu	$v0,$fp,28
	lw	$a0,56($fp)
	move	$a1,$v0
	addu	$a2,$fp,24
	la	$t9,read_word
	jal	$ra,$t9
	sw	$v0,32($fp)
	lw	$a0,28($fp)
	lw	$a1,32($fp)
	la	$t9,is_palindrome
	jal	$ra,$t9
	beq	$v0,$zero,$L25
	lw	$a0,60($fp)
	lw	$a1,28($fp)
	lw	$a2,32($fp)
	la	$t9,write_word
	jal	$ra,$t9
	b	$L25
$L26:
	lw	$a0,28($fp)
	la	$t9,free
	jal	$ra,$t9
	move	$v0,$zero
	move	$sp,$fp
	lw	$ra,48($sp)
	lw	$fp,44($sp)
	addu	$sp,$sp,56
	j	$ra
	.end	processFile
	.size	processFile, .-processFile
	.rdata
	.align	2
$LC0:
	.ascii	"%s\000"
	.align	2
$LC1:
	.ascii	"Usage:\n"
	.ascii	"\ttp0 -h\n"
	.ascii	"\ttp0 -V\n"
	.ascii	"\ttp0 [options]\n"
	.ascii	"Options:\n"
	.ascii	"\t-V, --version \tPrint version and quit.\n"
	.ascii	"\t-h, --help \tPrint this information.\n"
	.ascii	"\t-i, --input \tLocation of the input file.\n"
	.ascii	"\t-o, --output \tLocation of the output file.\n"
	.ascii	"Examples:\n"
	.ascii	"\ttp0 -i ~/input -o ~/output\n\000"
	.text
	.align	2
	.globl	show_help_menu
	.ent	show_help_menu
show_help_menu:
	.frame	$fp,40,$ra		# vars= 0, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$t9
	.set	reorder
	subu	$sp,$sp,40
	.cprestore 16
	sw	$ra,32($sp)
	sw	$fp,28($sp)
	sw	$gp,24($sp)
	move	$fp,$sp
	la	$a0,$LC0
	la	$a1,$LC1
	la	$t9,printf
	jal	$ra,$t9
	move	$sp,$fp
	lw	$ra,32($sp)
	lw	$fp,28($sp)
	addu	$sp,$sp,40
	j	$ra
	.end	show_help_menu
	.size	show_help_menu, .-show_help_menu
	.rdata
	.align	2
$LC2:
	.ascii	"version\000"
	.align	2
$LC3:
	.ascii	"help\000"
	.align	2
$LC4:
	.ascii	"input\000"
	.align	2
$LC5:
	.ascii	"output\000"
	.data
	.align	2
	.type	longOpts.0, @object
	.size	longOpts.0, 80
longOpts.0:
	.word	$LC2
	.word	0
	.word	0
	.word	86
	.word	$LC3
	.word	0
	.word	0
	.word	104
	.word	$LC4
	.word	1
	.word	0
	.word	105
	.word	$LC5
	.word	1
	.word	0
	.word	111
	.word	0
	.word	0
	.word	0
	.word	0
	.rdata
	.align	2
$LC6:
	.ascii	"hVi:o:\000"
	.align	2
$LC7:
	.ascii	"Palindrom Finder: v1.0\n\000"
	.align	2
$LC8:
	.ascii	"r\000"
	.align	2
$LC9:
	.ascii	"w\000"
	.text
	.align	2
	.globl	main
	.ent	main
main:
	.frame	$fp,88,$ra		# vars= 40, regs= 3/0, args= 24, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$t9
	.set	reorder
	subu	$sp,$sp,88
	.cprestore 24
	sw	$ra,80($sp)
	sw	$fp,76($sp)
	sw	$gp,72($sp)
	move	$fp,$sp
	sw	$a0,88($fp)
	sw	$a1,92($fp)
	sw	$zero,40($fp)
	sw	$zero,44($fp)
	sw	$zero,52($fp)
$L31:
	addu	$v0,$fp,52
	sw	$v0,16($sp)
	lw	$a0,88($fp)
	lw	$a1,92($fp)
	la	$a2,$LC6
	la	$a3,longOpts.0
	la	$t9,getopt_long
	jal	$ra,$t9
	sw	$v0,48($fp)
	lw	$v0,48($fp)
	addu	$v0,$v0,-63
	sw	$v0,64($fp)
	lw	$v1,64($fp)
	sltu	$v0,$v1,49
	beq	$v0,$zero,$L33
	lw	$v0,64($fp)
	sll	$v1,$v0,2
	la	$v0,$L41
	addu	$v0,$v1,$v0
	lw	$v0,0($v0)
	.cpadd	$v0
	j	$v0
	.rdata
	.align	2
$L41:
	.gpword	$L39
	.gpword	$L33
	.gpword	$L33
	.gpword	$L33
	.gpword	$L33
	.gpword	$L33
	.gpword	$L33
	.gpword	$L33
	.gpword	$L33
	.gpword	$L33
	.gpword	$L33
	.gpword	$L33
	.gpword	$L33
	.gpword	$L33
	.gpword	$L33
	.gpword	$L33
	.gpword	$L33
	.gpword	$L33
	.gpword	$L33
	.gpword	$L33
	.gpword	$L33
	.gpword	$L33
	.gpword	$L33
	.gpword	$L35
	.gpword	$L33
	.gpword	$L33
	.gpword	$L33
	.gpword	$L33
	.gpword	$L33
	.gpword	$L33
	.gpword	$L33
	.gpword	$L33
	.gpword	$L33
	.gpword	$L33
	.gpword	$L33
	.gpword	$L33
	.gpword	$L33
	.gpword	$L33
	.gpword	$L33
	.gpword	$L33
	.gpword	$L33
	.gpword	$L36
	.gpword	$L37
	.gpword	$L33
	.gpword	$L33
	.gpword	$L33
	.gpword	$L33
	.gpword	$L33
	.gpword	$L38
	.text
$L35:
	la	$a0,$LC0
	la	$a1,$LC7
	la	$t9,printf
	jal	$ra,$t9
	sw	$zero,60($fp)
	b	$L30
$L36:
	la	$t9,show_help_menu
	jal	$ra,$t9
	sw	$zero,60($fp)
	b	$L30
$L37:
	lw	$v0,optarg
	sw	$v0,40($fp)
	b	$L33
$L38:
	lw	$v0,optarg
	sw	$v0,44($fp)
	b	$L33
$L39:
	la	$t9,show_help_menu
	jal	$ra,$t9
	li	$v0,-1			# 0xffffffffffffffff
	sw	$v0,60($fp)
	b	$L30
$L33:
	lw	$v1,48($fp)
	li	$v0,-1			# 0xffffffffffffffff
	bne	$v1,$v0,$L31
	sw	$zero,56($fp)
	lw	$v0,56($fp)
	bne	$v0,$zero,$L43
	lw	$v0,40($fp)
	beq	$v0,$zero,$L43
	addu	$a0,$fp,32
	lw	$a1,40($fp)
	la	$a2,$LC8
	la	$t9,openFile
	jal	$ra,$t9
	sw	$v0,56($fp)
	b	$L44
$L43:
	la	$v0,__sF
	sw	$v0,32($fp)
$L44:
	lw	$v0,56($fp)
	bne	$v0,$zero,$L45
	lw	$v0,44($fp)
	beq	$v0,$zero,$L45
	addu	$v0,$fp,36
	move	$a0,$v0
	lw	$a1,44($fp)
	la	$a2,$LC9
	la	$t9,openFile
	jal	$ra,$t9
	sw	$v0,56($fp)
	b	$L46
$L45:
	la	$v0,__sF+88
	sw	$v0,36($fp)
$L46:
	lw	$v1,56($fp)
	li	$v0,-1			# 0xffffffffffffffff
	beq	$v1,$v0,$L47
	addu	$v0,$fp,36
	addu	$a0,$fp,32
	move	$a1,$v0
	la	$t9,processFile
	jal	$ra,$t9
	sw	$v0,56($fp)
$L47:
	addu	$a0,$fp,32
	la	$t9,closeFile
	jal	$ra,$t9
	addu	$v0,$fp,36
	move	$a0,$v0
	la	$t9,closeFile
	jal	$ra,$t9
	lw	$v0,56($fp)
	sw	$v0,60($fp)
$L30:
	lw	$v0,60($fp)
	move	$sp,$fp
	lw	$ra,80($sp)
	lw	$fp,76($sp)
	addu	$sp,$sp,88
	j	$ra
	.end	main
	.size	main, .-main
	.ident	"GCC: (GNU) 3.3.3 (NetBSD nb3 20040520)"

	.file	1 "fileHandler.c"
	.section .mdebug.abi32
	.previous
	.abicalls
	.rdata
	.align	2
$LC0:
	.ascii	"Error opening file.\n\000"
	.text
	.align	2
	.globl	openFile
	.ent	openFile
openFile:
	.frame	$fp,48,$ra		# vars= 8, regs= 4/0, args= 16, extra= 8
	.mask	0xd0010000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$t9
	.set	reorder
	subu	$sp,$sp,48
	.cprestore 16
	sw	$ra,44($sp)
	sw	$fp,40($sp)
	sw	$gp,36($sp)
	sw	$s0,32($sp)
	move	$fp,$sp
	sw	$a0,48($fp)
	sw	$a1,52($fp)
	sw	$a2,56($fp)
	lw	$s0,48($fp)
	lw	$a0,52($fp)
	lw	$a1,56($fp)
	la	$t9,fopen
	jal	$ra,$t9
	sw	$v0,0($s0)
	lw	$v0,48($fp)
	lw	$v0,0($v0)
	bne	$v0,$zero,$L18
	la	$a0,$LC0
	la	$t9,perror
	jal	$ra,$t9
	li	$v0,-1			# 0xffffffffffffffff
	sw	$v0,24($fp)
	b	$L17
$L18:
	sw	$zero,24($fp)
$L17:
	lw	$v0,24($fp)
	move	$sp,$fp
	lw	$ra,44($sp)
	lw	$fp,40($sp)
	lw	$s0,32($sp)
	addu	$sp,$sp,48
	j	$ra
	.end	openFile
	.size	openFile, .-openFile
	.rdata
	.align	2
$LC1:
	.ascii	"In file fileHandler.c, function closeFile: ERROR closing"
	.ascii	" file\n\000"
	.text
	.align	2
	.globl	closeFile
	.ent	closeFile
closeFile:
	.frame	$fp,48,$ra		# vars= 8, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$t9
	.set	reorder
	subu	$sp,$sp,48
	.cprestore 16
	sw	$ra,40($sp)
	sw	$fp,36($sp)
	sw	$gp,32($sp)
	move	$fp,$sp
	sw	$a0,48($fp)
	lw	$v0,48($fp)
	lw	$a0,0($v0)
	la	$t9,fclose
	jal	$ra,$t9
	sw	$v0,24($fp)
	lw	$v1,24($fp)
	li	$v0,-1			# 0xffffffffffffffff
	bne	$v1,$v0,$L20
	la	$a0,$LC1
	la	$t9,perror
	jal	$ra,$t9
	li	$v0,-1			# 0xffffffffffffffff
	sw	$v0,28($fp)
	b	$L19
$L20:
	sw	$zero,28($fp)
$L19:
	lw	$v0,28($fp)
	move	$sp,$fp
	lw	$ra,40($sp)
	lw	$fp,36($sp)
	addu	$sp,$sp,48
	j	$ra
	.end	closeFile
	.size	closeFile, .-closeFile
	.align	2
	.globl	at_eof
	.ent	at_eof
at_eof:
	.frame	$fp,16,$ra		# vars= 0, regs= 2/0, args= 0, extra= 8
	.mask	0x50000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$t9
	.set	reorder
	subu	$sp,$sp,16
	.cprestore 0
	sw	$fp,12($sp)
	sw	$gp,8($sp)
	move	$fp,$sp
	sw	$a0,16($fp)
	lw	$v0,16($fp)
	lw	$v0,0($v0)
	lhu	$v0,12($v0)
	srl	$v0,$v0,5
	andi	$v0,$v0,0x1
	andi	$v0,$v0,0x00ff
	move	$sp,$fp
	lw	$fp,12($sp)
	addu	$sp,$sp,16
	j	$ra
	.end	at_eof
	.size	at_eof, .-at_eof
	.align	2
	.globl	read_word
	.ent	read_word
read_word:
	.frame	$fp,48,$ra		# vars= 8, regs= 4/0, args= 16, extra= 8
	.mask	0xd0010000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$t9
	.set	reorder
	subu	$sp,$sp,48
	.cprestore 16
	sw	$ra,44($sp)
	sw	$fp,40($sp)
	sw	$gp,36($sp)
	sw	$s0,32($sp)
	move	$fp,$sp
	sw	$a0,48($fp)
	sw	$a1,52($fp)
	sw	$a2,56($fp)
	li	$v0,1			# 0x1
	sb	$v0,25($fp)
	sh	$zero,26($fp)
$L23:
	lbu	$v0,25($fp)
	bne	$v0,$zero,$L25
	b	$L24
$L25:
	lw	$v0,48($fp)
	lw	$a0,0($v0)
	la	$t9,fgetc
	jal	$ra,$t9
	sb	$v0,24($fp)
	lb	$v0,24($fp)
	move	$a0,$v0
	la	$t9,charIsValid
	jal	$ra,$t9
	beq	$v0,$zero,$L26
	lhu	$v0,26($fp)
	lw	$v1,56($fp)
	lw	$v1,0($v1)
	bne	$v0,$v1,$L27
	lw	$v1,56($fp)
	lw	$v0,56($fp)
	lw	$v0,0($v0)
	addu	$v0,$v0,32
	sw	$v0,0($v1)
	lw	$s0,52($fp)
	lw	$v0,52($fp)
	lw	$v1,56($fp)
	lw	$a0,0($v0)
	lw	$a1,0($v1)
	la	$t9,realloc
	jal	$ra,$t9
	sw	$v0,0($s0)
$L27:
	lw	$v0,52($fp)
	lhu	$v1,26($fp)
	lw	$v0,0($v0)
	addu	$v1,$v1,$v0
	lbu	$v0,24($fp)
	sb	$v0,0($v1)
	lhu	$v0,26($fp)
	addu	$v0,$v0,1
	sh	$v0,26($fp)
	b	$L23
$L26:
	sb	$zero,25($fp)
	b	$L23
$L24:
	lhu	$v0,26($fp)
	move	$sp,$fp
	lw	$ra,44($sp)
	lw	$fp,40($sp)
	lw	$s0,32($sp)
	addu	$sp,$sp,48
	j	$ra
	.end	read_word
	.size	read_word, .-read_word
	.align	2
	.globl	write_word
	.ent	write_word
write_word:
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
	sw	$a0,40($fp)
	sw	$a1,44($fp)
	sw	$a2,48($fp)
	lw	$v0,40($fp)
	lw	$a0,44($fp)
	lw	$a1,48($fp)
	li	$a2,1			# 0x1
	lw	$a3,0($v0)
	la	$t9,fwrite
	jal	$ra,$t9
	lw	$v0,40($fp)
	li	$a0,10			# 0xa
	lw	$a1,0($v0)
	la	$t9,fputc
	jal	$ra,$t9
	move	$sp,$fp
	lw	$ra,32($sp)
	lw	$fp,28($sp)
	addu	$sp,$sp,40
	j	$ra
	.end	write_word
	.size	write_word, .-write_word
	.align	2
	.globl	charIsValid
	.ent	charIsValid
charIsValid:
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
	move	$v0,$a0
	sb	$v0,8($fp)
	sb	$zero,9($fp)
	lb	$v0,8($fp)
	slt	$v0,$v0,123
	beq	$v0,$zero,$L33
	lb	$v0,8($fp)
	slt	$v0,$v0,97
	beq	$v0,$zero,$L32
$L33:
	lb	$v0,8($fp)
	slt	$v0,$v0,91
	beq	$v0,$zero,$L34
	lb	$v0,8($fp)
	slt	$v0,$v0,65
	beq	$v0,$zero,$L32
$L34:
	lb	$v0,8($fp)
	slt	$v0,$v0,48
	bne	$v0,$zero,$L35
	lb	$v0,8($fp)
	slt	$v0,$v0,58
	bne	$v0,$zero,$L32
$L35:
	lb	$v1,8($fp)
	li	$v0,45			# 0x2d
	beq	$v1,$v0,$L32
	lb	$v1,8($fp)
	li	$v0,95			# 0x5f
	beq	$v1,$v0,$L32
	b	$L31
$L32:
	li	$v0,1			# 0x1
	sb	$v0,9($fp)
$L31:
	lbu	$v0,9($fp)
	move	$sp,$fp
	lw	$fp,20($sp)
	addu	$sp,$sp,24
	j	$ra
	.end	charIsValid
	.size	charIsValid, .-charIsValid
	.ident	"GCC: (GNU) 3.3.3 (NetBSD nb3 20040520)"

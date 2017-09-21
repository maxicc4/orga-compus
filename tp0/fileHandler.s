	.file	1 "fileHandler.c"
	.section .mdebug.abi32
	.previous
	.abicalls
	.rdata
	.align	2
$LC0:
	.ascii	"Error opening file\000"
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
	.ascii	"ERROR closing file\000"
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
	lw	$v0,0($v0)
	bne	$v0,$zero,$L20
	li	$v0,-1			# 0xffffffffffffffff
	sw	$v0,24($fp)
	b	$L19
$L20:
	lw	$v0,48($fp)
	lw	$a0,0($v0)
	la	$t9,fclose
	jal	$ra,$t9
	move	$v1,$v0
	li	$v0,-1			# 0xffffffffffffffff
	bne	$v1,$v0,$L21
	la	$a0,$LC1
	la	$t9,perror
	jal	$ra,$t9
	li	$v0,-1			# 0xffffffffffffffff
	sw	$v0,24($fp)
	b	$L19
$L21:
	sw	$zero,24($fp)
$L19:
	lw	$v0,24($fp)
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
	.globl	has_error
	.ent	has_error
has_error:
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
	srl	$v0,$v0,6
	andi	$v0,$v0,0x1
	andi	$v0,$v0,0x00ff
	move	$sp,$fp
	lw	$fp,12($sp)
	addu	$sp,$sp,16
	j	$ra
	.end	has_error
	.size	has_error, .-has_error
	.rdata
	.align	2
$LC2:
	.ascii	"Error leyendo del archivo\000"
	.text
	.align	2
	.globl	read_word
	.ent	read_word
read_word:
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
	li	$v0,1			# 0x1
	sb	$v0,28($fp)
	sw	$zero,32($fp)
$L25:
	lbu	$v0,28($fp)
	bne	$v0,$zero,$L27
	b	$L26
$L27:
	lw	$v0,56($fp)
	lw	$a0,0($v0)
	la	$t9,fgetc
	jal	$ra,$t9
	sw	$v0,24($fp)
	lw	$a0,56($fp)
	la	$t9,has_error
	jal	$ra,$t9
	beq	$v0,$zero,$L28
	la	$a0,$LC2
	la	$t9,perror
	jal	$ra,$t9
	li	$v0,-1			# 0xffffffffffffffff
	sw	$v0,36($fp)
	b	$L24
$L28:
	lw	$a0,56($fp)
	la	$t9,at_eof
	jal	$ra,$t9
	bne	$v0,$zero,$L29
	lw	$a0,24($fp)
	la	$t9,charIsValid
	jal	$ra,$t9
	beq	$v0,$zero,$L29
	addu	$v1,$fp,32
	lw	$v0,0($v1)
	move	$a1,$v0
	addu	$v0,$v0,1
	sw	$v0,0($v1)
	lb	$v0,24($fp)
	lw	$a0,60($fp)
	move	$a2,$v0
	la	$t9,put_char
	jal	$ra,$t9
	move	$v1,$v0
	li	$v0,-1			# 0xffffffffffffffff
	bne	$v1,$v0,$L25
	li	$v0,-1			# 0xffffffffffffffff
	sw	$v0,36($fp)
	b	$L24
$L29:
	sb	$zero,28($fp)
	b	$L25
$L26:
	lw	$v0,32($fp)
	sw	$v0,36($fp)
$L24:
	lw	$v0,36($fp)
	move	$sp,$fp
	lw	$ra,48($sp)
	lw	$fp,44($sp)
	addu	$sp,$sp,56
	j	$ra
	.end	read_word
	.size	read_word, .-read_word
	.rdata
	.align	2
$LC3:
	.ascii	"Error escribiendo en el archivo\000"
	.text
	.align	2
	.globl	write_word
	.ent	write_word
write_word:
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
	sw	$a1,52($fp)
	sw	$a2,56($fp)
	lw	$a0,52($fp)
	la	$t9,get_buff
	jal	$ra,$t9
	lw	$v1,48($fp)
	move	$a0,$v0
	li	$a1,1			# 0x1
	lw	$a2,56($fp)
	lw	$a3,0($v1)
	la	$t9,fwrite
	jal	$ra,$t9
	move	$v1,$v0
	lw	$v0,56($fp)
	bne	$v1,$v0,$L33
	lw	$v0,48($fp)
	li	$a0,10			# 0xa
	lw	$a1,0($v0)
	la	$t9,fputc
	jal	$ra,$t9
$L33:
	lw	$v0,48($fp)
	lw	$v0,0($v0)
	lhu	$v0,12($v0)
	srl	$v0,$v0,6
	andi	$v0,$v0,0x1
	beq	$v0,$zero,$L34
	la	$a0,$LC3
	la	$t9,perror
	jal	$ra,$t9
	li	$v0,-1			# 0xffffffffffffffff
	sw	$v0,24($fp)
	b	$L32
$L34:
	sw	$zero,24($fp)
$L32:
	lw	$v0,24($fp)
	move	$sp,$fp
	lw	$ra,40($sp)
	lw	$fp,36($sp)
	addu	$sp,$sp,48
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
	sw	$a0,24($fp)
	sb	$zero,8($fp)
	lw	$v0,24($fp)
	slt	$v0,$v0,123
	beq	$v0,$zero,$L38
	lw	$v0,24($fp)
	slt	$v0,$v0,97
	beq	$v0,$zero,$L37
$L38:
	lw	$v0,24($fp)
	slt	$v0,$v0,91
	beq	$v0,$zero,$L39
	lw	$v0,24($fp)
	slt	$v0,$v0,65
	beq	$v0,$zero,$L37
$L39:
	lw	$v0,24($fp)
	slt	$v0,$v0,48
	bne	$v0,$zero,$L40
	lw	$v0,24($fp)
	slt	$v0,$v0,58
	bne	$v0,$zero,$L37
$L40:
	lw	$v1,24($fp)
	li	$v0,45			# 0x2d
	beq	$v1,$v0,$L37
	lw	$v1,24($fp)
	li	$v0,95			# 0x5f
	beq	$v1,$v0,$L37
	b	$L36
$L37:
	li	$v0,1			# 0x1
	sb	$v0,8($fp)
$L36:
	lbu	$v0,8($fp)
	move	$sp,$fp
	lw	$fp,20($sp)
	addu	$sp,$sp,24
	j	$ra
	.end	charIsValid
	.size	charIsValid, .-charIsValid
	.ident	"GCC: (GNU) 3.3.3 (NetBSD nb3 20040520)"

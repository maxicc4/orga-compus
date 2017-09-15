	.file	1 "buff.c"
	.section .mdebug.abi32
	.previous
	.abicalls
	.rdata
	.align	2
$LC0:
	.ascii	"Error reservando memoria\000"
	.text
	.align	2
	.globl	init
	.ent	init
init:
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
	lw	$v1,48($fp)
	lw	$v0,52($fp)
	sw	$v0,4($v1)
	lw	$s0,48($fp)
	lw	$a0,52($fp)
	la	$t9,malloc
	jal	$ra,$t9
	sw	$v0,0($s0)
	lw	$v0,48($fp)
	lw	$v0,0($v0)
	bne	$v0,$zero,$L18
	la	$a0,__sF+176
	la	$a1,$LC0
	la	$t9,fprintf
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
	.end	init
	.size	init, .-init
	.align	2
	.globl	destroy
	.ent	destroy
destroy:
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
	lw	$v0,40($fp)
	lw	$v0,0($v0)
	beq	$v0,$zero,$L19
	lw	$v0,40($fp)
	lw	$a0,0($v0)
	la	$t9,free
	jal	$ra,$t9
$L19:
	move	$sp,$fp
	lw	$ra,32($sp)
	lw	$fp,28($sp)
	addu	$sp,$sp,40
	j	$ra
	.end	destroy
	.size	destroy, .-destroy
	.align	2
	.globl	get_buff
	.ent	get_buff
get_buff:
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
	move	$sp,$fp
	lw	$fp,12($sp)
	addu	$sp,$sp,16
	j	$ra
	.end	get_buff
	.size	get_buff, .-get_buff
	.align	2
	.globl	put_char
	.ent	put_char
put_char:
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
	move	$v0,$a2
	sb	$v0,24($fp)
	lw	$v0,56($fp)
	lw	$v1,60($fp)
	lw	$v0,4($v0)
	bne	$v1,$v0,$L23
	lw	$v0,56($fp)
	lw	$v0,4($v0)
	sll	$v0,$v0,1
	sw	$v0,28($fp)
	lw	$v0,56($fp)
	lw	$a0,0($v0)
	lw	$a1,28($fp)
	la	$t9,realloc
	jal	$ra,$t9
	sw	$v0,32($fp)
	lw	$v0,32($fp)
	bne	$v0,$zero,$L24
	la	$a0,__sF+176
	la	$a1,$LC0
	la	$t9,fprintf
	jal	$ra,$t9
	li	$v0,-1			# 0xffffffffffffffff
	sw	$v0,36($fp)
	b	$L22
$L24:
	lw	$v1,56($fp)
	lw	$v0,28($fp)
	sw	$v0,4($v1)
	lw	$v1,56($fp)
	lw	$v0,32($fp)
	sw	$v0,0($v1)
$L23:
	lw	$v0,56($fp)
	lw	$v1,0($v0)
	lw	$v0,60($fp)
	addu	$v1,$v1,$v0
	lbu	$v0,24($fp)
	sb	$v0,0($v1)
	sw	$zero,36($fp)
$L22:
	lw	$v0,36($fp)
	move	$sp,$fp
	lw	$ra,48($sp)
	lw	$fp,44($sp)
	addu	$sp,$sp,56
	j	$ra
	.end	put_char
	.size	put_char, .-put_char
	.ident	"GCC: (GNU) 3.3.3 (NetBSD nb3 20040520)"

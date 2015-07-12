	.file	"infinite_version.c"
	.data
	.align 8
	.type	x, @object
	.size	x, 8
x:
	.quad	123456789
	.align 8
	.type	y, @object
	.size	y, 8
y:
	.quad	362436069
	.align 8
	.type	z, @object
	.size	z, 8
z:
	.quad	521288629
	.text
	.globl	xorshf96
	.type	xorshf96, @function
xorshf96:
.LFB4:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	x(%rip), %rax
	salq	$16, %rax
	movq	%rax, %rdx
	movq	x(%rip), %rax
	xorq	%rdx, %rax
	movq	%rax, x(%rip)
	movq	x(%rip), %rax
	shrq	$5, %rax
	movq	%rax, %rdx
	movq	x(%rip), %rax
	xorq	%rdx, %rax
	movq	%rax, x(%rip)
	movq	x(%rip), %rax
	leaq	(%rax,%rax), %rdx
	movq	x(%rip), %rax
	xorq	%rdx, %rax
	movq	%rax, x(%rip)
	movq	x(%rip), %rax
	movq	%rax, -8(%rbp)
	movq	y(%rip), %rax
	movq	%rax, x(%rip)
	movq	z(%rip), %rax
	movq	%rax, y(%rip)
	movq	x(%rip), %rax
	xorq	-8(%rbp), %rax
	movq	%rax, %rdx
	movq	y(%rip), %rax
	xorq	%rdx, %rax
	movq	%rax, z(%rip)
	movq	z(%rip), %rax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE4:
	.size	xorshf96, .-xorshf96
	.comm	data_start,8,8
	.comm	data_end,8,8
	.globl	size
	.section	.rodata
	.align 8
	.type	size, @object
	.size	size, 8
size:
	.quad	2048000
	.globl	linesize
	.data
	.align 4
	.type	linesize, @object
	.size	linesize, 4
linesize:
	.long	16
	.comm	ways,4,4
	.comm	stride,4,4
	.comm	colors,4,4
	.comm	buffer,8,8
	.comm	dump,400,64
	.globl	val
	.bss
	.align 8
	.type	val, @object
	.size	val, 8
val:
	.zero	8
	.globl	val2
	.data
	.align 4
	.type	val2, @object
	.size	val2, 4
val2:
	.long	1120403456
	.globl	val1
	.align 4
	.type	val1, @object
	.size	val1, 4
val1:
	.long	1120403456
	.section	.rodata
	.align 8
.LC0:
	.string	" allocating a total of %ldMB \n"
	.text
	.globl	init_buffer
	.type	init_buffer, @function
init_buffer:
.LFB5:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%rbx
	subq	$24, %rsp
	.cfi_offset 3, -24
	movl	$0, -28(%rbp)
	movl	ways(%rip), %eax
	movslq	%eax, %rdx
	movl	linesize(%rip), %eax
	cltq
	imulq	%rdx, %rax
	salq	$14, %rax
	movq	%rax, %rdi
	call	malloc
	movq	%rax, buffer(%rip)
	movl	ways(%rip), %eax
	movslq	%eax, %rdx
	movl	linesize(%rip), %eax
	cltq
	imulq	%rdx, %rax
	salq	$14, %rax
	shrq	$20, %rax
	movq	%rax, %rsi
	movl	$.LC0, %edi
	movl	$0, %eax
	call	printf
	movl	$0, %edi
	movl	$0, %eax
	call	time
	movl	%eax, %edi
	call	srand
	movq	buffer(%rip), %rax
	movq	%rax, -24(%rbp)
	movl	$0, -32(%rbp)
	jmp	.L4
.L5:
	movl	-32(%rbp), %eax
	cltq
	leaq	0(,%rax,4), %rdx
	movq	-24(%rbp), %rax
	leaq	(%rdx,%rax), %rbx
	call	rand
	movl	%eax, %edx
	movl	%edx, %eax
	sarl	$31, %eax
	shrl	$25, %eax
	addl	%eax, %edx
	andl	$127, %edx
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, (%rbx)
	addl	$1, -32(%rbp)
.L4:
	movl	ways(%rip), %eax
	sall	$12, %eax
	movl	%eax, %edx
	movl	linesize(%rip), %eax
	imull	%edx, %eax
	cmpl	-32(%rbp), %eax
	jg	.L5
	addq	$24, %rsp
	popq	%rbx
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE5:
	.size	init_buffer, .-init_buffer
	.globl	access_pattern
	.type	access_pattern, @function
access_pattern:
.LFB6:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	%edi, -36(%rbp)
	movl	$1, -16(%rbp)
	movq	buffer(%rip), %rax
	movq	%rax, -8(%rbp)
.L13:
	movl	$0, -28(%rbp)
	jmp	.L7
.L12:
	movl	$0, -20(%rbp)
	jmp	.L8
.L11:
	movl	$1, -24(%rbp)
	jmp	.L9
.L10:
	movl	-24(%rbp), %eax
	leal	-1(%rax), %edx
	movl	-36(%rbp), %eax
	imull	%eax, %edx
	movl	-20(%rbp), %eax
	addl	%edx, %eax
	movl	%eax, -12(%rbp)
	movl	-28(%rbp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$20, %eax
	movl	$-1431655765, %edx
	mull	%edx
	shrl	$9, %edx
	movl	-12(%rbp), %eax
	addl	%eax, %edx
	movl	linesize(%rip), %eax
	imull	%edx, %eax
	movl	%eax, %eax
	leaq	0(,%rax,4), %rdx
	movq	-8(%rbp), %rax
	addq	%rdx, %rax
	movl	(%rax), %eax
	movslq	%eax, %rdx
	movq	val(%rip), %rax
	addq	%rdx, %rax
	movq	%rax, val(%rip)
	addl	$1, -24(%rbp)
.L9:
	movl	$4096, %eax
	cltd
	idivl	-36(%rbp)
	cmpl	-24(%rbp), %eax
	ja	.L10
	addl	$1, -20(%rbp)
.L8:
	movl	-36(%rbp), %eax
	subl	$1, %eax
	cmpl	-20(%rbp), %eax
	jae	.L11
	addl	$1, -28(%rbp)
.L7:
	movl	ways(%rip), %eax
	cmpl	-28(%rbp), %eax
	ja	.L12
	jmp	.L13
	.cfi_endproc
.LFE6:
	.size	access_pattern, .-access_pattern
	.section	.rodata
.LC1:
	.string	"argc = %d\n"
.LC2:
	.string	"Usage: ways (4-20) "
.LC3:
	.string	"%ld useconds \n"
.LC4:
	.string	"done"
	.text
	.globl	main
	.type	main, @function
main:
.LFB7:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$64, %rsp
	movl	%edi, -52(%rbp)
	movq	%rsi, -64(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movl	$0, %edi
	movl	$0, %eax
	call	time
	movl	%eax, %edi
	call	srandom
	movl	-52(%rbp), %eax
	movl	%eax, %esi
	movl	$.LC1, %edi
	movl	$0, %eax
	call	printf
	cmpl	$3, -52(%rbp)
	jne	.L15
	movq	-64(%rbp), %rax
	addq	$8, %rax
	movq	(%rax), %rax
	movq	%rax, %rdi
	call	atoi
	movl	%eax, ways(%rip)
	movq	-64(%rbp), %rax
	addq	$16, %rax
	movq	(%rax), %rax
	movq	%rax, %rdi
	call	atoi
	movl	%eax, stride(%rip)
	leaq	-48(%rbp), %rax
	movl	$0, %esi
	movq	%rax, %rdi
	call	gettimeofday
	movl	$0, %eax
	call	init_buffer
	leaq	-32(%rbp), %rax
	movl	$0, %esi
	movq	%rax, %rdi
	call	gettimeofday
	movq	-24(%rbp), %rdx
	movq	-40(%rbp), %rax
	movq	%rdx, %rcx
	subq	%rax, %rcx
	movq	-32(%rbp), %rdx
	movq	-48(%rbp), %rax
	subq	%rax, %rdx
	movq	%rdx, %rax
	imulq	$1000000, %rax, %rax
	addq	%rcx, %rax
	movq	%rax, %rsi
	movl	$.LC3, %edi
	movl	$0, %eax
	call	printf
	movl	stride(%rip), %eax
	movl	%eax, %edi
	call	access_pattern
	movl	$.LC4, %edi
	call	puts
	movq	-8(%rbp), %rcx
	xorq	%fs:40, %rcx
	je	.L17
	jmp	.L18
.L15:
	movl	$.LC2, %edi
	call	puts
	movl	$0, %edi
	call	exit
.L18:
	call	__stack_chk_fail
.L17:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 4.9.1-16ubuntu6) 4.9.1"
	.section	.note.GNU-stack,"",@progbits

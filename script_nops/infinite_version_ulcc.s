	.file	"infinite_version_ulcc.c"
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
	.comm	color_low,4,4
	.comm	color_high,4,4
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
	.align 8
.LC1:
	.string	"failed to remap data region 1\n"
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
	subq	$48, %rsp
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movl	ways(%rip), %eax
	movslq	%eax, %rdx
	movl	linesize(%rip), %eax
	cltq
	imulq	%rdx, %rax
	salq	$15, %rax
	movq	%rax, %rdi
	call	malloc
	movq	%rax, buffer(%rip)
	movl	ways(%rip), %eax
	movslq	%eax, %rdx
	movl	linesize(%rip), %eax
	cltq
	imulq	%rdx, %rax
	salq	$15, %rax
	shrq	$20, %rax
	movq	%rax, %rsi
	movl	$.LC0, %edi
	movl	$0, %eax
	call	printf
	movq	buffer(%rip), %rax
	andl	$4095, %eax
	testq	%rax, %rax
	je	.L4
	movq	buffer(%rip), %rax
	andq	$-4096, %rax
	addq	$4096, %rax
	jmp	.L5
.L4:
	movq	buffer(%rip), %rax
.L5:
	movq	%rax, data_start(%rip)
	movq	buffer(%rip), %rax
	movl	ways(%rip), %edx
	movslq	%edx, %rcx
	movl	linesize(%rip), %edx
	movslq	%edx, %rdx
	imulq	%rcx, %rdx
	salq	$15, %rdx
	addq	%rdx, %rax
	andl	$4095, %eax
	testq	%rax, %rax
	je	.L6
	movq	buffer(%rip), %rax
	movl	ways(%rip), %edx
	movslq	%edx, %rcx
	movl	linesize(%rip), %edx
	movslq	%edx, %rdx
	imulq	%rcx, %rdx
	salq	$15, %rdx
	addq	%rdx, %rax
	andq	$-4096, %rax
	jmp	.L7
.L6:
	movq	buffer(%rip), %rax
	movl	ways(%rip), %edx
	movslq	%edx, %rcx
	movl	linesize(%rip), %edx
	movslq	%edx, %rdx
	imulq	%rcx, %rdx
	salq	$15, %rdx
	addq	%rdx, %rax
.L7:
	movq	%rax, data_end(%rip)
	leaq	-32(%rbp), %rax
	movq	%rax, %rdi
	call	cc_cacheregn_clr
	movl	color_high(%rip), %edx
	movl	color_low(%rip), %esi
	leaq	-32(%rbp), %rax
	movl	$1, %ecx
	movq	%rax, %rdi
	call	cc_cacheregn_set
	leaq	-32(%rbp), %rax
	movl	$1, %r8d
	movq	%rax, %rcx
	movl	$1, %edx
	movl	$data_end, %esi
	movl	$data_start, %edi
	call	cc_remap
	testl	%eax, %eax
	jns	.L8
	movq	stderr(%rip), %rax
	movq	%rax, %rcx
	movl	$30, %edx
	movl	$1, %esi
	movl	$.LC1, %edi
	call	fwrite
	jmp	.L3
.L8:
	movl	$0, %edi
	movl	$0, %eax
	call	time
	movl	%eax, %edi
	call	srand
	movq	buffer(%rip), %rax
	movq	%rax, -40(%rbp)
	movq	data_start(%rip), %rax
	movq	%rax, -40(%rbp)
	jmp	.L10
.L11:
	call	rand
	movl	%eax, %edx
	movl	%edx, %eax
	sarl	$31, %eax
	shrl	$25, %eax
	addl	%eax, %edx
	andl	$127, %edx
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, %edx
	movq	-40(%rbp), %rax
	movl	%edx, (%rax)
	addq	$4, -40(%rbp)
.L10:
	movq	data_end(%rip), %rax
	cmpq	%rax, -40(%rbp)
	jb	.L11
.L3:
	movq	-8(%rbp), %rax
	xorq	%fs:40, %rax
	je	.L12
	call	__stack_chk_fail
.L12:
	leave
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
	movl	$1, -16(%rbp)
	jmp	.L14
.L21:
	movl	$0, -28(%rbp)
	jmp	.L15
.L20:
	movl	$0, -20(%rbp)
	jmp	.L16
.L19:
	movl	$1, -24(%rbp)
	jmp	.L17
.L18:
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
	sall	$21, %eax
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
.L17:
	movl	$8192, %eax
	cltd
	idivl	-36(%rbp)
	cmpl	-24(%rbp), %eax
	ja	.L18
	addl	$1, -20(%rbp)
.L16:
	movl	-36(%rbp), %eax
	subl	$1, %eax
	cmpl	-20(%rbp), %eax
	jae	.L19
	addl	$1, -28(%rbp)
.L15:
	movl	ways(%rip), %eax
	cmpl	-28(%rbp), %eax
	ja	.L20
	movl	ways(%rip), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$21, %eax
	movl	%eax, %ecx
	movl	$715827883, %edx
	movl	%ecx, %eax
	imull	%edx
	sarl	$7, %edx
	movl	%ecx, %eax
	sarl	$31, %eax
	subl	%eax, %edx
	movl	%edx, %eax
	addl	%eax, -16(%rbp)
.L14:
	cmpl	$99999999, -16(%rbp)
	jle	.L21
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	access_pattern, .-access_pattern
	.section	.rodata
.LC2:
	.string	"argc = %d\n"
.LC3:
	.string	"Usage: ways (4-20) "
.LC4:
	.string	"%ld useconds \n"
.LC5:
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
	movl	$.LC2, %edi
	movl	$0, %eax
	call	printf
	cmpl	$5, -52(%rbp)
	jne	.L23
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
	movq	-64(%rbp), %rax
	addq	$24, %rax
	movq	(%rax), %rax
	movq	%rax, %rdi
	call	atoi
	movl	%eax, color_low(%rip)
	movq	-64(%rbp), %rax
	addq	$32, %rax
	movq	(%rax), %rax
	movq	%rax, %rdi
	call	atoi
	movl	%eax, color_high(%rip)
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
	movl	$.LC4, %edi
	movl	$0, %eax
	call	printf
	movl	stride(%rip), %eax
	movl	%eax, %edi
	call	access_pattern
	movl	$.LC5, %edi
	call	puts
	movq	-8(%rbp), %rcx
	xorq	%fs:40, %rcx
	je	.L25
	jmp	.L26
.L23:
	movl	$.LC3, %edi
	call	puts
	movl	$0, %edi
	call	exit
.L26:
	call	__stack_chk_fail
.L25:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 4.9.1-16ubuntu6) 4.9.1"
	.section	.note.GNU-stack,"",@progbits

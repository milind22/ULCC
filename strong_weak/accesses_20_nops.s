	.file	"infinite_version.c"
	.section	.text.unlikely,"ax",@progbits
.LCOLDB0:
	.text
.LHOTB0:
	.p2align 4,,15
	.globl	xorshf96
	.type	xorshf96, @function
xorshf96:
.LFB44:
	.cfi_startproc
	movq	x(%rip), %rax
	movq	z(%rip), %rcx
	movq	%rax, %rdx
	salq	$16, %rdx
	xorq	%rax, %rdx
	movq	%rdx, %rax
	shrq	$5, %rax
	xorq	%rax, %rdx
	movq	y(%rip), %rax
	movq	%rcx, y(%rip)
	movq	%rax, x(%rip)
	xorq	%rcx, %rax
	xorq	%rdx, %rax
	addq	%rdx, %rdx
	xorq	%rdx, %rax
	movq	%rax, z(%rip)
	ret
	.cfi_endproc
.LFE44:
	.size	xorshf96, .-xorshf96
	.section	.text.unlikely
.LCOLDE0:
	.text
.LHOTE0:
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC1:
	.string	" allocating a total of %ldMB \n"
	.section	.text.unlikely
.LCOLDB2:
	.text
.LHOTB2:
	.p2align 4,,15
	.globl	init_buffer
	.type	init_buffer, @function
init_buffer:
.LFB45:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	subq	$8, %rsp
	.cfi_def_cfa_offset 32
	movslq	ways(%rip), %rbx
	movslq	linesize(%rip), %rax
	imulq	%rax, %rbx
	salq	$14, %rbx
	movq	%rbx, %rdi
	shrq	$20, %rbx
	call	malloc
	movq	%rbx, %rdx
	movl	$.LC1, %esi
	movq	%rax, buffer(%rip)
	movl	$1, %edi
	xorl	%eax, %eax
	xorl	%ebx, %ebx
	call	__printf_chk
	xorl	%edi, %edi
	xorl	%eax, %eax
	call	time
	movl	%eax, %edi
	call	srand
	movl	ways(%rip), %eax
	movq	buffer(%rip), %rbp
	sall	$12, %eax
	imull	linesize(%rip), %eax
	testl	%eax, %eax
	jle	.L2
	.p2align 4,,10
	.p2align 3
.L6:
	call	rand
	cltd
	addl	$1, %ebx
	addq	$4, %rbp
	shrl	$25, %edx
	addl	%edx, %eax
	andl	$127, %eax
	subl	%edx, %eax
	movl	%eax, -4(%rbp)
	movl	ways(%rip), %eax
	sall	$12, %eax
	imull	linesize(%rip), %eax
	cmpl	%ebx, %eax
	jg	.L6
.L2:
	addq	$8, %rsp
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE45:
	.size	init_buffer, .-init_buffer
	.section	.text.unlikely
.LCOLDE2:
	.text
.LHOTE2:
	.section	.text.unlikely
.LCOLDB3:
	.text
.LHOTB3:
	.p2align 4,,15
	.globl	access_pattern
	.type	access_pattern, @function
access_pattern:
.LFB46:
	.cfi_startproc
	movl	$4096, %eax
	movl	ways(%rip), %r8d
	leal	-1(%rdi), %esi
	cltd
	idivl	%edi
.L17:
	xorl	%edi, %edi
	testl	%r8d, %r8d
	je	.L17
.L20:
	xorl	%ecx, %ecx
	.p2align 4,,10
	.p2align 3
.L18:
	cmpl	$1, %eax
	movl	$1, %edx
	jbe	.L15
	.p2align 4,,10
	.p2align 3
.L21:
	addl	$1, %edx
	cmpl	%eax, %edx
	jne	.L21
.L15:
	addl	$1, %ecx
	cmpl	%esi, %ecx
	jbe	.L18
	addl	$1, %edi
	cmpl	%r8d, %edi
	jne	.L20
	jmp	.L17
	.cfi_endproc
.LFE46:
	.size	access_pattern, .-access_pattern
	.section	.text.unlikely
.LCOLDE3:
	.text
.LHOTE3:
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC4:
	.string	"argc = %d\n"
.LC5:
	.string	"%ld useconds \n"
.LC6:
	.string	"Usage: ways (4-20) "
	.section	.text.unlikely
.LCOLDB7:
	.section	.text.startup,"ax",@progbits
.LHOTB7:
	.p2align 4,,15
	.globl	main
	.type	main, @function
main:
.LFB47:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	movl	%edi, %ebx
	xorl	%edi, %edi
	movq	%rsi, %rbp
	subq	$56, %rsp
	.cfi_def_cfa_offset 80
	movq	%fs:40, %rax
	movq	%rax, 40(%rsp)
	xorl	%eax, %eax
	call	time
	movl	%eax, %edi
	call	srandom
	xorl	%eax, %eax
	movl	%ebx, %edx
	movl	$.LC4, %esi
	movl	$1, %edi
	call	__printf_chk
	cmpl	$3, %ebx
	je	.L28
	movl	$.LC6, %edi
	call	puts
	xorl	%edi, %edi
	call	exit
.L28:
	movq	8(%rbp), %rdi
	movl	$10, %edx
	xorl	%esi, %esi
	call	strtol
	movq	16(%rbp), %rdi
	movl	$10, %edx
	xorl	%esi, %esi
	movl	%eax, ways(%rip)
	call	strtol
	xorl	%esi, %esi
	movq	%rsp, %rdi
	movl	%eax, stride(%rip)
	call	gettimeofday
	xorl	%eax, %eax
	call	init_buffer
	leaq	16(%rsp), %rdi
	xorl	%esi, %esi
	call	gettimeofday
	movq	16(%rsp), %rax
	subq	(%rsp), %rax
	movl	$1, %edi
	movq	24(%rsp), %rdx
	subq	8(%rsp), %rdx
	movl	$.LC5, %esi
	imulq	$1000000, %rax, %rax
	addq	%rax, %rdx
	xorl	%eax, %eax
	call	__printf_chk
	movl	stride(%rip), %edi
	call	access_pattern
	.cfi_endproc
.LFE47:
	.size	main, .-main
	.section	.text.unlikely
.LCOLDE7:
	.section	.text.startup
.LHOTE7:
	.globl	val1
	.data
	.align 4
	.type	val1, @object
	.size	val1, 4
val1:
	.long	1120403456
	.globl	val2
	.align 4
	.type	val2, @object
	.size	val2, 4
val2:
	.long	1120403456
	.globl	val
	.bss
	.align 8
	.type	val, @object
	.size	val, 8
val:
	.zero	8
	.comm	dump,400,64
	.comm	buffer,8,8
	.comm	colors,4,4
	.comm	stride,4,4
	.comm	ways,4,4
	.globl	linesize
	.data
	.align 4
	.type	linesize, @object
	.size	linesize, 4
linesize:
	.long	16
	.globl	size
	.section	.rodata
	.align 8
	.type	size, @object
	.size	size, 8
size:
	.quad	2048000
	.comm	data_end,8,8
	.comm	data_start,8,8
	.data
	.align 8
	.type	z, @object
	.size	z, 8
z:
	.quad	521288629
	.align 8
	.type	y, @object
	.size	y, 8
y:
	.quad	362436069
	.align 8
	.type	x, @object
	.size	x, 8
x:
	.quad	123456789
	.ident	"GCC: (Ubuntu 4.9.1-16ubuntu6) 4.9.1"
	.section	.note.GNU-stack,"",@progbits

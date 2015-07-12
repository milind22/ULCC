	.file	"infinite_version_ulcc.c"
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
	.align 8
.LC2:
	.string	"failed to remap data region 1\n"
	.section	.text.unlikely
.LCOLDB3:
	.text
.LHOTB3:
	.p2align 4,,15
	.globl	init_buffer
	.type	init_buffer, @function
init_buffer:
.LFB45:
	.cfi_startproc
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	subq	$32, %rsp
	.cfi_def_cfa_offset 48
	movslq	ways(%rip), %rbx
	movq	%fs:40, %rax
	movq	%rax, 24(%rsp)
	xorl	%eax, %eax
	movslq	linesize(%rip), %rax
	imulq	%rax, %rbx
	salq	$14, %rbx
	movq	%rbx, %rdi
	shrq	$20, %rbx
	call	malloc
	movq	%rbx, %rdx
	movq	%rax, buffer(%rip)
	movl	$.LC1, %esi
	xorl	%eax, %eax
	movl	$1, %edi
	call	__printf_chk
	movq	buffer(%rip), %rcx
	testl	$4095, %ecx
	movq	%rcx, %rax
	je	.L3
	andq	$-4096, %rax
	addq	$4096, %rax
.L3:
	movslq	linesize(%rip), %rdx
	movq	%rax, data_start(%rip)
	movq	%rsp, %rdi
	movslq	ways(%rip), %rax
	imulq	%rdx, %rax
	salq	$14, %rax
	addq	%rcx, %rax
	movq	%rax, %rdx
	andq	$-4096, %rdx
	testl	$4095, %eax
	cmovne	%rdx, %rax
	movq	%rax, data_end(%rip)
	call	cc_cacheregn_clr
	movl	color_high(%rip), %edx
	movl	color_low(%rip), %esi
	movl	$1, %ecx
	movq	%rsp, %rdi
	call	cc_cacheregn_set
	movl	$1, %r8d
	movq	%rsp, %rcx
	movl	$1, %edx
	movl	$data_end, %esi
	movl	$data_start, %edi
	call	cc_remap
	testl	%eax, %eax
	js	.L18
	xorl	%edi, %edi
	xorl	%eax, %eax
	call	time
	movl	%eax, %edi
	call	srand
	movq	data_start(%rip), %rbx
	cmpq	data_end(%rip), %rbx
	jae	.L2
	.p2align 4,,10
	.p2align 3
.L13:
	call	rand
	cltd
	addq	$4, %rbx
	shrl	$25, %edx
	addl	%edx, %eax
	andl	$127, %eax
	subl	%edx, %eax
	movl	%eax, -4(%rbx)
	cmpq	%rbx, data_end(%rip)
	ja	.L13
.L2:
	movq	24(%rsp), %rax
	xorq	%fs:40, %rax
	jne	.L19
	addq	$32, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 16
	popq	%rbx
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L18:
	.cfi_restore_state
	movq	stderr(%rip), %rcx
	movl	$30, %edx
	movl	$1, %esi
	movl	$.LC2, %edi
	call	fwrite
	jmp	.L2
.L19:
	call	__stack_chk_fail
	.cfi_endproc
.LFE45:
	.size	init_buffer, .-init_buffer
	.section	.text.unlikely
.LCOLDE3:
	.text
.LHOTE3:
	.section	.text.unlikely
.LCOLDB4:
	.text
.LHOTB4:
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
.L27:
	xorl	%edi, %edi
	testl	%r8d, %r8d
	je	.L27
.L30:
	xorl	%ecx, %ecx
	.p2align 4,,10
	.p2align 3
.L28:
	cmpl	$1, %eax
	movl	$1, %edx
	jbe	.L25
	.p2align 4,,10
	.p2align 3
.L31:
	addl	$1, %edx
	cmpl	%eax, %edx
	jne	.L31
.L25:
	addl	$1, %ecx
	cmpl	%esi, %ecx
	jbe	.L28
	addl	$1, %edi
	cmpl	%r8d, %edi
	jne	.L30
	jmp	.L27
	.cfi_endproc
.LFE46:
	.size	access_pattern, .-access_pattern
	.section	.text.unlikely
.LCOLDE4:
	.text
.LHOTE4:
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC5:
	.string	"argc = %d\n"
.LC6:
	.string	"%ld useconds \n"
.LC7:
	.string	"Usage: ways (4-20) "
	.section	.text.unlikely
.LCOLDB8:
	.section	.text.startup,"ax",@progbits
.LHOTB8:
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
	movl	$.LC5, %esi
	movl	$1, %edi
	call	__printf_chk
	cmpl	$5, %ebx
	je	.L38
	movl	$.LC7, %edi
	call	puts
	xorl	%edi, %edi
	call	exit
.L38:
	movq	8(%rbp), %rdi
	movl	$10, %edx
	xorl	%esi, %esi
	call	strtol
	movq	16(%rbp), %rdi
	movl	$10, %edx
	xorl	%esi, %esi
	movl	%eax, ways(%rip)
	call	strtol
	movq	24(%rbp), %rdi
	movl	$10, %edx
	xorl	%esi, %esi
	movl	%eax, stride(%rip)
	call	strtol
	movq	32(%rbp), %rdi
	movl	$10, %edx
	xorl	%esi, %esi
	movl	%eax, color_low(%rip)
	call	strtol
	xorl	%esi, %esi
	movq	%rsp, %rdi
	movl	%eax, color_high(%rip)
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
	movl	$.LC6, %esi
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
.LCOLDE8:
	.section	.text.startup
.LHOTE8:
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
	.comm	color_high,4,4
	.comm	color_low,4,4
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

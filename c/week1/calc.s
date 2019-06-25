	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 10, 14
	.section	__TEXT,__literal4,4byte_literals
	.p2align	2               ## -- Begin function main
LCPI0_0:
	.long	1258874325              ## float 8971733
LCPI0_1:
	.long	1136401252              ## float 376.213989
	.section	__TEXT,__text,regular,pure_instructions
	.globl	_main
	.p2align	4, 0x90
_main:                                  ## @main
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$32, %rsp
	leaq	L_.str(%rip), %rdi
	movss	LCPI0_0(%rip), %xmm0    ## xmm0 = mem[0],zero,zero,zero
	movss	LCPI0_1(%rip), %xmm1    ## xmm1 = mem[0],zero,zero,zero
	movl	$0, -4(%rbp)
	movss	%xmm1, -8(%rbp)
	movss	%xmm0, -12(%rbp)
	movss	-12(%rbp), %xmm0        ## xmm0 = mem[0],zero,zero,zero
	movd	%xmm0, %eax
	xorl	$2147483648, %eax       ## imm = 0x80000000
	movd	%eax, %xmm0
	divss	-8(%rbp), %xmm0
	movss	%xmm0, -16(%rbp)
	movss	-8(%rbp), %xmm0         ## xmm0 = mem[0],zero,zero,zero
	mulss	-16(%rbp), %xmm0
	addss	-12(%rbp), %xmm0
	movss	%xmm0, -20(%rbp)
	movss	-16(%rbp), %xmm0        ## xmm0 = mem[0],zero,zero,zero
	cvtss2sd	%xmm0, %xmm0
	movss	-20(%rbp), %xmm1        ## xmm1 = mem[0],zero,zero,zero
	cvtss2sd	%xmm1, %xmm1
	movb	$2, %al
	callq	_printf
	xorl	%ecx, %ecx
	movl	%eax, -24(%rbp)         ## 4-byte Spill
	movl	%ecx, %eax
	addq	$32, %rsp
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.section	__TEXT,__cstring,cstring_literals
L_.str:                                 ## @.str
	.asciz	"The value of x was %f and y was %f\n"


.subsections_via_symbols

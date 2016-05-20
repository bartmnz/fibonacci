.intel_syntax noprefix

.globl fib
fib:
	mov	rax,	rdi
	#mov	rax,	[r10]
	call	fibs
fibs:
	cmp	rax, 1


	jbe	exit
	dec	rax
	push	rax
	call	fibs
	xchg	rax, 0[rsp]
	dec	rax
	call	fibs	
	pop	rcx
	add	rax, rcx
#
exit:
	ret

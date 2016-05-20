.intel_syntax noprefix

.format:
	.string "0x%lX%lX%lX\n"

.globl main
main:
	#add rax,	8
	mov rdi,	[rsi+8]
	xor rsi,	rsi
	mov rdx,	10
	call strtol
	mov rdi,	rax
	xor r10,	r10
	xor r11,	r11
	xor r12,	r12 # int a = 0
	
	xor r13,	r13
	xor r14,	r14 # int b = 1
	xor r15,	r15
	add r15,	qword ptr 1
	
1:
	cmp rdi,	0
	jbe done
	# add both together 
	#--store in a a is always less, then swap them
	
	add r12,	r15
	adc r11,	r14
	adc r10,	r13
	
	xchg r12,	r15
	xchg r11,	r14 #move them so a < b
	xchg r10,	r13
	
	sub	rdi,	1
	jmp	1b

done:
	#do some printing here
	# for now put in rax
	mov rdi,	OFFSET .format
	mov rsi,	r10
	mov rcx,	r11
	mov rdx,	r12
	xor eax,	eax
	call 	printf
	#mov rax,	r12
	ret
	
	

exit:
	ret

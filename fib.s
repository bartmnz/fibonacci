.intel_syntax noprefix

.format:
	.string "0x%lX%lX%lX\n"

.globl main
main:
	cmp rdi,	1 	# check arg c is >= 2
	jbe exit		# no arguments given bail out
	
	mov rdi,	[rsi+8]	# move argv[1] to rdi
	xor rsi,	rsi	# zero rsi
	mov rdx,	10	# set base to 10 for strtol
	call strtol		
	mov rdi,	rax	# move the result from strtol into rdx
	
	xor r10,	r10	# three registers for 	
	xor r11,	r11
	xor r12,	r12 	# int a = 0
	
	xor r13,	r13	# three registers for
	xor r14,	r14 	# int b = 1
	xor r15,	r15
	add r15,	qword ptr 1
	
1:
	cmp rdi,	0	# check that theloop counter is > 0
	jbe done		# done with loop and exit
	
	add r12,	r15	# add integers a and b
	adc r11,	r14	# make sure to use the carry bit
	adc r10,	r13
	
	xchg r12,	r15	# swap registers 
	xchg r11,	r14 	# move them so a < b
	xchg r10,	r13
	
	sub	rdi,	1	# decrement the loop counter
	jmp	1b		# loop 1

done:
	mov rdi,	OFFSET .format	
	mov rsi,	r10	# move int a into the registers
	mov rcx,	r12	# for a printf call
	mov rdx,	r11
	xor eax,	eax	# zero out eax
	call 	printf		# call printf
	ret
	
	

exit:
	ret

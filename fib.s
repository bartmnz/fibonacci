.intel_syntax noprefix

.text
.format:
	.string "0x%lX%lX%lX%lX\n"
.error:
	.string "ERROR: useage\n"


.globl main
main:
	cmp rdi,	2 	# check arg c is >= 2
	jne exit		# no arguments given bail out
	
	mov rdi,	[rsi+8]	# move argv[1] to rdi
	#xor rsi,	rsi	# zero rsi
	mov rdx,	10	# set base to 10 for strtol
	call strtol		
	mov rdi,	rax	# move the result from strtol into rdx
	
	xor rbx,	rbx	#zero rbx
	cmp [rsi],	byte ptr 0  # check error code from strol
	cmovne rbx,	rsi	# set error flag if necessary
	cmp rdi,	301	# make sure number is less than 300
	cmovge rbx,	rsi	# set error flag if necessary
	cmp rdi,	0	# make sure number is > 0
	cmovl rbx,	rsi	# set error flag if necessary
	cmp rbx,	0	# check error flag
	jne exit			# had error
	

	xor r8,		r8
	xor r9,		r9	# four registers for 	
	xor r10,	r10
	xor r11,	r11 	# int a = 0
	
	xor r12,	r12
	xor r13,	r13	# four registers for
	xor r14,	r14 	# int b = 1
	xor r15,	r15
	add r15,	qword ptr 1
	
1:
	cmp rdi,	0	# check that theloop counter is > 0
	jle done		# done with loop and exit
	
	
	add r11,	r15	# add integers a and b
	adc r10,	r14	# make sure to use the carry bit
	adc r9,		r13
	adc r8,		r12	
	
	xchg r11,	r15
	xchg r10,	r14	# swap registers 
	xchg r9,	r13 	# move them so a < b
	xchg r8,	r12
	
	sub	rdi,	1	# decrement the loop counter
	jmp	1b		# loop 1

done:
	mov rdi,	OFFSET .format	
	mov rsi,	r8	# move int a into the registers
	mov rdx,	r9
	mov rcx,	r10	# for a printf call
	mov r8,		r11
	xor eax,	eax	# zero out eax
	call 	printf		# call printf
	ret
	
	

exit:
	mov rdi,	OFFSET .error
	xor eax,	eax	# zero out eax
	call printf		# call printf
	ret

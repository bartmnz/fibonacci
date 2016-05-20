CFLAGS+= -O1 -masm=intel -fno-asynchronous-unwind-tables
ASFLAGS+=-W

%.s: %.c
	S(CC) $(CPPFLAGS) $(CFLAGS) -S -o $@ $^
fib: fib.o 
main: main.o fib.o

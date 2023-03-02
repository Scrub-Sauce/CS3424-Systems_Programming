PROGRAMS = assign7
CC = gcc
CFLAGS = 

all: $(PROGRAMS)
tidy:
	rm -f ,* .,* *~ core a.out graphics.ps

scratch: tidy
	rm -f *.o *.a $(PROGRAMS)

assign7.o: assign7.c assign7.h
	$(CC) $(CFLAGS) -c assign7.c
    
assign7: assign7.o
	$(CC) $(CFLAGS) assign7.o -o assign7

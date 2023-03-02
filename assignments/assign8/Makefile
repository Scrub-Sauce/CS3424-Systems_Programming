PROGRAMS = assign8
CC = gcc
CFLAGS = 

all: $(PROGRAMS)
tidy:
	rm -f ,* .,* *~ core a.out graphics.ps

scratch: tidy
	rm -f *.o *.a $(PROGRAMS)

assign8.o: assign8.c
	$(CC) $(CFLAGS) -c assign8.c
    
assign8: assign8.o
	$(CC) $(CFLAGS) assign8.o -o assign8

BASESRC=.
CC=${shell which gcc}
OBJDUMP=$(shell which objdump)

SRC=${BASESRC}/main.c
ASRC=${BASESRC}/asm.S
POCSRC=${BASESRC}/asm.S
OUT=trpl
POCOUT=asm

$(OBJNAME)-objs = $(SRC:.c=.o) $(ASRC:.S=.o)
obj-m := ${OBJNAME}.o

all:
	$(CC) -c -o asm.o asm.S 
	$(OBJDUMP) -d -S asm.o
	$(CC) -c -o main.o main.c
	$(CC) main.o asm.o -no-pie -o $(OUT)

.PHONY: all

clean:
	rm -f asm.o main.o $(OUT)

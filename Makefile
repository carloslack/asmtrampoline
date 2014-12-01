BASESRC=.
ARCH=arch/x86

CC=${shell which gcc}
AS=${shell which as}
LD=${shell which ld}

EXTRA_CFLAGS = -I${BASESRC}  -Wno-strict-prototypes -Werror
ASFLAGS = -statistics -fatal-warnings -size-check=error

SRC=${BASESRC}/main.c
ASRC=${BASESRC}/asm.S
POCSRC=${BASESRC}/asm.S
OUT=test
POCOUT=asmpoc


all:
	${CC} -Wall ${SRC} ${ASRC} -o ${OUT}

#poc:
#	${AS} ${ASFLAGS} ${POCOUT}.S -o ${POCOUT}.o
#	${LD} ${POCOUT}.o -o ${POCOUT}

.PHONY: all

clean:
	rm -f ${OUT} #${POCOUT}

Detour
======

Function trampoline example in Assembly.

Function's entry point is overwritten by jmp'ing to
a new label then stack frame is saved and another jmp
takes place to another location, executing the code.

The exampls is userland code.

Expected output:

---snip---
 $ ./test
    sending[0x8b87008(val1=10):0x8b87018(val1=11, val2=12)]
    hikack[0x8b87008(val1=10):0x8b87018(val1=11, val2=12)]
    got[0x8b87008(val1=110):0x8b87018(val1=111, val2=112)]
    ret=0
---snip---



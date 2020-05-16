#
# trpl.S 64b
# Carlos Carvalho <carloslack at gmail dot com>
#
# Function trampoline (FT) representation in Assembly
#
#       This is what it would look in assembly bytecode of an
#   implementation of Function Trampoline. 
#
#   In C world, ignoring protections:
#       memcpy(<function_address>, <jmp address>, sizeof(jmp address))
#
.data
.text

.extern h_show_value

.globl show_value
.type show_value, @function

# This is the original function where
# prologue is overwritten by jmp <address>
show_value:
    # jmp <different location>
    jmp fixup

    # we'll be back here soon
    movq 8(%rsp), %rdi
    movq 12(%rsp), %rsi
    movq $0, %rax #return value
    leave
    ret

.type fixup, @function
fixup:
    # save stack frame
    pushq %rbp
    movq %rsp, %rbp

    # proceed
    jmp func_detour


.type func_detour, @function
func_detour:

    # Fetch arguments
    movq 8(%rsp), %rbx
    movq 12(%rsp), %rdx
    # push onto stack
    pushq %rdx
    pushq %rbx

    # call hook
    call h_show_value

    addq $4, %rsp

    # load show_value adsress
    leaq show_value, %rcx

    # add offset to skip jmp
    leaq 0x3(%rcx), %rax

    # go back original function
    jmpq *%rax

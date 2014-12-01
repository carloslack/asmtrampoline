#
# Function hijack POC
# Carlos Carvalho - hash


#  This code show how to redirect function's flow.
#  Similar method could be used to hijack
#  kernel functions
#
#   Flow description:
#
#   1 - client calls show_value() (see main.c)
#   2 - first original 3 bytes (prologue) are overwritten
#       by our:
#           jmp label
#       'jmp label' is 3 bytes long just like stack frame saving:
#           pushl %ebp ; movl %esp, %ebp
#   3 - the jmp goes to fixup label from where we make sure
#       to save the current stack frame and then we finally go to
#       destination.
#   4 - In func_detour (our impl) e can then modify
#       the original argument(s) and have to call show_value() again,
#       this time skipping 3 bytes (jmp) , passing our modified argument.
#

.data
.text

.extern h_show_value

.globl show_value
.type show_value, @function
show_value:  # orig function (being hijacked)
    # change flow
    jmp fixup #this is C code memcpy from cr0 rw

    # remaining original code
    movl 8(%esp), %ebx
    movl 12(%esp), %ecx
    movl $0, %eax #return value
    leave
    ret

.type fixup, @function
fixup:
    # save stack frame
    pushl %ebp
    movl %esp, %ebp

    # finally execute our hack
    jmp func_detour


.type func_detour, @function
func_detour:

    # call our hijack function
    movl 8(%esp), %ecx
    movl 12(%esp), %edx
    pushl %edx
    pushl %ecx

    # here is where our hook execute
    call h_show_value

    addl $4, %esp

    # get show_value's address
    leal show_value, %edx

    # skip jmp
    leal 0x3(%edx), %ecx

    # here we go
    # Won't return
    call *%ecx

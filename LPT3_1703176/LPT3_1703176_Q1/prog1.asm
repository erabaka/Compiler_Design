;start -1
.686
.model flat, c
include C:\masm32\include\msvcrt.inc
includelib C:\masm32\lib\msvcrt.lib

.stack 100h
printf PROTO arg1:Ptr Byte, printlist:VARARG
scanf PROTO arg2:Ptr Byte, inputlist:VARARG

.data
output_integer_msg_format byte "%d", 0Ah, 0
output_string_msg_format byte "%s", 0Ah, 0
input_integer_format byte "%d",0

number sdword ?

.code

main proc
    mov ecx, 2
while_loop_:
    cmp ecx, 20
    jge exit_

    mov eax, ecx
    add eax, 3
    push eax
    push ebx
    push ecx
    push edx
    push ebp
    INVOKE printf, ADDR output_integer_msg_format, eax
    pop ebp
    pop edx
    pop ecx
    pop ebx
    pop eax

    add ecx, 3
    jmp while_loop_

exit_:
    ret
main endp
end

        
    

; Equivalent C code:
; int a;
; int b;
; int c;
; int d;
; scan(a);
; scan(b);
; scan(d);
; c = a + b + 100 + d;
; print(c);

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
    push eax
    push ebx
    push ecx
    push edx
    push ebp
    INVOKE scanf, ADDR input_integer_format, ADDR number
    pop ebp
    pop edx
    pop ecx
    pop ebx
    pop eax

    mov eax, number

    push eax
    push ebx
    push ecx
    push edx
    push ebp
    INVOKE scanf, ADDR input_integer_format, ADDR number
    pop ebp
    pop edx
    pop ecx
    pop ebx
    pop eax

    add eax, number

    push eax
    push ebx
    push ecx
    push edx
    push ebp
    INVOKE scanf, ADDR input_integer_format, ADDR number
    pop ebp
    pop edx
    pop ecx
    pop ebx
    pop eax

    add eax, number
    mov ebx, 100
    add eax, ebx
    INVOKE printf, ADDR output_integer_msg_format, eax
    ret
    main endp
    end

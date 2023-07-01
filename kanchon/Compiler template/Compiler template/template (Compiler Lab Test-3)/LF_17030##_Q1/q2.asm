.686
.model flat, c
include C:\masm32\include\msvcrt.inc
includelib C:\masm32\lib\msvcrt.lib

.stack 100h
printf PROTO arg1:Ptr Byte, printlist:VARARG
scanf PROTO arg2:Ptr Byte, inputlist:VARARG

.data
output_a byte "a = %d", 0AH, 0
output_count byte "count = %d", 0AH, 0



.code
main proc

    mov EAX, 10
    mov EBX, 0

    mov EAX, 0

    FOR_LOOP:
        push EAX
        invoke printf , addr output_a , EAX
        invoke printf , addr output_count , EBX
        pop EAX

        cmp EAX, 10
        JGE LOOP_EXIT

        cmp EAX, 5
        JNE ELSEIF_STAT
        add EBX, 1
        jmp ENDIF_STAT

        ELSEIF_STAT:
            cmp EAX, 7
            jl ELSE_STATEMENT
            mov EBX, EAX
            add EAX, 1
            jmp ENDIF_STAT

        ELSE_STATEMENT:
            mov EBX, EAX
            sub EAX, 1

        ENDIF_STAT:
            add EAX, 1
            jmp FOR_LOOP


    LOOP_EXIT:
    


    ret
main endp
end
.686
.model flat, c
include C:\masm32\include\msvcrt.inc
includelib C:\masm32\lib\msvcrt.lib

.stack 100h
printf PROTO arg1:Ptr Byte, printlist:VARARG
scanf PROTO arg2:Ptr Byte, inputlist:VARARG

.data
input_integer_format byte "%d",0
output_msg_format byte "%s",0
output_integer_msg_format byte "%d", 0Ah, 0


crnt byte "Current = ", 0AH, 0
reg_print byte "Resistance = ", 0AH, 0
cu sdword ?
reg sdword ?
result byte "Voltage = %d", 0


.code
main proc
    
    invoke printf , addr crnt , 0
    invoke scanf , addr input_integer_format , addr cu
    invoke printf , addr reg_print , 0
    invoke scanf , addr input_integer_format , addr reg
    mov EAX , cu 
    mov EBX, reg
    ;mul EBX
    imul EAX, EBX
    push EAX 
    invoke printf , addr result , EAX
    pop EAX
    invoke printf , addr result , EAX
    

    ret
main endp
end
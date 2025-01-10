.686
.model flat
public _max_abs 
.code 
_max_abs PROC

max_absolute:
    push ebp
    mov ebp, esp
    push ebx
    push esi

    mov ecx, [ebp + 12]   ; N
    mov ebx, [ebp + 8]    ; adres tabl
    xor eax, eax          

    test ecx, ecx
    jz done               ; n=0

    xor esi, esi

loop_s:
    mov edx, [ebx + esi * 4]
    test edx, edx
    jns check_max            ; >=0

    neg edx                  ; ujemny

check_max:
    cmp eax, edx
    jge next                 ; eax >= edx

    mov eax, edx

next:
    inc esi
    loop loop_s

done:
    pop esi
    pop ebx
    pop ebp
    ret

_max_abs ENDP 
END 
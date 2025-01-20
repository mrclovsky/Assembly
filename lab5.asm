.686
.model flat

public _srednia_wazona

.code
_srednia_wazona PROC
    push ebp
    mov ebp, esp
    push esi
    push edi
    finit 

    mov esi, [ebp + 8]  ; dana
    mov edi, [ebp + 12] ; waga
    mov ecx, [ebp + 16] ; n

    xor eax, eax
    fldz
    fldz

suma:
    fld dword ptr [esi + 4 * eax]
    fld dword ptr [edi + 4 * eax]
    fmulp st(1), st(0)
    fadd st(2), st(0)
    fstp st(0)

    inc eax      
    loop suma

    mov ecx, [ebp + 16] ; n
    xor eax, eax

wagi:
    fld dword ptr [edi + 4 * eax]
    fadd st(1), st(0)
    fstp st(0)
    inc eax
    loop wagi

;dzielenie 
    fdiv st(1), st(0)
    fxch st(1)
    ;fstp st(0)
    ;fadd st(0), st(1)

    pop edi
    pop esi
    pop ebp
    ret
_srednia_wazona ENDP
END
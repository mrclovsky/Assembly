.686
.model flat
extern __write : PROC
extern __read : PROC
extern _ExitProcess@4 : PROC
public _main

.data
obszar db 36 dup (?)
dziesiec dd 10
szesnascie dd 16
znaki db 12 dup (?)
wynik db 12 dup (?)
N db 1 dup (?)
Az dd ?
Q dd ?
tekst_N db "Podaj N: ", 0
tekst_Az db "Podaj A0: ", 0
tekst_Q db "Podaj Q: ", 0
tekst_hex db "Hex", 0
zamkniecie_hex db ")", 0

.code

wyswietl_tekst PROC
    push ebx
    push esi
    mov esi, 0
wyswietl_tekst_petla:
    mov al, [ebx + esi]
    cmp al, 0
    je wyswietl_tekst_koniec
    mov [znaki + esi], al
    inc esi
    jmp wyswietl_tekst_petla
wyswietl_tekst_koniec:
    mov byte ptr [znaki + esi], 0Ah
    push esi
    push OFFSET znaki
    push 1
    call __write
    add esp, 12
    pop esi
    pop ebx
    ret
wyswietl_tekst ENDP

wczytaj_liczbe PROC
    push ebx
    push esi
    push edi
    push ebp
    push 12
    push OFFSET obszar
    push 0
    call __read
    add esp, 12
    xor eax, eax
    mov ebx, OFFSET obszar
pobieraj_znaki:
    mov cl, [ebx]
    inc ebx
    cmp cl, 10
    je byl_enter
    sub cl, 30H
    movzx ecx, cl
    mul dziesiec
    add eax, ecx
    jmp pobieraj_znaki
byl_enter:
    pop ebp
    pop edi
    pop esi
    pop ebx
    ret
wczytaj_liczbe ENDP

wyswietl_wynik PROC
    pusha
    mov esi, 10
    mov ebx, 10
    mov edi, eax  ; Zachowaj aktualn¹ wartoœæ eax dla konwersji hex

; Konwersja dziesiêtna
konwersja:
    xor edx, edx
    div ebx
    add dl, 30h
    mov wynik[esi], dl
    dec esi
    cmp eax, 0
    jne konwersja

wypeln:
    or esi, esi
    jz wyswietl
    mov byte ptr wynik[esi], 20h
    dec esi
    jmp wypeln

wyswietl:
    mov byte ptr wynik[11], 0Ah
    push 12
    push OFFSET wynik
    push 1
    call __write
    add esp, 12

    ; Wyœwietlenie szesnastkowe
    mov ebx, OFFSET tekst_hex
    call wyswietl_tekst

    mov eax, edi  ; Przywrócenie wartoœci z edi do eax
    mov esi, 10
    mov ebx, szesnascie
konwersja_hex:
    xor edx, edx
    div ebx
    cmp dl, 9
    jbe cyfr_hex
    add dl, 07h ; przesuniêcie dla liter A-F
cyfr_hex:
    add dl, 30h
    mov wynik[esi], dl
    dec esi
    cmp eax, 0
    jne konwersja_hex

wypeln_hex:
    mov byte ptr wynik[esi], '0'  ; Dodaj 0 przed liter¹
    dec esi
    mov byte ptr wynik[esi], 'x'  ; Dodaj x
    dec esi
    mov byte ptr wynik[esi], '0'  ; Dodaj 0 przed x
    dec esi

wyswietl_hex:
    mov byte ptr wynik[11], 0Ah
    push 12
    push OFFSET wynik
    push 1
    call __write
    add esp, 12

    popa
    ret
wyswietl_wynik ENDP

oblicz_ciag PROC
    pusha
    xor ecx, ecx
    movzx ecx, N
    mov eax, Az
petla:
    call wyswietl_wynik
    mul Q
    loop petla
    popa
    ret
oblicz_ciag ENDP

_main PROC
    mov ebx, OFFSET tekst_N
    call wyswietl_tekst
    call wczytaj_liczbe
    mov N, al

    mov ebx, OFFSET tekst_Az
    call wyswietl_tekst
    call wczytaj_liczbe
    mov Az, eax

    mov ebx, OFFSET tekst_Q
    call wyswietl_tekst
    call wczytaj_liczbe
    mov Q, eax

    call oblicz_ciag

    push 0
    call _ExitProcess@4
_main ENDP

END

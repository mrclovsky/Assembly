.686
.model flat
extern _ExitProcess@4 : PROC
extern __write : PROC
extern __read : PROC
extern _MessageBoxA@16 : PROC
public _main

.data
tekst_pocz db 10, 'Prosze napisac jakis tekst ', 10, 'i nacisac Enter', 0
magazyn db 80 dup (0) ; Bufor na tekst wprowadzony
wynik db 80 dup (?), 0
tytul db 'Wynik', 0 
liczba_znakow dd 0

.code
_main PROC
; Wyœwietlenie tekstu informacyjnego
mov ecx, (OFFSET wynik) - (OFFSET tekst_pocz) 
push ecx
push OFFSET tekst_pocz
push 1 ; Urz¹dzenie ekran (1)
call __write
add esp, 8 ; Usuniêcie parametrów ze stosu

; Wczytanie tekstu
push 80 ; Maksymalna liczba znaków
push OFFSET magazyn
push 0 ; Urz¹dzenie klawiatura (0)
call __read
add esp, 12 ; Usuniêcie parametrów ze stosu
mov liczba_znakow, eax

; Przetwarzanie tekstu
mov ecx, eax
xor ebx, ebx

przetworz:
mov dl, magazyn[ebx]
cmp dl, 0Dh
je pomin_znak

cmp dl, 'a'
jb nie_male
cmp dl, 'z'
ja nie_male
sub dl, 20H
jmp zapisz

nie_male:
cmp dl, 'A'
jb zamien_na_gwiazdke
cmp dl, 'Z'
ja zamien_na_gwiazdke
add dl, 20H
jmp zapisz

zamien_na_gwiazdke:
mov dl, '*'

zapisz:
mov wynik[ebx], dl
inc ebx
loop przetworz
jmp koniec_petli

pomin_znak:
inc ebx
loop przetworz

koniec_petli:

; MessageBox
push 0
push OFFSET tytul
push OFFSET wynik
push 0
call _MessageBoxA@16

push 0
call _ExitProcess@4 ; Zakoñczenie programu
_main ENDP
END



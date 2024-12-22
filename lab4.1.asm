.686 
.model flat  

public _szukaj_max  

.code  
_szukaj_max PROC
push  ebp  ; zapisanie zawartoœci EBP na stosie  
mov  ebp, esp ; kopiowanie zawartoœci ESP do EBP

mov  eax, [ebp+8] ; liczba x 
cmp  eax, [ebp+12] ; porownanie liczb x i y 
jge  x_wieksza  ; skok, gdy x >= y 

; przypadek x < y 
mov  eax, [ebp+12] ; liczba y 
cmp  eax, [ebp+16] ; porownanie liczb y i z
jge  y_wieksza  ; skok, gdy y >= z 

; przypadek y < z 
; zatem z jest liczb¹ najwieksz¹ 
wpisz_z:
mov eax, [ebp+16] ; liczba z 
cmp  eax, [ebp+20]
jge zakoncz

wpisz_q:
mov eax, [ebp+20] ; liczba q

zakoncz:
	pop  ebp
	ret  
	
x_wieksza:
	cmp  eax, [ebp+16] ; porownanie x i z 
	jge  x_wieksza2  ; skok, gdy x >= z 
	;jmp  wpisz_z 

y_wieksza: 
	cmp  eax, [ebp+20] ; porownanie y i q 
	jge  zakoncz ; szkok, gdy y>q
	jmp  wpisz_q 

x_wieksza2:
	cmp  eax, [ebp+20] ; porownanie x i q 
	jge  zakoncz  ; skok, gdy x >= q
	jmp  wpisz_q 

_szukaj_max ENDP
			END 
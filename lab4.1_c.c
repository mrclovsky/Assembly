#include <stdio.h> 
int szukaj4_max (int a, int b, int c, int d);

int main() 
{ 
	int x, y, z, q, wynik;
	printf("\nProsze podac cztery liczby calkowite ze znakiem: ");
	scanf_s("%d  %d  %d  %d", &x, &y, &z, &q, 32); wynik = szukaj_max(x, y, z, q);
	printf("\nSposrod podanych liczb %d, %d, %d, %d \
	liczba %d jest najwieksza\n", x,y,z,q, wynik);
	return 0;
} 
#include <stdio.h>

unsigned int max_abs(int tabl[], unsigned int n);

int main() {
    int tablica[] = { -15, -3456, 880, -1, 2297, -12381, -1900, 31, -8000, 5, -46, 8001 };
    unsigned int n = sizeof(tablica) / sizeof(tablica[0]);
    unsigned int max = max_abs(tablica, n);

    printf("Najwieksza wartosc bezwzgledna w tablicy: %u\n", max);
    return 0;
}


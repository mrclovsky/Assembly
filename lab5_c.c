#include <stdio.h>

float srednia_wazona(float tablica_dane[], float tablica_wagi[], unsigned int n);

int main() {
    float tablica_dane[5] = { 2.0f, 3.0f, 4.0f};
    float tablica_wagi[5] = { 4.0f, 3.0f, 2.0f};
    unsigned int n = 3;

    float wynik = srednia_wazona(tablica_dane, tablica_wagi, n);
    printf("Srednia: %f\n", wynik);

    return 0;
}

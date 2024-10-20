#define _CRT_SECURE_NO_WARNINGS
#include <stdio.h>

int mass[100];

int main() {

    int n;

    printf("Enter the size of the array: ");
    scanf("%d", &n);

    printf("Enter the array elements:\n");
    for (int i = 0; i < n; i++) {
        scanf("%d", &mass[i]);
    }

    int newElement, location;
    for (int i = 1; i < n; i++) {
        newElement = mass[i];
        location = i - 1;
        while (location >= 0 && mass[location] > newElement) {
            mass[location + 1] = mass[location];
            location = location - 1;
        }
        mass[location + 1] = newElement;
    }

    printf("Sorted array:\n");
    for (int i = 0; i < n; i++) {
        printf("%d ", mass[i]);
    }

    return 0;
}
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

    int i = 1;
    int newElement, location;

start_sort:
    if (i >= n) goto end_sort;

    newElement = mass[i];
    location = i - 1;

check_condition:
    if (location < 0) goto insert_element;
    if (mass[location] <= newElement) goto insert_element;

    mass[location + 1] = mass[location];
    location--;
    goto check_condition;

insert_element:
    mass[location + 1] = newElement;
    i++;
    goto start_sort;

end_sort:

    printf("Sorted array:\n");
    for (int i = 0; i < n; i++) {
        printf("%d ", mass[i]);
    }

    return 0;
}
#include <stdio.h>
#include <easy.h>

int main() {
    double a1 = 1.0;
    int a2 = 1;
    float a3 = 0.785398f;
    double a4 = 10.0;

    int result = access2(a1, a2, a3, a4);

    if (result) {
        printf("Access granted\n");
    }
    else {
        printf("Access denied\n");
    }

    return 0;
}
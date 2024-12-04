#include <stdio.h>
#include <medium.h>

using namespace var2;


int main() {

    var2::S rdx = { 5, 2, 1.5f };
    float xmm0 = 10.0f;
    double xmm2 = -2.0;
    var2::access2(xmm0, rdx, xmm2);

    return 0;
}
#include <math.h>

extern "C" int access2(double a1, int a2, float a3, double a4)
{
    double v4 = pow(a1, (double)a2);
    double v5 = sin(a3);
    double v6 = log10(a4);
    return (v5 + v6 > v4) ? 1 : 0;
}
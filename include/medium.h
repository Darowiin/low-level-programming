#include <stdio.h>
using namespace std;

namespace var2 {
    struct S {
        int field0;
        int field1;
        float field2;

        void check(bool res) {
            if (res)
                puts("Access granted");
            else
                puts("Access denied");
        }
    };

    extern "C" void access2(float xmm0, S& rdx, double xmm2) {
        bool res = false;

        float condition1 = xmm0 + (rdx.field1 * rdx.field2);
        float threshold = (3.0f * rdx.field2) + rdx.field0 - 1.0f;

        if (condition1 > threshold) {
            if (xmm2 < -1.0) {
                res = true;
            }
        }
        rdx.check(res);
    }
}
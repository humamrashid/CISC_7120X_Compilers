/* An implementation of the Trabb Pardo-Knuth algorithm in ANSI C. */

#include <stdlib.h>
#include <stdio.h>
#include <math.h>
double func(double n) {
    return sqrt(fabs(n)) + (5.0 * n);
}
int main(void)
{
    int e;
    double S[11];
    printf("Enter 11 numbers:\n");
    for (e = 0; e < 11; e++)
        scanf("%lf", &S[e]);
    printf("Result:\n");
    for (e = 10; e >= 0; e--) {
        double val = func(S[e]);
        (val > 500.0)
            ? printf("f(%f) = %s\n", S[e], "caused overflow!")
            : printf("f(%f) = %f\n", S[e], val);
    }
    return EXIT_SUCCESS;
}

/* EOF. */

#include<stdio.h>
#include<stdlib.h>
#include<math.h>
#include "compute_pi.h"

#define PI_M 3.141592653589793

int main(int argc, char *argv[])
{
    unsigned int N = atoi(argv[1]);
    double tmp ;
    FILE *output;
    output = fopen("error.csv", "a");
    /*baseline*/
    tmp = compute_pi_baseline(N);
    fprintf(output, "%s,%u,%lf\n", "baseline" , N, fabs(PI_M - tmp));
    /*openmp with 2 threads*/
    tmp = compute_pi_omp(N,2);
    fprintf(output, "%s,%u,%lf\n", "omp2" , N, fabs(PI_M - tmp));

    /*openmp with 4 threads*/
    tmp = compute_pi_omp(N,4);
    fprintf(output, "%s,%u,%lf\n", "omp4" , N, fabs(PI_M - tmp));

    /*avx*/
    tmp = compute_pi_avx(N);
    fprintf(output, "%s,%u,%lf\n", "avx" , N, fabs(PI_M - tmp));

    /*avx_unroll*/
    tmp = compute_pi_avx_unroll(N);
    fprintf(output, "%s,%u,%lf\n", "avxunroll" , N, fabs(PI_M - tmp));

    fclose(output);
    return 0 ;
}

#include<stdio.h>
#include<stdlib.h>
#include "time_measure.h"
#include "compute_pi.h"
int main(int argc, char *argv[])
{
    unsigned int N = atoi(argv[1]);
    double duration = 0 ;
    struct timespec start, end;
    clock_gettime(CLOCK_ID, &start);
#ifdef baseline
    double pi = compute_pi_baseline(N);
#elif omp2
    double pi = compute_pi_omp(N, 2);
#elif omp4
    double pi = compute_pi_omp(N, 4);
#elif avx
    double pi = compute_pi_avx(N);
#elif avxunroll
    double pi = compute_pi_avx_unroll(N);
#else
    double pi = compute_pi_baseline(N);
#endif
    clock_gettime(CLOCK_ID, &end);
    duration = diff_in_second(start, end);
    printf("pi = %lf\n" , pi);
    printf("duration = %lf\n" , duration);
    return 0 ;
}

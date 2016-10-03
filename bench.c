#include<stdio.h>
#include<stdlib.h>
#include "time_measure.h"
#include "compute_pi.h"


int main(int argc, char *argv[])
{
    unsigned int N = atoi(argv[1]);
    double duration = 0 ;
    struct timespec start, end;
    FILE *output;
    output = fopen("output.csv", "a");
    /*baseline*/
    clock_gettime(CLOCK_ID, &start);
    compute_pi_baseline(N);
    clock_gettime(CLOCK_ID, &end);
    duration = diff_in_second(start, end);
    fprintf(output, "%s,%u,%lf\n", "baseline" , N, duration);
    /*openmp with 2 threads*/
    clock_gettime(CLOCK_ID, &start);
    compute_pi_omp(N, 2);
    clock_gettime(CLOCK_ID, &end);
    duration = diff_in_second(start, end);
    fprintf(output, "%s,%u,%lf\n", "omp2" , N, duration);
    /*openmp with 4 threads*/
    clock_gettime(CLOCK_ID, &start);
    compute_pi_omp(N, 4);
    clock_gettime(CLOCK_ID, &end);
    duration = diff_in_second(start, end);
    fprintf(output, "%s,%u,%lf\n", "omp4" , N, duration);
    /*avx*/
    clock_gettime(CLOCK_ID, &start);
    compute_pi_avx(N);
    clock_gettime(CLOCK_ID, &end);
    duration = diff_in_second(start, end);
    fprintf(output, "%s,%u,%lf\n", "avx" , N, duration);
    /*avx_unroll*/
    clock_gettime(CLOCK_ID, &start);
    compute_pi_avx_unroll(N);
    clock_gettime(CLOCK_ID, &end);
    duration = diff_in_second(start, end);
    fprintf(output, "%s,%u,%lf\n", "avxunroll" , N, duration);
    fclose(output);
    return 0 ;
}

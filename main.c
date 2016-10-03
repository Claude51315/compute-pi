#include<stdio.h>
#include<stdlib.h>
#include "time_measure.h"
#include "compute_pi.h"
int main(int argc, char *argv[]){
    unsigned int N = atoi(argv[1]);
    double duration = 0 ; 
    struct timespec start, end; 
    clock_gettime(CLOCK_ID, &start);
    double pi = compute_pi_baseline(N);
    clock_gettime(CLOCK_ID, &end); 
    duration = diff_in_second(start, end);
    printf("pi = %lf\n" , pi);
    printf("duration = %lf\n" , duration);
    return 0 ; 
}

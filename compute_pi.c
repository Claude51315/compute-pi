#include "compute_pi.h"
#include <omp.h>
double compute_pi_baseline(size_t n)
{
    double dx = 1.0 / n ; 
    double pi = 0;
    for(size_t i = 0 ; i < n ;i ++)
    {
        double x = (double)i / n ; 
        pi += dx / (1.0 + x * x);
    }
    return pi * 4.0;
}
double compute_pi_omp(size_t n, int thread_num)
{
    double dx = 1.0 / n ; 
    double pi = 0;
#pragma omp parallel num_threads(thread_num)
{
    double x ; 
    #pragma omp for private(x) reduction(+:pi)
    for(size_t i = 0 ; i < n ;i ++)
    {
        x = (double)i / n ; 
        pi += dx / (1.0 + x * x);
    }
}
    return pi * 4.0;
}

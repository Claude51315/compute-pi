#include "compute_pi.h"
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

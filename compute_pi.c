#include "compute_pi.h"
#include <immintrin.h>
#include <omp.h>
double compute_pi_baseline(size_t n)
{
    double dx = 1.0 / n ;
    double pi = 0;
    for(size_t i = 0 ; i < n ; i ++) {
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
        for(size_t i = 0 ; i < n ; i ++) {
            x = (double)i / n ;
            pi += dx / (1.0 + x * x);
        }
    }
    return pi * 4.0;
}
double compute_pi_avx(size_t n)
{
    double pi = 0.0;
    double dt = 1.0 / n;
    register __m256d ymm0, ymm1, ymm2, ymm3, ymm4;
    ymm0 = _mm256_set1_pd(1.0);
    ymm1 = _mm256_set1_pd(dt);
    ymm2 = _mm256_set_pd(dt * 3, dt * 2, dt * 1, 0.0);
    ymm4 = _mm256_setzero_pd();             // sum of pi

    for (int i = 0; i <= n - 4; i += 4) {
        ymm3 = _mm256_set1_pd(i * dt);      // i*dt, i*dt, i*dt, i*dt
        ymm3 = _mm256_add_pd(ymm3, ymm2);   // x = i*dt+3*dt, i*dt+2*dt, i*dt+dt, i*dt+0.0
        ymm3 = _mm256_mul_pd(ymm3, ymm3);   // x^2 = (i*dt+3*dt)^2, (i*dt+2*dt)^2, ...
        ymm3 = _mm256_add_pd(ymm0, ymm3);   // 1+x^2 = 1+(i*dt+3*dt)^2, 1+(i*dt+2*dt)^2, ...
        ymm3 = _mm256_div_pd(ymm1, ymm3);   // dt/(1+x^2)
        ymm4 = _mm256_add_pd(ymm4, ymm3);   // pi += dt/(1+x^2)
    }
    double tmp[4] __attribute__((aligned(32)));
    _mm256_store_pd(tmp, ymm4);             // move packed float64 values to  256-bit aligned memory location
    pi += tmp[0] + tmp[1] + tmp[2] + tmp[3];
    return pi * 4.0;

}

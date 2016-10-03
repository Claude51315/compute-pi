#include<stdlib.h>
double compute_pi_baseline(size_t n);
double compute_pi_omp(size_t n, int thread_num);
double compute_pi_avx(size_t n);
double compute_pi_avx_unroll(size_t n);

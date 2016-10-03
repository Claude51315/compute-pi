CC=gcc
CFLAGS= -g -O0 -Wall -std=gnu99 -fopenmp -mavx 
.phony: clean astyle

N=1000000000

EXECUTABLES=pi_baseline \
			pi_omp2 \
			pi_omp4 \
			pi_avx \
			pi_avx_unroll \
			bench \
			cal_error


all: ${EXECUTABLES}
pi_baseline: 
	${CC} ${CFLAGS} -Dbaseline compute_pi.c time_measure.c main.c -o pi_baseline
pi_omp2:
	${CC} ${CFLAGS} -Domp2 compute_pi.c time_measure.c main.c -o pi_omp2
pi_omp4:
	${CC} ${CFLAGS} -Domp4 compute_pi.c time_measure.c main.c -o pi_omp4
pi_avx:
	${CC} ${CFLAGS} -Davx compute_pi.c time_measure.c main.c -o pi_avx
pi_avx_unroll:
	${CC} ${CFLAGS} -Davxunroll compute_pi.c time_measure.c main.c -o pi_avx_unroll
bench: bench.c
	${CC} ${CFLAGS} compute_pi.c time_measure.c bench.c -o bench
cal_error: cal_error.c
	${CC} ${CFLAGS} compute_pi.c  cal_error.c -o cal_error

run: bench cal_error
	for i in `seq 1600 400 1600000`; do \
		./bench $$i; \
		./cal_error $$i; \
	done
#plot using R
plot: run
	Rscript plot.R
	Rscript error.R

clean:
	-rm ${EXECUTABLES}
	-rm output.csv error.csv plot.png
astyle:
	astyle --style=kr --indent=spaces=4 --indent-switches --suffix=none *.c *.h

CC=gcc
CFLAGS= -g -O0 -Wall -std=gnu99 -fopenmp 
.phony: clean astyle

N=1000000000

EXECUTABLES=pi_baseline \
			pi_omp2 \
			pi_omp4 \
			bench


all: ${EXECUTABLES}
pi_baseline: 
	${CC} ${CFLAGS} -Dbaseline compute_pi.c time_measure.c main.c -o pi_baseline
pi_omp2:
	${CC} ${CFLAGS} -Domp2 compute_pi.c time_measure.c main.c -o pi_omp2
pi_omp4:
	${CC} ${CFLAGS} -Domp4 compute_pi.c time_measure.c main.c -o pi_omp4
bench: bench.c
	${CC} ${CFLAGS} compute_pi.c time_measure.c bench.c -o bench

run: ${EXECUTABLES}
	./bench 1000000
	./bench 10000000
	./bench 100000000
	./bench 1000000000
#plot using R
plot: run
	Rscript plot.R

clean:
	-rm ${EXECUTABLES}
	-rm *.csv *.png
astyle:
	astyle --style=kr --indent=spaces=4 --indent-switches --suffix=none *.c *.h

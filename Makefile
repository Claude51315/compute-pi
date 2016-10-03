CC=gcc
CFLAGS= -g -O0 -Wall -std=gnu99 -fopenmp 
.phony: clean astyle

N=1000000000

EXECUTABLES=pi_baseline \
			pi_omp2 \
			pi_omp4


all: ${EXECUTABLES}
pi_baseline: 
	${CC} ${CFLAGS} -Dbaseline compute_pi.c time_measure.c main.c -o pi_baseline
pi_omp2:
	${CC} ${CFLAGS} -Domp2 compute_pi.c time_measure.c main.c -o pi_omp2
pi_omp4:
	${CC} ${CFLAGS} -Domp4 compute_pi.c time_measure.c main.c -o pi_omp4


run: ${EXECUTABLES}
	perf stat --repeat 10 ./pi_baseline ${N}
	perf stat --repeat 10 ./pi_omp2 ${N}
	perf stat --repeat 10 ./pi_omp4 ${N}

clean:
	-rm ${EXECUTABLES}
astyle:
	astyle --style=kr --indent=spaces=4 --indent-switches --suffix=none *.c *.h

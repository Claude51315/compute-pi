CC=gcc
CFLAGS= -g
.phony: clean



all:
	${CC} ${CFLAGS} compute_pi.c time_measure.c main.c -o compute_pi
test:
	time ./compute_pi 10000
	time ./compute_pi 100000
	time ./compute_pi 1000000

clean:
	-rm compute_pi

CC              =       icc
CFLAGS          =      -openmp -O3 -vec-report=3
FC              =       ifort
FFLAGS          =      -align array64byte -openmp -O3 -vec-report=3
MICDIR          =      /home/sdmphi

all: flopsNoThreading flopsSimpleThreading flopsSimpleThreadingGeneric flopsOffload memBW

flopsNoThreading: flopsNoThreading.c
	$(CC) $(CFLAGS) -mmic flopsNoThreading.c -o flopsNoThreading_xphi

flopsSimpleThreading: flopsSimpleThreading.c
	$(CC) $(CFLAGS) -mmic flopsSimpleThreading.c -o flopsSimpleThreading_xphi	

flopsSimpleThreadingGeneric: flopsSimpleThreadingGeneric.c
	$(CC) $(CFLAGS) -mmic flopsSimpleThreadingGeneric.c -o flopsSimpleThreadingGeneric_xphi	

flopsOffload: flopsOffload.c
	$(CC) $(CFLAGS) flopsOffload.c -o flopsOffload_xeon

memBW: memBW.c
	$(CC) $(CFLAGS) -mmic memBW.c -o memBW_xphi

miccopy: 
	scp *_xphi sdmphi@mic0:$(MICDIR)

clean: 
	rm -f ./*_xphi
	rm -f ./*_xeon
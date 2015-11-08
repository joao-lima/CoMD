all:
	+make -C src-omp-task
	+make -C src-omp-task-deps
	+make -C src-openmp
	+make -C src-serial

clean:
	+make -C src-omp-task clean
	+make -C src-omp-task-deps clean
	+make -C src-openmp clean
	+make -C src-serial clean


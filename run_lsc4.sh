#!/bin/bash

# Preparando
source /opt/gcc/gcc.env 
source /opt/kaapi/kaapi.env

# Serial
echo Compilando src-serial...
cd src-serial
rm *.o
make
cd ../bin
echo Executando src-serial...
for ((i=0;i<100;i++)) do ./CoMD-serial | grep total  | sed -n '2p' | awk '{print $3}'; done > serial.out

# openmp for
echo Compilando src-openmp...
cd ../src-openmp
rm *.o
make
cd ../bin
echo Executando src-openmp...
for ((i=1;i<=8;i++))
    do echo $i threads
    export OMP_NUM_THREADS=$i
    for ((j=0;j<100;j++)) do komp-run ./CoMD-openmp | grep total  | sed -n '2p' | awk '{print $3}'; done > omp_for_$i.out
    done

# openmp task
echo Compilando src-omp-task...
cd ../src-omp-task
rm *.o
make
cd ../bin
echo Executando src-omp-task...
for ((i=1;i<=8;i++))
    do echo $i threads
    export OMP_NUM_THREADS=$i
    for ((j=0;j<100;j++)) do komp-run ./CoMD-openmp | grep total  | sed -n '2p' | awk '{print $3}'; done > omp_task_$i.out
    done

# openmp task deps
echo Compilando src-omp-task-deps...
cd ../src-omp-task-deps
rm *.o
make
cd ../bin
echo Executando src-omp-task-deps...
for ((i=1;i<=8;i++))
    do echo $i threads
    export OMP_NUM_THREADS=$i
    for ((j=0;j<100;j++)) do komp-run ./CoMD-openmp | grep total  | sed -n '2p' | awk '{print $3}'; done > omp_task_deps_$i.out
    done

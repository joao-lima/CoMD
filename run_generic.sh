#!/bin/bash

echo Requisitos necessários
echo - gcc \>\= 5.2.0
echo Encontrados no sistema
#echo - gcc `{gcc --version | grep gcc | awk '{print $4}'}`
echo $(gcc -v)

#dorun=1
outdir=$HOME/res

comd_exec(){
    prog=$1
    n=$2
    threads=$3
    niter=$4
    ver=$(date +%s)
    out="$outdir/${prog}-${n}-${threads}-${ver}.log"

    echo "OMP_NUM_THREADS=$threads komp-run ./$prog -x $n -y $n -z $n >> $out"
    if [ ! -z "$dorun" ]
    then
        for i in $(seq 1 $niter)
        do
                OMP_NUM_THREADS=$threads komp-run ./$prog -x $n -y $n -z $n >> $out
        done
    fi
}

size=80
niter=30
ncpu=48
comd_exec "CoMD-serial" $size 1 5
for th in $(seq $ncpu -2 1)
do
    comd_exec "CoMD-openmp" $size $th $niter
done
for th in $(seq $ncpu -2 1)
do
    comd_exec "CoMD-omp-task" $size $th $niter
done
for th in $(seq $ncpu -2 1)
do
    comd_exec "CoMD-omp-task-deps" $size $th $niter 
done

exit 0

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
    for ((j=0;j<100;j++)) do ./CoMD-openmp | grep total  | sed -n '2p' | awk '{print $3}'; done > omp_for_$i.out
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
    for ((j=0;j<100;j++)) do ./CoMD-openmp | grep total  | sed -n '2p' | awk '{print $3}'; done > omp_task_$i.out
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
    for ((j=0;j<100;j++)) do ./CoMD-openmp | grep total  | sed -n '2p' | awk '{print $3}'; done > omp_task_deps_$i.out
    done

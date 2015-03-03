#!/bin/bash 
STR="Hello World" 
echo $STR
date
OMPON=0
fileID="001"
DCYLDP=5

if which perf >/dev/null; then
    statisticInit="perf stat -o stats/resultsInit$fileID.txt"
    statisticLoop="perf stat -o stats/resultsLoop$fileID.txt"
else
    statisticInit="time"
    statisticLoop="time"
fi

echo $statisticInit
echo $statisticLoop
echo $OMPON

mkdir stats

if [ "$OMPON" = 1 ]; then
    echo OMP mode on
    NODE_NAME=`uname -n` # e.g. `node37.service`

    # create hostfile
    echo "$NODE_NAME slots=4" > myhostfile

    # create rankfile
    echo "rank 0=$NODE_NAME slot=0:0-7" > myrankfile
    echo "rank 1=$NODE_NAME slot=0:8-15" >> myrankfile
    echo "rank 2=$NODE_NAME slot=1:0-7" >> myrankfile
    echo "rank 3=$NODE_NAME slot=1:8-15" >> myrankfile
    LI="liggghts_hybrid"
else
    LI="liggghts"
    echo old mode on
fi

echo $LI

NTHREADS=1
XPROCS=2
YPROCS=2
ZPROCS=2
PROCS=$(($XPROCS*$YPROCS*$ZPROCS))
MPI_OPTIONS="-np $PROCS -report-bindings"
VARS="-var NTHREADS $NTHREADS -var XPROCS $XPROCS -var YPROCS $YPROCS -var ZPROCS $ZPROCS -var OMPON $OMPON -var DCYLDP $DCYLDP"

date
$statisticInit mpirun $MPI_OPTIONS $LI -in in.sinterChute_init $VARS

if [ "$OMPON" = 1 ]; then
    NTHREADS=8
    XPROCS=2
    YPROCS=2
    ZPROCS=1
    PROCS=$(($XPROCS*$YPROCS*$ZPROCS))
    MPI_OPTIONS="-np $PROCS -report-bindings -hostfile myhostfile -rf myrankfile"
else
    echo old mode on
fi    

VARS="-var iden $fileID -var NTHREADS $NTHREADS -var XPROCS $XPROCS -var YPROCS $YPROCS -var ZPROCS $ZPROCS -var OMPON $OMPON -var DCYLDP $DCYLDP"

date
$statisticLoop mpirun $MPI_OPTIONS $LI -in in.sinterChute_main $VARS

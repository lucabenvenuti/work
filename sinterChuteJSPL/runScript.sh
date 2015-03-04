#! /bin/bash

OMPON=1
fileID="003"
DCYLDP=5

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
XPROCS=1
YPROCS=2
ZPROCS=2
PROCS=$(($XPROCS*$YPROCS*$ZPROCS))
MPI_OPTIONS="-np $PROCS -report-bindings"
VARS="-var NTHREADS $NTHREADS -var XPROCS $XPROCS -var YPROCS $YPROCS -var ZPROCS $ZPROCS -var OMPON $OMPON -var DCYLDP $DCYLDP"


if [ "$OMPON" = 1 ]; then
    NTHREADS=4
    XPROCS=1
    YPROCS=1
    ZPROCS=1
    PROCS=$(($XPROCS*$YPROCS*$ZPROCS))
    MPI_OPTIONS="-np $PROCS -report-bindings -hostfile myhostfile -rf myrankfile"
else
    echo old mode on
fi    

VARS="-var iden $fileID -var NTHREADS $NTHREADS -var XPROCS $XPROCS -var YPROCS $YPROCS -var ZPROCS $ZPROCS -var OMPON $OMPON -var DCYLDP $DCYLDP"

perf stat -o stats/resultsLoop$fileID.txt mpirun $MPI_OPTIONS $LI -in in.sinterChute $VARS

####mpirun -np 8 liggghts -in in.sinterChute -var NTHREADS 1 -var XPROCS 2 -var YPROCS 2 -var ZPROCS 2 -var DCYLDP 5 -var OMPON 0


#! /bin/bash

OMPON=0
fileID="001"
DCYLDP=5

NTHREADS=1
XPROCS=1
YPROCS=2
ZPROCS=2
PROCS=$(($XPROCS*$YPROCS*$ZPROCS))
MPI_OPTIONS="-np $PROCS -report-bindings"

VARS="-var iden $fileID -var NTHREADS $NTHREADS -var XPROCS $XPROCS -var YPROCS $YPROCS -var ZPROCS $ZPROCS -var OMPON $OMPON -var DCYLDP $DCYLDP"

perf stat -o stats/resultsLoop$fileID.txt mpirun $MPI_OPTIONS liggghts -in in.sinterChute $VARS

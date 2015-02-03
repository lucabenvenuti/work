#! /bin/bash

fileID="001"
DCYLDP=5

NTHREADS=1
XPROCS=3
YPROCS=2
ZPROCS=2
PROCS=$(($XPROCS*$YPROCS*$ZPROCS))
MPI_OPTIONS="-np $PROCS -report-bindings"
LI="liggghts"

VARS="-var NTHREADS $NTHREADS -var XPROCS $XPROCS -var YPROCS $YPROCS -var ZPROCS $ZPROCS -var OMPON 0 -var DCYLDP $DCYLDP"

date
perf stat -o stats/resultsInit$fileID.txt mpirun $MPI_OPTIONS $LI -in in.shearCell_PP_init $VARS
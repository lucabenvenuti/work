#! /bin/bash

fileID="003"
DCYLDP=28

NTHREADS=1
XPROCS=3
YPROCS=2
ZPROCS=2
PROCS=$(($XPROCS*$YPROCS*$ZPROCS))
MPI_OPTIONS="-np $PROCS -report-bindings"
LI="liggghts"

VARS="-var iden $fileID -var NTHREADS $NTHREADS -var XPROCS $XPROCS -var YPROCS $YPROCS -var ZPROCS $ZPROCS -var OMPON 0 -var DCYLDP $DCYLDP"

date
mpirun $MPI_OPTIONS $LI > in.shearCell_PP_init $VARS


date
mpirun $MPI_OPTIONS $LI > in.shearCell_PP $VARS
date

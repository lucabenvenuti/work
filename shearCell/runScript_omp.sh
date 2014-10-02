#! /bin/bash
NODE_NAME=`uname -n` # e.g. `node37.service`

# create hostfile
echo "$NODE_NAME slots=4" > myhostfile

# create rankfile
echo "rank 0=$NODE_NAME slot=0:0-7" > myrankfile
echo "rank 1=$NODE_NAME slot=0:8-15" >> myrankfile
echo "rank 2=$NODE_NAME slot=1:0-7" >> myrankfile
echo "rank 3=$NODE_NAME slot=1:8-15" >> myrankfile

#mpirun -np .... [OPTIONS] -in in.shearCell_init_packing
#mpirun -np .... [OPTIONS] -in in.shearCell_loop

NTHREADS=1
XPROCS=4
YPROCS=4
ZPROCS=2
PROCS=$(($XPROCS*$YPROCS*$ZPROCS))
MPI_OPTIONS="-np $PROCS -report-bindings"
VARS="-var NTHREADS $NTHREADS -var XPROCS $XPROCS -var YPROCS $YPROCS -var ZPROCS $ZPROCS"

perf stat mpirun $MPI_OPTIONS liggghts_hybrid -in in_omp.shearCell_init_packing $VARS

NTHREADS=8
XPROCS=2
YPROCS=2
ZPROCS=1

PROCS=$(($XPROCS*$YPROCS*$ZPROCS))
MPI_OPTIONS="-np $PROCS -report-bindings -hostfile myhostfile -rf myrankfile"
VARS="-var iden 24003 -var NTHREADS $NTHREADS -var XPROCS $XPROCS -var YPROCS $YPROCS -var ZPROCS $ZPROCS"

perf stat mpirun $MPI_OPTIONS liggghts_hybrid -in in_omp.shearCell_loop $VARS

# gollum 		: 32 /home/k3b02/k3b1672/LIGGGHTS-3-beta-PFM/src/lmp_fedora
# gollum with module 	: 32 liggghts
# pc 			: 4 /home/luca/liggghts/LIGGGHTS-3-beta-PFM/src/lmp_fedora
# pc 			: 4 /mnt/data_linux/apps/LIGGGHTS/LIGGGHTS-PFM/src/lmp_fedora
#where the last number represents your simulation number 
#beware! thou shall not use the same number twice!

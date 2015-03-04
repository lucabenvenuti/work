#! /bin/bash

OMPON=0
fileID="31601"
DCYLDP=100

#index[0]="28201"
#index[1]="28202"
#index[2]="28203"
#index[3]="28204"


#OM[0]=0
#OM[1]=1sh
#OM[2]=0
#OM[3]=1

#DCYL[0]=20
#DCYL[1]=20
#DCYL[2]=30
#DCYL[3]=30

#for i in 0 1 2 3
#do

#fileID=${index[$i]}
#OMPON=${OM[$i]}
#DCYLDP=${DCYL[$i]}

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
XPROCS=4
YPROCS=4
ZPROCS=2
PROCS=$(($XPROCS*$YPROCS*$ZPROCS))
MPI_OPTIONS="-np $PROCS -report-bindings"
VARS="-var NTHREADS $NTHREADS -var XPROCS $XPROCS -var YPROCS $YPROCS -var ZPROCS $ZPROCS -var OMPON $OMPON -var DCYLDP $DCYLDP"


perf stat -o stats/resultsInit$fileID.txt mpirun $MPI_OPTIONS $LI -in in.shearCell_init_packing $VARS

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

perf stat -o stats/resultsLoop$fileID.txt mpirun $MPI_OPTIONS $LI -in in.shearCell_loop $VARS

#done

#mpirun -np .... [OPTIONS] -in in.shearCell_init_packing
#mpirun -np .... [OPTIONS] -in in.shearCell_loop
# gollum 		: 32 /home/k3b02/k3b1672/LIGGGHTS-3-beta-PFM/src/lmp_fedora
# gollum with module 	: 32 liggghts
# pc 			: 4 /home/luca/liggghts/LIGGGHTS-3-beta-PFM/src/lmp_fedora
# pc 			: 4 /mnt/data_linux/apps/LIGGGHTS/LIGGGHTS-PFM/src/lmp_fedora
#where the last number represents your simulation number 
#beware! thou shall not use the same number twice!

#!/bin/bash 

# -------------- PBS Torque settings 

#PBS -N LIGSintmaster
#PBS -o $HOME/output/outSinterChuteJSPLmaster__${PBS_JOBID}.out
#PBS -j oe
#PBS -l nodes=8:ppn=8
#PBS -l walltime=240:00:00
#PBS -M luca.benvenuti@jku.at
#PBS -m bea

#source /etc/csh/login.d/modules
module() { eval `/usr/bin/modulecmd bash $*`; }
module use $HOME/modules
module load gcc mvapich2 zoltan liggghts/APP/master

echo "===== main cluster node is:  `hostname `  "
echo "===== the PBS_NODEFILE: $PBS_NODEFILE"
cat $PBS_NODEFILE
echo ""

set -x

SCRIPT_NAME=compile_liggghts.sh
cd $PBS_O_WORKDIR

if [ ! -f $SCRIPT_NAME  ]
  then
    echo "ERROR: this script must be started from scripts folder!"
    exit -1
fi

ROOT_DIR=$HOME/workBench
WORK_DIR=$HOME/workBench/liseSim/sinterChuteJSPLmaster__${PBS_JOBID}
SIM_DIR=$HOME/workBench/sinterChuteJSPL

mkdir -p $WORK_DIR
cp -r  $SIM_DIR/* $WORK_DIR/
cd $WORK_DIR

OMPON=0   # master = 0 ; hybrid = 1 ; develop = 2
DCYLDP=5

if [ "$OMPON" = 1 ]; then
	LI="liggghts_hybrid"
    echo OMP mode on
    export OMP_NUM_THREADS=8
    export MV2_ENABLE_AFFINITY=0
    export MV2_USE_SHARED_MEM=0
    export MV2_SHOW_CPU_BINDING=1
	NTHREADS=8
	XPROCS=2
	YPROCS=2
	ZPROCS=2
	PROCS=$(($XPROCS*$YPROCS*$ZPROCS))
    MPI_OPTIONS="-np $PROCS -env MV2_ENABLE_AFFINITY 0 -env MV2_USE_SHARED_MEM 0"
else
    LI="liggghts_master_or_develop"
    echo master mode on
	NTHREADS=1
	XPROCS=4
	YPROCS=4
	ZPROCS=4
	PROCS=$(($XPROCS*$YPROCS*$ZPROCS))
	MPI_OPTIONS="-np $PROCS"
fi

VARS="-var iden ${PBS_JOBID} -var NTHREADS $NTHREADS -var XPROCS $XPROCS -var YPROCS $YPROCS -var ZPROCS $ZPROCS -var OMPON $OMPON -var DCYLDP $DCYLDP"

date
mpiexec $MPI_OPTIONS liggghts -in in.sinterChute $VARS
date
mpiexec $MPI_OPTIONS liggghts -in in.sinterChuteMover $VARS
date
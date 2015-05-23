#!/bin/bash 

# -------------- PBS Torque settings 

#PBS -N LIGSinthybrid
#PBS -o ${PBS_JOBID}__outSinterChuteJSPLhybrid__${PBS_JOBID}.out
#PBS -j oe
#PBS -l nodes=1:ppn=8
#PBS -l walltime=1:00:00
#PBS -M luca.benvenuti@jku.at
#PBS -m bea

#source /etc/csh/login.d/modules
module() { eval `/usr/bin/modulecmd bash $*`; }
module use $HOME/modules
module load gcc mvapich2 zoltan liggghts/APP/hybrid

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

cd ../sinterChuteJSPLhybrid

OMPON=1   # hybrid = 1
DCYLDP=5

echo hybrid mode on
export OMP_NUM_THREADS=8
export MV2_ENABLE_AFFINITY=0
export MV2_USE_SHARED_MEM=0
export MV2_SHOW_CPU_BINDING=1
NTHREADS=8
XPROCS=1
YPROCS=1
ZPROCS=1
PROCS=$(($XPROCS*$YPROCS*$ZPROCS))
MPI_OPTIONS="-np $PROCS -env MV2_ENABLE_AFFINITY 0 -env MV2_USE_SHARED_MEM 0"

VARS="-var iden ${PBS_JOBID} -var NTHREADS $NTHREADS -var XPROCS $XPROCS -var YPROCS $YPROCS -var ZPROCS $ZPROCS -var OMPON $OMPON -var DCYLDP $DCYLDP"

date
mpiexec $MPI_OPTIONS liggghts -in in.sinterChute $VARS
date
mpiexec $MPI_OPTIONS liggghts -in in.sinterChuteMover $VARS
date

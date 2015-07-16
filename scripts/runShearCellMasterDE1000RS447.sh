#!/bin/bash 

# -------------- PBS Torque settings 

#PBS -N LShCeMasDE1000RS447
#PBS -o ${PBS_JOBID}__outShearCellMasterDE1000RS447__${PBS_JOBID}.out
#PBS -j oe
#PBS -l nodes=4:ppn=8
#PBS -l walltime=48:00:00
#PBS -M luca.benvenuti@jku.at
#PBS -m bea

#source /etc/csh/login.d/modules
module() { eval `/usr/bin/modulecmd bash $*`; }
module use $HOME/modules
module load gcc mvapich2 liggghts/PFM/master

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

cd ../shearCellMasterDE1000RS447

OMPON=0   # master = 0 
DCYLDP=30

echo master mode on
NTHREADS=1
XPROCS=4
YPROCS=4
ZPROCS=2
PROCS=$(($XPROCS*$YPROCS*$ZPROCS))
MPI_OPTIONS="-np $PROCS"

VARS="-var iden 50021 -var NTHREADS $NTHREADS -var XPROCS $XPROCS -var YPROCS $YPROCS -var ZPROCS $ZPROCS -var OMPON $OMPON -var DCYLDP $DCYLDP"

date
mpiexec $MPI_OPTIONS liggghts -in in.shearCell_init_packing $VARS
date
mpiexec $MPI_OPTIONS liggghts -in in.shearCell_loop $VARS
date

#!/bin/bash 

# -------------- PBS Torque settings 

#PBS -N BFinitCont
#PBS -o ${PBS_JOBID}__outBFinitCont.sh__${PBS_JOBID}.out
#PBS -j oe
#PBS -l nodes=4:ppn=8
#PBS -l walltime=96:00:00
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

cd ../BFinitCont

XPROCS=4
YPROCS=4
ZPROCS=2
PROCS=$(($XPROCS*$YPROCS*$ZPROCS))
MPI_OPTIONS="-np $PROCS"

VARS="-var XPROCS $XPROCS -var YPROCS $YPROCS -var ZPROCS $ZPROCS"

date
mpiexec $MPI_OPTIONS liggghts -in in.liggghts_init $VARS
date

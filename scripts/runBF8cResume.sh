#!/bin/bash 

# -------------- PBS Torque settings 

#PBS -N BF8cResume
#PBS -o ${PBS_JOBID}__BF8cResume__${PBS_JOBID}.out
#PBS -j oe
#PBS -l nodes=1:ppn=8
#PBS -l walltime=100:00:00
#PBS -M luca.benvenuti@jku.at
#PBS -m bea

module() { eval `/usr/bin/modulecmd bash $*`; }
module unload mvapich2
module load icc gcc openmpi

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

XPROCS=2
YPROCS=2
ZPROCS=2
PROCS=$(($XPROCS*$YPROCS*$ZPROCS))
MPI_OPTIONS="-np $PROCS"
TOOLKIT_DIR=$HOME/workspace/src/ParticulateFlow/toolkit

CASE_DIR=$PBS_O_WORKDIR/../BF8cResume

mkdir -p $CASE_DIR/post

module use $HOME/modules
module unload openmpi
module load mvapich2 liggghts/PFM/develop
cd $CASE_DIR
mpiexec $MPI_OPTIONS liggghts -in in.liggghts_resume
date
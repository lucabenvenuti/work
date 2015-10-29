#!/bin/bash 

# -------------- PBS Torque settings 

#PBS -N Ergun
#PBS -o ${PBS_JOBID}__Ergun__${PBS_JOBID}.out
#PBS -j oe
#PBS -l nodes=1:ppn=8
#PBS -l walltime=2:00:00
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

ROOT_DIR=$home/workspace

TOOLKIT_DIR=$HOME/workspace/src/ParticulateFlow/toolkit
CASE_DIR=$PBS_O_WORKDIR/../ErgunTestMPI

cd $TOOLKIT_DIR

source bashrc
cd $CASE_DIR

date
./Allrun.sh
date
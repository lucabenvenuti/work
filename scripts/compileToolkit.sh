#!/bin/bash 

# -------------- PBS Torque settings 

#PBS -N compileToolkit
#PBS -o ${PBS_JOBID}__compileToolkit__${PBS_JOBID}.out
#PBS -j oe
#PBS -l nodes=1:ppn=8
#PBS -l walltime=2:00:00
#PBS -M luca.benvenuti@jku.at
#PBS -m bea

module() { eval `/usr/bin/modulecmd bash $*`; }

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

ROOT_DIR=$HOME/lise_workspace
TOOLKIT_DIR=$ROOT_DIR/src/ParticulateFlow/toolkit

cd $TOOLKIT_DIR
module unload mvapich2
module load gcc openmpi

./CompileForCluster.sh
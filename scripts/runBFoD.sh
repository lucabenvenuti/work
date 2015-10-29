#!/bin/bash

#!/bin/bash 

# -------------- PBS Torque settings 

#PBS -N BFoD
#PBS -o ${PBS_JOBID}__BFoD__${PBS_JOBID}.out
#PBS -j oe
#PBS -l nodes=4:ppn=8
#PBS -l walltime=120:00:00
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
YPROCS=4
ZPROCS=4
PROCS=$(($XPROCS*$YPROCS*$ZPROCS))
MPI_OPTIONS="-np $PROCS"
TOOLKIT_DIR=$HOME/workspace/src/ParticulateFlow/toolkit

CASE_DIR=$PBS_O_WORKDIR/../BFoD

mkdir -p $CASE_DIR/DEM/post

RESTART_FILE_NAME=$CASE_DIR/DEM/liggghts.restart

if [ ! -f $RESTART_FILE_NAME  ]
  then
    echo "running liggghts init"
    date
    module use $HOME/modules
    module unload openmpi
    module load mvapich2 liggghts/PFM/develop
    cd $CASE_DIR/DEM
    VARS="-var XPROCS $XPROCS -var YPROCS $YPROCS -var ZPROCS $ZPROCS"
    mpiexec $MPI_OPTIONS liggghts -in in.liggghts_init $VARS
    module unload mvapich2 liggghts/PFM/develop
    module load openmpi
fi

cd $TOOLKIT_DIR

source bashrc
cd $CASE_DIR/CFD

date
decomposePar
date
mpirun $MPI_OPTIONS cfdemSolverPiso -parallel
date
reconstructPar
date
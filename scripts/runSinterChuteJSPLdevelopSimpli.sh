#!/bin/bash 

# -------------- PBS Torque settings 

#PBS -N LIGSintdevelopSimpli
#PBS -o ${PBS_JOBID}__outSinterChuteJSPLdevelopSimpli__${PBS_JOBID}.out
#PBS -j oe
#PBS -l nodes=8:ppn=8
#PBS -l walltime=48:00:00
#PBS -M luca.benvenuti@jku.at
#PBS -m bea

#source /etc/csh/login.d/modules
module() { eval `/usr/bin/modulecmd bash $*`; }
module use $HOME/modules
module load gcc mvapich2 liggghts/PFM/develop

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

cd ../sinterChuteJSPLdevelopSimpli

OMPON=2   # develop = 2 
DCYLDP=5

echo developSimpli mode on
NTHREADS=1
XPROCS=4
YPROCS=4
ZPROCS=4
PROCS=$(($XPROCS*$YPROCS*$ZPROCS))
MPI_OPTIONS="-np $PROCS"

VARS="-var iden ${PBS_JOBID} -var NTHREADS $NTHREADS -var XPROCS $XPROCS -var YPROCS $YPROCS -var ZPROCS $ZPROCS -var OMPON $OMPON -var DCYLDP $DCYLDP"

date
mpiexec $MPI_OPTIONS liggghts -in in.sinterChute $VARS
date
mpiexec $MPI_OPTIONS liggghts -in in.sinterChuteMover $VARS
date
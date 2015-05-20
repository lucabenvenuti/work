#!/bin/bash
#PBS -o compile_liggghts.out
#PBS -j oe
#PBS -l ncpus=8
#PBS -l walltime=0:30:00
#PBS -M richard.berger@jku.at
module() { eval `/usr/bin/modulecmd bash $*`; }

SCRIPT_NAME=compile_liggghts.sh
cd $PBS_O_WORKDIR

if [ ! -f $SCRIPT_NAME  ]
  then
    echo "ERROR: this script must be started from scripts folder!"
    exit -1
fi

ROOT_DIR=$(git rev-parse --show-toplevel)

LIGGGHTS_DIR=$ROOT_DIR/src/ParticulateFlow/LIGGGHTS
LIGGGHTS_CHECKOUT=master
LIGGGHTS_INSTALL_DIR=$HOME/opt/liggghts/PFM/master

cd $LIGGGHTS_DIR
git clean -x -f -d
git reset --hard
git checkout $LIGGGHTS_CHECKOUT

mkdir src-build
cd src-build

module load gcc mvapich2
cmake ../src -DCMAKE_INSTALL_PREFIX=$LIGGGHTS_INSTALL_DIR
make -j 8
make install

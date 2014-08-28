#=====================
#  CHECK # ARGS
#=====================

EXPECTED_ARGS=3
if [ $# -lt ${EXPECTED_ARGS} ]; then
    echo "Usage: `basename $0 $1 $2 $3 $4 $5` {materialname} {nproc} {g_d_ratio} [{liggghts} {gui} {nvariations}]"
    exit
fi

#=====================
# VARIABLES TO SET
#=====================

# name of material
MATERIAL=$1

# number of processors to run on
NPROC=$2

# RATIO GEOMETRY TO MAX DIAMETER
G_D_RATIO=$3

# LIGGGHTS executable to use
if [ $# -gt ${EXPECTED_ARGS} ]; then
    LIGGGHTS=$4
else
    LIGGGHTS=liggghts
fi

# script called from console or GUI
if [ $# -gt 4 ]; then
    GUI=$5
else
    GUI=
fi

# input script with diameter
# distributions, density
# Young's modulus etc
FIXED_PARAMS_FILE="${MATERIAL}/in.fixed_params"

# input script for CALIBRATED
# of material params 
CALIB_PARAMS_FILE="${MATERIAL}/in.var_params_CALIB"

# input script for GUESSTIMATES
# of material params
GUESS_PARAMS_FILE="${MATERIAL}/in.var_params_GUESS"

# number of variations for material
# parameter runs
# script called from console or GUI
if [ $# -gt 5 ]; then
    N_VARIATIONS=$6
else
    N_VARIATIONS=8
fi

#=====================
# !!!DO NOT CHANGE!!!
#=====================

CALIB_PARAM_NONE=0
CALIB_PARAM_COF=1
CALIB_PARAM_CORF=2

#=====================
# CHECK IF MATERIAL DIR EXISTS
#=====================

# bash check if directory exists
if [ -d "${MATERIAL}" ]; then
    echo "Directory ${MATERIAL} exists"
else 
    echo "Directory ${MATERIAL} does not exist, exiting"
    exit
fi 

#=====================
# RUN ANGLE OF REPOSE
#=====================

#run initialization
${LIGGGHTS} < template/repose/in.repose_param_init_packing -var MATERIAL ${MATERIAL} -var G_D_RATIO ${G_D_RATIO} -var FIXED_PARAMS_FILE ${FIXED_PARAMS_FILE} -var GUESS_PARAMS_FILE ${GUESS_PARAMS_FILE} -var CALIB_PARAMS_FILE ${CALIB_PARAMS_FILE} -var CALIB_PARAM ${CALIB_PARAM_NONE}
#run param variation
mpirun -np ${NPROC} ${LIGGGHTS} -partition ${NPROC}x1 -in template/repose/in.repose_param -var MATERIAL ${MATERIAL} -var G_D_RATIO ${G_D_RATIO} -var FIXED_PARAMS_FILE ${FIXED_PARAMS_FILE} -var GUESS_PARAMS_FILE ${GUESS_PARAMS_FILE} -var CALIB_PARAMS_FILE ${CALIB_PARAMS_FILE} -var CALIB_PARAM ${CALIB_PARAM_CORF} -var N_VARIATIONS ${N_VARIATIONS} -uid ${MATERIAL}

#run angle evaluation
mpirun -np ${NPROC} ${LIGGGHTS} -partition ${NPROC}x1 -in template/repose/in.repose_param_angle -var MATERIAL ${MATERIAL} -var G_D_RATIO ${G_D_RATIO} -var FIXED_PARAMS_FILE ${FIXED_PARAMS_FILE} -var GUESS_PARAMS_FILE ${GUESS_PARAMS_FILE} -var CALIB_PARAMS_FILE ${CALIB_PARAMS_FILE} -var CALIB_PARAM ${CALIB_PARAM_CORF} -var N_VARIATIONS ${N_VARIATIONS} -uid ${MATERIAL}

#=====================
# EVALUATE ANGLE OF REPOSE
#=====================

cp template/repose/loaddata.m     "${MATERIAL}/repose/loaddata.m"
cp template/repose/plotAreaData.m "${MATERIAL}/repose/plotAreaData.m"

cd ${MATERIAL}/repose
octave --silent plotAreaData.m
cd ..
cd ..

i=1
while [ ${i} -le ${N_VARIATIONS} ]
do
    n=1
    while read -r line
    do
        case $n in
            1) echo "Coefficient of rolling friction: $line" ;;
            2) echo "                angle of repose: $line" && break ;;
        esac
        n=$(($n+1))
    done <"${MATERIAL}/repose/area/angle_${i}"
    i=$(($i+1))
done

if [ "${GUI}" ]; then
    echo "Please choose which repose angle for ${MATERIAL} matches best"
else
    echo "Please choose which repose angle for ${MATERIAL} matches best (value from 1 to ${N_VARIATIONS})"
    read chosen

    while [ ${chosen} -gt ${N_VARIATIONS} ]
    do
        echo "Please choose which angle matches best (value from 1 to ${N_VARIATIONS})"
        read chosen
    done

    if [ -f ${MATERIAL}/params_${chosen} ]; then
        cat ${MATERIAL}/params_${chosen} &>> ${CALIB_PARAMS_FILE}
        rm ${MATERIAL}/params* 2>/dev/null
    fi
fi

#=====================
# CLEANUP
#=====================

rm log.liggghts* 2>/dev/null
rm screen* 2>/dev/null
rm params_* 2>/dev/null
rm tmp.lammps.variable${MATERIAL} 2>/dev/null


#!/bin/sh

opt=( dummy parafilename )
nopt=${#opt[*]}
if [ $# -le `expr ${nopt} - 2` ]; then
    echo "USAGE: $0" ${opt[*]:1:${nopt}}
    echo $*
    exit
fi

num=1
while [ $num -le `expr ${nopt} - 1` ]; do
    eval ${opt[$num]}=$1
    shift 1
    num=`expr $num + 1`
done

source ${parafilename}

for node in ${nodes[*]}; do
    for core in ${cores[${node}]}; do
	np=${core}
	suffix=${node}_${core}
	jobsh=bench.job.${node}_${core}

	if [ ! -d ${suffix} ]; then
	    mkdir ${suffix}
	fi

	cat <<EOF > ${jobsh}
#! /bin/sh
#PBS -l select=1:ncpus=${core}:mpiprocs=${core}:ompthreads=1:host=${node}
#PBS -j oe
#PBS -N ${job_commonname}

module load gromacs/2024.2
source $GMXRC

${gmx} grompp -f input/production.mdp -o ${suffix}/production.tpr -c input/final_density_stabilization.gro -p input/topol.top

cd ${suffix}

mpirun -np ${np} ${gmx} mdrun -noconfout -maxh 0.1 -deffnm production

rm production.edr
rm production.tpr
rm production.xtc
rm production.trr
rm mdout.mdp
rm \#*

EOF
    done
done

for l in ${!line[@]}; do

    while :; do
	n_job=$( qstat | grep ${job_commonname} | wc -l )
	qstat
	if [ ${n_job} -gt 0 ]; then
	    sleep 120;
	else
	    break;
	fi
    done

    for q in ${line["$l"]}; do
	qsub ${q}
    done

done

while :; do
    n_job=$( qstat | grep ${job_commonname} | wc -l )
    qstat
    if [ ${n_job} -gt 0 ]; then
	sleep 120;
    else
	break;
    fi
done

for node in ${nodes[*]}; do
    printf "ncpu   ns/day  (${gmx}) \n" > performance_${node}
    for core in ${cores[${node}]}; do
	suffix=${node}_${core}

	cd ${suffix}

	if [ -f production.log ]; then
	    ns=`grep Performance: production.log | awk '{print \$2}'`

	    printf "%5d %8.3f\n" ${core}  ${ns} >> ../performance_${node}
	else
	    printf "%5d NaN\n" ${core} >> ../performance_${node}
	fi

	cd ..
    done
done


#!/bin/bash

#SBATCH -p Lewis 
#SBATCH -n 1
#SBATCH -c 10
#SBATCH --mem 16G

if [[ "$#" -ne 3 ]]
then
	echo "error"
	exit 1
fi
let lower=$1
let upper=$2
let granularity=$3
if [[ $granularity -le 1 ]]
then
	srun python3 sequential.py $lower $upper
else
	srun python3 mproc.py $lower $upper $granularity
fi



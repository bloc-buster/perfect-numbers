#!/bin/bash

if [[ "$#" -lt 2 ]]
then
	echo "usage: main.sh granularity1 granularity2 [lower_bound upper_bound] [outputfolder]"
	exit 1
fi
computeN="false"
if [[ $1 == "-n" ]]
then
	computeN="true"
	shift
fi
let granularity1=$1
let granularity2=$2
if [[ $computeN == "true" ]]
then
	let N=$(( $granularity1 * $granularity2 ))
	echo "total divisions = $N"
	exit 0
fi
let lower=8000
let upper=9000
if [[ "$#" -ge 3 ]]
then
	let lower=$3
	let upper=$4
fi
outputfolder="output"
if [[ "$#" -ge 5 ]]
then
	outputfolder=$5
fi
command mkdir $outputfolder
let range=$(( upper - lower ))
let step=$(( range / granularity1 ))
echo "g1 $granularity1 g2 $granularity2 lower $lower upper $upper range $range step $step"
let count=1
for (( x = $lower; x < $upper; x += $step ))
do
	let y=$(( x + step - 1 ))
	if [[ $y -gt $upper || $count -eq $granularity1 ]]
	then
		let y=$upper
	fi
	echo "running command intermediate.sh $x $y $granularity2 $outputfolder"
	command sbatch --output="$outputfolder/batch-%j.out" intermediate.sh $x $y $granularity2
	if [[ $count -eq $granularity1 ]]
	then
		break
	fi
	let count+=1
done


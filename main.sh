#!/bin/bash

if [[ "$#" -lt 2 ]]
then
	echo "usage: main.sh granularity1 granularity2 [outputfolder] [lower_bound upper_bound]"
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
outputfolder="output"
if [[ "$#" -ge 3 ]]
then
	outputfolder=$3
fi
command mkdir $outputfolder
let lower=10000000000
let upper=10010000000
if [[ "$#" -eq 5 ]]
then
	let lower=$4
	let upper=$5
fi
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


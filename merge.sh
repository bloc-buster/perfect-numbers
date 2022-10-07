#!/bin/bash

if [[ "$#" -ne 1 ]]
then
	echo "usage: merge.sh outputfolder"
	exit 1
fi
outputfolder=$1
files=$( ls "$outputfolder" )
for file in $files
do
	if [[ $file == "results.txt" ]]
	then
		continue
	fi
	command cat "$outputfolder/$file" >> "$outputfolder/results.txt"
	command rm "$outputfolder/$file"
done


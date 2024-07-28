#!/bin/bash

# Script to inspect the statistics of multiple 
# slurm .out files in a given folder.
#
# Example call:
# 	bash inspect_slurms.sh folder/with/slurm/files
#
# José Losa
# 2023.03.08

for file in $1/*.out; 
	do 
	echo $file; 
	grep walltime $file; 
	grep Mem $file ; 
	done;

#!/bin/bash

# Script to clean the folder allFastaFiles,
# by deleting the .fasta files that have
# already been used in simulations.
# 
# José Losa
# 2023.03.08

while read p; do
	if [[ -f ./allFastaFiles/$p ]]; then
	        echo ">>> removing $p from ./allFastaFiles"
		rm ./allFastaFiles/$p
	else	
		echo "$p not in ./allFastaFiles"
	fi
done <simulations_done_backup.txt

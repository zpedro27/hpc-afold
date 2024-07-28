#!/bin/bash

# Generates a .txt file with a
# list of all the .fasta filenames contained
# in the folder ./allFastaFiles
#
# José Losa
# 2023.03.06

for file in ./allFastaFiles/*.fasta
do
	basename "$file"
	f="$(basename -- $file)"
	echo "$f" >> simulations_toDo.txt
done




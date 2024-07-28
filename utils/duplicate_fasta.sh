#! /bin/bash

# This script loops through all the .fasta
# files in the input directory and
# duplicates the sequences, adding '_1'
# to the name of the repeated entry.
# 
# Example call:
# $bash duplicate_fasta.sh folder/with/fasta/files/
#
# NOTE: make sure that the provided .fasta files
# end with an empty line, so that the duplicated 
# sequence is appended on a different line.
#
# José Losa (2023.03.03)

for file in $1/*.fasta; 
do
	cat $file | sed	's/\(^>\w*\)/\1_1/g' >> $file
done


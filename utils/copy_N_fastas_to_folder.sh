#!/bin/bash
#
# Copies the first N files listed in an input .txt file
# into a desired destination folder.
# After moving the .fasta files, the corresponding entries in the
# input file are deleted.
#
# Example call:
# 	bash copy_N_fastas_to_folder.sh listToProcess.txt 20 destinationFolder/
# 
# NOTE: Make sure that the input .txt files with the list  
# of fasta files does not have the 'invisible' character \r
# at the end of each line! (this can happen if the file
# was generated in windows).
# In that case, first run the text file through the command:
# 	sed -i 's/\r$//' filename.txt
#
# José Losa
# 2023.03.09

# Define filenames and variables
FOLDER_FASTAS=/projects/pXXXXX/alphaFoldModeling/allFastaFiles/
DESTINATION=$3
NO_FILES=$2
counter=0

# Empty helper backup file
>backup.txt

while read p; do

	full_file_path="$FOLDER_FASTAS$p"
	
	if [[ $counter -le $NO_FILES ]]; then
		cp $full_file_path $DESTINATION/$p
		echo ">>> copying $p from ./allFastaFiles to $DESTINATION"
	else
		echo $p >> backup.txt			
	fi
	counter=$((counter+1))
done <$1

# Place the contents back on the original input file
cat backup.txt > $1


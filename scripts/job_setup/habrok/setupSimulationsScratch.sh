#!/bin/bash

# How many per batch script
perBatch=3

# Make a new todolist
rm todolist
touch todolist

# Initalize counter of .fasta files
i=1

for file in ./*.fasta
do

  # Start new batch script and add it to the todoList:
  if [[ $(($i % $perBatch)) == 1 ]]; then
    numbering="00$i"
    echo "$numbering"
    cat /scratch/pXXXX/scripts/job_templates/job_template_1 | sed 's/JOBNAME/aFold/g' | sed 's/FASTANAME/$file/g' > batch_script_$numbering
    echo "sbatch  batch_script_$numbering" >> todolist
  fi
  # Append to existing batch script
  echo "alphafold --fasta_paths=$file --model_preset=multimer --max_template_date=2021-12-31 --output_dir=output" >> batch_script_$numbering
  echo "python /scratch/pXXXX/scripts/helper/deleteExtraFiles.py $file" >> batch_script_$numbering
  echo "bash /scratch/pXXXX/scripts/helper/updateListSimulations.sh $file" >> batch_script_$numbering
  
  # Append to existing batch script, and unmount alphafold_data
  if [[ $(($i % $perBatch)) == 0 ]]; then
    echo "fusermount -u $TMPDIR/alphafold_data" >> batch_script_$numbering
  fi
  # Increase .fasta file counter
  i=$((i+1))

done

# Append to existing batch script (needed especially if the number of .fasta files in the folder is not a multiple of <perBatch>)
echo "fusermount -u $TMPDIR/alphafold_data" >> batch_script_$numbering

# Ensure the todolist is executable, can be run with ./todolist to submit all the jobs.
chmod +x todolist

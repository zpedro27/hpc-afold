#!/bin/bash

# Updates the lists of simulations done/to do.
# Takes as input the name of a .fasta file
#
# José Losa
# 2023.03.06

# Add entry to the list of simulations done:
echo "$1" >> /home2/pXXXXX/alphaFoldModeling/simulations_done.txt

# Remove entry from the list of simulations to do:
sed -i "/$1/d" /home2/pXXXXX/alphaFoldModeling/simulations_toDo.txt
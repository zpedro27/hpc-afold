#!/bin/bash



echo "Size of folder:"
du -hs $1
echo "# of proteins:"
ls $1 | grep .fasta | wc -l


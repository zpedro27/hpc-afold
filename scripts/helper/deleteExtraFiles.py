#! /bin/python

"""
Script to delete unnecessary files generated as output 
of the AlphaFold simulations.

This script should be run after performing each AlphaFold simulation.
The idea is that large files (sequence alignments and .pkl files
of the non-optimal predictions) are deleted, in order to avoid running
into memory issues.

Example call:
    $ python deleteExtraFiles.py FASTA_NAME.fasta

José Losa
2023.03.03
"""


import sys
import json
import os
import glob


def delete_all_files_list(list_files):
    for file in list_files:
        os.remove(file)
        print("Deleting: ")
        print(file)
    return


current_dir = os.getcwd()

fasta_filename = sys.argv[1]
fasta_name_clean = fasta_filename.replace(".fasta", "")  # remove file extension


# Define folders to look into:
output_dir = os.path.join(current_dir, "output")
output_dir_main = os.path.join(output_dir, fasta_name_clean)
output_dir_alignments = os.path.join(output_dir_main, "msas/A")


# Check if .json exists in the directory:
rankings_filename = "ranking_debug.json"
rankings_fullpath = os.path.join(output_dir_main, rankings_filename)

if os.path.isfile(rankings_fullpath) is True:
    # Read .json file
    with open(rankings_fullpath) as f:
        obj = json.load(f)

    try:
        results_file_to_keep = obj["order"][0] + ".pkl"
    except KeyError:
        results_file_to_keep = ""


# Delete unnecessary 'result_model_X_multimer.pkl' files in the main 'output' folder:
pkl_files_to_delete = glob.glob(output_dir_main + "/result*.pkl")
pkl_files_to_delete = [x for x in pkl_files_to_delete if results_file_to_keep not in x] 
delete_all_files_list(pkl_files_to_delete)


# Delete all files in the 'msas' subdirectory:
alignment_files_to_delete = glob.glob(output_dir_alignments + "/*")
delete_all_files_list(alignment_files_to_delete)

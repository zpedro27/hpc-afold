# Scripts for running AlphaFold on the HPC cluster

Bash scripts and macros to help setting up *AlphaFold Multimer* predictions on the HPC cluster of the University of Groningen (Peregrine, until mid-2023; Habrók thereafter).

AlphaFold version updated in the new HPC cluster (Peregrine: 2.1.1; Habrók: 2.3.1).


## Instructions

0. Replace "pXXXXX" with your p-number in the files:
	- `setupSimulationsScratch.sh`
	- `updateListSimulations.sh`

1. Prepare folder with scripts
	- `cd /scratch/your_p_number`
	- `mkdir scripts` -> place the files that are in this repository

2. Prepare folder with simulations to be run
	- `cd /scratch/your_p_number`
	- `mkdir name_of_folder_with_simulations` -> place all `.fasta` files in this folder

3. (optional) If you want to keep track of all simulations run/to be run:
	- Create files `simulations_done.txt` and `simulations_toDo.txt`:
	- `touch simulations_done.txt`
	- `touch simulatons_toDo.txt`
	- I have these files on `/home2/pXXXXX`. If you have them somewhere else, you will have to change the path in the file `updateListSimulations.sh`
	- If you don't want this, just comment out the line: `echo "bash /scratch/pXXXXX/scripts/helper/updateListSimulations.sh $file" >> batch_script_$numbering" ` from the file `setupSimulationsScratch.sh`

4. Submit jobs:
	- `cd /scratch/your_p_number/name_of_folder_with_simulations`
	- `bash ../scripts/job_setup/setupSimulationsScratch.sh ` -> this creates a series of batch files
	- `./todolist ` -> this will submit the jobs to the cluster
    - or, if using the updated version of the script, specify the TIME (in h) and MEMORY (in GB): `bash ../scripts/job_setup/setupSimulationsScratch_new.sh 23 60; ./todolist`

5. Check progress of the jobs:
	- `squeue -u your_p_number`

6. (*optional*) If you have run a lot of simulations and want to quickly identify if something went wrong in any of them:
	- `cd /scratch/your_p_number/name_of_folder_with_simulations/output`
	- `python3 utils/check_output.py`


## Notes
- Once a batch of simulations has finished, it is better to transfer them to `/projects/your_p_number` (data storage)
- You really need to submit the jobs from the `/scratch` directory (trying to submit jobs from `/home` will not work!)
- If you don't want to type the command "bash ../scripts/job_setup/ ....." every time to setup the simulations, you can also create an alias:
	- `cd ~`
	- Open the file `.bashrc`
	- Add the following line of code: `alias setup_sims="bash /scratch/your_p_number/scripts/job_setup/setupSimulationsScratch.sh"`
	- Next time you can just type: `setup_sims`


## References
- Habrók Wiki: https://wiki.hpc.rug.nl/habrok/start

- Using AlphaFold on Habrók: https://wiki.hpc.rug.nl/habrok/examples/alphafold
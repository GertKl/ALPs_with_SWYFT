#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Jan 29 11:10:57 2024

@author: gert
"""


import os
import argparse
import pickle




if __name__ == "__main__":
    
    
    parser = argparse.ArgumentParser(description="")
    parser.add_argument("-path", type=str)
    args = parser.parse_args()
    
    with open(args.path +'/config_variables.pickle', 'rb') as file:
        config_dict = pickle.load(file)
    for key in config_dict.keys():
        locals()[key] = config_dict[key]
    
    
    if not os.path.exists(args.path+"/sim_output/sim_outputs"):
        os.makedirs(args.path+"/sim_output/sim_outputs")
    
    f = open(args.path+"/simulate.sh", "w")
    
    f.write("#!/bin/bash")
    f.write("\n\n")
    f.write("\n\n")
    # f.write("#SBATCH --job-name=swyftanalysis")
    # f.write("\n")
    # f.write("#SBATCH --account="+config.account)
    # f.write("\n")
    # f.write("#SBATCH --time="+config.max_time_2)
    # f.write("\n")
    # f.write("#SBATCH --partition="+config.partition_2)
    # f.write("\n")
    # f.write("#SBATCH --mem-per-cpu="+str(config.max_memory_2)+"G")
    # f.write("\n")
    # if config.devel_2:
    #     f.write("#SBATCH --qos=devel")
    #     f.write("\n")
    # if config.gpus:
    #     f.write("#SBATCH --gpus="+str(config.gpus))
    #     f.write("\n")
    # f.write("#SBATCH --output="+config.dirc+"/cluster_runs/results/" + config.name_run_ext + "/train_output/train_output.out")
    # f.write("\n\n")
    
    
    if on_cluster:
        f.write("\n\n")
        f.write("set -o errexit  # Exit the script on any error")
        f.write("\n\n")
        f.write("#set -o nounset  # Treat any unset variables as an error")
        f.write("\n\n")
        f.write("module --quiet purge  # Reset the modules to the system default")
        f.write("\n\n")
        f.write("# Set the ${PS1} (needed in the source of the Anaconda environment)")
        f.write("\n\n")
        f.write("export PS1=\$")
        f.write("\n\n")
        f.write("module load Miniconda3/22.11.1-1")
        f.write("\n\n")
        f.write("source ${EBROOTMINICONDA3}/etc/profile.d/conda.sh")
        f.write("\n\n")
        f.write("conda deactivate &>/dev/null")
        f.write("\n\n")
        f.write("conda activate /fp/homes01/u01/ec-gertwk/.conda/envs/"+str(conda_env))
        f.write("\n\n")
        f.write("\n\n")
    # else:
    #     f.write("conda activate "+str(conda_env))
    #     f.write("\n\n")
    #     f.write("\n\n")
    
    f.write("python "+results_dir+"/config_simulate_batch.py -path "+results_dir)
    f.write("\n\n")
    f.write("chmod +x "+results_dir+"/simulate_batch.sh")
    f.write("\n\n")
    f.write("job_ids=()")
    f.write("\n\n")
    f.write("for ((j=1;j<="+str(n_jobs_sim)+";j++)) ; do")
    f.write("\n")
    if on_cluster:
        f.write("\n")
        f.write("running_states=(\\")
        f.write("\n")
        for running_state in running_states:
            f.write("\""+running_state+"\" \\")
            f.write("\n")
        f.write(")")
        f.write("\n\n")
        f.write("stopping_states=(\\")
        f.write("\n")
        for stopping_state in stopping_states:
            f.write("\""+stopping_state+"\" \\")
            f.write("\n")
        f.write(")")
        f.write("\n\n")
        f.write("\t job_id=$( sbatch \\")
        f.write("\n")
        f.write("--output="+args.path+"/sim_output/sim_outputs/slurm-%j.out \\")
        f.write("\n")
        f.write(results_dir+"/simulate_batch.sh \\")
        f.write("\n")
        f.write("| awk '{print $4}')")
        f.write("\n")
        f.write("\t job_ids+=(\"$job_id\")")
        f.write("\n")
        f.write("done")
        
        
        
        # f.write("\n sleep 10")
        f.write("\n\n")
        f.write("\n echo Simulation in progress. Run squeue -u \" $USER\" to see status. ")
        f.write("\n continue=1")
        f.write("\n while [[ $continue == 1 ]] ; do")
        
        f.write("\n \t sleep 5")
        f.write("\n \t continue=0")
        f.write("\n \t for job_id in \"${job_ids[@]}\" ; do")
        f.write("\n \t \t state_str=$( sacct --noheader --format=State --jobs=$job_id )")
        f.write("\n \t \t IFS=' ' read -ra state <<< $state_str")
        
        f.write("\n \t \t for running_state in \"${running_states[@]}\" ; do")
        # f.write("\n \t \t \t echo \"running_state: $running_state\"")
        # f.write("\n \t \t \t echo \"State: $state\"")
        f.write("\n \t \t \t if [[ $state == $running_state ]] ; then")
        f.write("\n \t \t \t \t continue=1")
        f.write("\n \t \t \t \t break")
        f.write("\n \t \t \t fi")
        f.write("\n \t \t done")
        f.write("\n\n")
        
        
        f.write("\n \t \t if [[ $continue == 0 ]] ; then")
        f.write("\n \t \t \t recognized=0")
        f.write("\n \t \t \t for stopping_state in \"${stopping_states[@]}\" ; do")
        # f.write("\n \t \t \t \t echo \"stopping_state: $stopping_state\"")
        # f.write("\n \t \t \t \t echo \"State: $state\"")
        f.write("\n \t \t \t \t if [[ $state == $stopping_state ]] ; then")
        f.write("\n \t \t \t \t \t recognized=1")
        f.write("\n \t \t \t \t fi")
        f.write("\n \t \t \t done")
        f.write("\n")
        f.write("\n \t \t \t if [[ $recognized == 0 ]] ; then")
        f.write("\n \t \t \t \t continue=1")
        f.write("\n \t \t \t \t echo WARNING: job $job_id is in unrecognized state: $state. Simulation will not abort while this persists.")
        f.write("\n \t \t \t fi")
        f.write("\n \t \t fi")
        f.write("\n \t done")
        f.write("\n done")
        f.write("\n echo Finished simulating!")
        f.write("\n\n")
        
        
        
        
        # f.write("\n \t for job_id in \"${job_ids[@]}\" ; do")
        # f.write("\n \t \t state_str=$( sacct --noheader --format=State --jobs=$job_id )")
        # f.write("\n \t \t echo $state_str")
        # f.write("\n \t \t echo $((job_id-2))")
        # f.write("\n \t \t echo $( sacct --noheader --format=State --jobs=$((442322+5)) )")
        # f.write("\n \t \t IFS=' ' read -ra state <<< $state_str")
        # # f.write("\n echo \" IFS=' ' read -ra state <<< $(sacct --noheader --format=State --jobs=$job_id)\"")
        # f.write("\n \t \t echo \"${state[@]}\"")
        # f.write("\n")
        # f.write("\n \t \t for stopping_state in \"${stopping_states[@]}\" ; do")
        # f.write("\n \t \t \t echo \"Stopping_state: $stopping_state\"")
        # f.write("\n \t \t \t echo \"State: $state\"")
        # f.write("\n \t \t \t if [[ $state == $stopping_state ]] ; then")
        # f.write("\n \t \t \t \t continue=0")
        # f.write("\n \t \t \t \t break")
        # f.write("\n \t \t \t fi")
        # f.write("\n \t \t done")
        # f.write("\n\n")
        # f.write("\n \t \t if [[ $continue == 1 ]] ; then")
        # f.write("\n \t \t \t for running_state in \"${running_states[@]}\" ; do")
        # f.write("\n \t \t \t \t echo \"Running_state: $running_state\"")
        # f.write("\n \t \t \t \t echo \"State: $state\"")
        # f.write("\n \t \t \t \t if [[ $state != $running_state ]] ; then")
        # f.write("\n \t \t \t \t \t echo WARNING: job is in unrecognized state: $state. Run \"squeue -u $USER\" for more info.")
        # f.write("\n \t \t \t \t \t break")
        # f.write("\n \t \t \t \t fi")
        # f.write("\n \t \t \t done")
        # f.write("\n \t \t else")
        # f.write("\n \t \t \t echo $job_id")
        # f.write("\n \t \t \t sleep 5")
        # f.write("\n \t \t fi")
        # f.write("\n \t done")
        # f.write("\n done")
        # f.write("\n echo done.")
        # f.write("\n\n")
    
    else:
        f.write(". "+results_dir+"/simulate_batch.sh")
        f.write("\n")
        f.write("done")
        f.write("\n\n")
        f.write("echo done.")
        
    f.write("\n\n")
    f.write("exit")
    
    f.close()
    
    
    
    
    
    
    
    
    
    
    
    
    
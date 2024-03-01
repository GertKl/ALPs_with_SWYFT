#!/bin/bash





set -o errexit  # Exit the script on any error

#set -o nounset  # Treat any unset variables as an error

module --quiet purge  # Reset the modules to the system default

# Set the ${PS1} (needed in the source of the Anaconda environment)

export PS1=\$

module load Miniconda3/22.11.1-1

source ${EBROOTMINICONDA3}/etc/profile.d/conda.sh

conda deactivate &>/dev/null

conda activate /fp/homes01/u01/ec-gertwk/.conda/envs/swyft4-dev



python /fp/homes01/u01/ec-gertwk/ALPs_with_SWYFT/cluster_runs/analysis_results/first/config_simulate_batch.py -path /fp/homes01/u01/ec-gertwk/ALPs_with_SWYFT/cluster_runs/analysis_results/first

chmod +x /fp/homes01/u01/ec-gertwk/ALPs_with_SWYFT/cluster_runs/analysis_results/first/simulate_batch.sh

job_ids=()

for ((j=1;j<=2;j++)) ; do

running_states=(\
"PENDING" \
"RUNNING" \
"SUSPENDED" \
)

stopping_states=(\
"FAILED" \
"CANCELLED" \
"COMPLETED" \
"TIMEOUT" \
"PREEMPTED" \
"NODE_FAIL" \
"OUT_OF_MEMORY" \
)

	 job_id=$( sbatch \
--output=/fp/homes01/u01/ec-gertwk/ALPs_with_SWYFT/cluster_runs/analysis_results/first/sim_output/sim_outputs/slurm-%j.out \
/fp/homes01/u01/ec-gertwk/ALPs_with_SWYFT/cluster_runs/analysis_results/first/simulate_batch.sh \
| awk '{print $4}')
	 job_ids+=("$job_id")
done


 echo Simulation in progress. Run squeue -u " $USER" to see status. 
 continue=1
 while [[ $continue == 1 ]] ; do
 	 sleep 5
 	 continue=0
 	 for job_id in "${job_ids[@]}" ; do
 	 	 state_str=$( sacct --noheader --format=State --jobs=$job_id )
 	 	 IFS=' ' read -ra state <<< $state_str
 	 	 for running_state in "${running_states[@]}" ; do
 	 	 	 if [[ $state == $running_state ]] ; then
 	 	 	 	 continue=1
 	 	 	 	 break
 	 	 	 fi
 	 	 done


 	 	 if [[ $continue == 0 ]] ; then
 	 	 	 recognized=0
 	 	 	 for stopping_state in "${stopping_states[@]}" ; do
 	 	 	 	 if [[ $state == $stopping_state ]] ; then
 	 	 	 	 	 recognized=1
 	 	 	 	 fi
 	 	 	 done

 	 	 	 if [[ $recognized == 0 ]] ; then
 	 	 	 	 continue=1
 	 	 	 	 echo WARNING: job $job_id is in unrecognized state: $state. Simulation will not abort while this persists.
 	 	 	 fi
 	 	 fi
 	 done
 done
 echo Finished simulating!



exit
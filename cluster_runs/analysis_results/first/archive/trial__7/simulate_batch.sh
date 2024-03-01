#!/bin/bash



#SBATCH --job-name=ALP_simulations
#SBATCH --account=ec12
#SBATCH --time=00-00:10:00
#SBATCH --partition=normal
#SBATCH --mem-per-cpu=5G
#SBATCH --qos=devel


set -o errexit  # Exit the script on any error

#set -o nounset  # Treat any unset variables as an error

module --quiet purge  # Reset the modules to the system default

# Set the ${PS1} (needed in the source of the Anaconda environment)

export PS1=\$

module load Miniconda3/22.11.1-1

source ${EBROOTMINICONDA3}/etc/profile.d/conda.sh

conda deactivate &>/dev/null

conda activate /fp/homes01/u01/ec-gertwk/.conda/envs/swyft4-dev



python /fp/homes01/u01/ec-gertwk/ALPs_with_SWYFT/cluster_runs/analysis_results/first/simulate_batch.py -path /fp/homes01/u01/ec-gertwk/ALPs_with_SWYFT/cluster_runs/analysis_results/first



exit
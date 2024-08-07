#!/bin/bash

# Aim:


# Conclusion:

# 



#-----------------------------------------------------------------------------------------------
#---------- Environment configuration ----------------------------------------------------------
#-----------------------------------------------------------------------------------------------

on_cluster=hepp			# Which cluster to run on. Options: "local", "fox" or "hepp" 
					# Local is for a PC, fox is for a slurm cluster, and hepp for
					# a cluster with out a queueing system, but where conda is
					# loaded via '$module load' command. 

conda_env=swyft4-dev			# Name of conda-env. with the necessary installations

parent_directory=$FOML3 					# Directory containing /cluster_runs,
								# per default called ALPs_with_SWYFT

analysis_scripts_location=$FOML3/analysis_scripts/ALP_sim  	# Location of /analysis_scripts


#-----------------------------------------------------------------------------------------------
#---------- SERIES PARAMETERS (Must NOT be changed when re-running) ----------------------------
#-----------------------------------------------------------------------------------------------

# -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  - 
# Technical

update_config=" 1 "          # Whether to update the configuration parameters on re-run or not. 

update_config_on_cluster=" 0 "   # Whether to update the configuration parameters using the cluster
max_memory_config=" 5 "	  # queueing system (if $on_cluster=fox), or without. 
max_time_config=" 00-00:00:05 "
partition_config=" normal "
qos_config=" devel "


run_name="flare0_semi_informed"       # Name of the series (of runs), identifying the results folder. If
			    # this isn't changed on re-run, results will be over-written, or
			    # added to, depending on further configuration. 
	
				
account=" ec12 "           # Mostly redundant, should always be ec12. 


# -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  - 
# Physical model configuration 

update_physics=" 1 "		# If 0, loads physics-related configuration (everything from here
				# to "Technical parameters") from previous runs, unless this is
				# the first run. 

save_physics=" 0 "             # if $update_physics=1, $save_physics=0 results in the deletion
				# of the old configuration on re-run, rather than archiving. 


model="            	      " # Which model to analyze
				# Options: 		
				
				#	"", 			(ALP signature in gamma-spectrum)
				#	"spectral_fit", 	(Gamma-spectrum without ALPs)
				#	"spectral_fit_log", 	(Spectrum with log-scale params)
				#	"toy_line"		(Toy model of form data=ax+b)
				#	"toy_sine" 		(Toy model with data=sinusoidal)


nbins="              90     " # Bins: Number of bins in spectrum
nbins_etrue="        180     " # Bins: Number of bins in spectrum

emin="               2e1     " # minimum energy in GeV
emax="               6e3     " # maximum energy in GeV
  

livetime="            10     " # Livetime; observation time of telescope in hours.

ALP_seed="          None     " # Seed for random B-field configurations. None if random seed. 

floor_exp="        -1.15     " # Minimum value of any bin in expected (log-)(residual)counts 

floor_obs="        -1.15     " # Minimum value of any bin in observed (log-)(residual)counts  


IRF_file="$FOML3/IRFs/CTA/Prod5-North-20deg-AverageAz-4LSTs09MSTs.180000s-v0.1.fits"   # Location of IRF file

     	
		

# Model parameter configuration

POI_indices="     0,1,2,3,4    " # Which parameters to analyze for 
				# (e.g. "0,1,3" for 3 parameters, excluding parameter of index 2;
				# NOTE: counting ONLY those parameters where the value isn't fixed!)


# Model parameters:

# 	 Bounds         | Obs.   |Null-hyp|log?|    prior form  |name         |  unit 	
#      -------------------------------------------------------------------
			
param1=" [-2 , 4]      | -6     | -6     | 1 | U               |    m        |     nev      " # mass m in neV
param2=" [-2 , 1]      | -5     | -5     | 1 | U               |    g        | e-11GeV^{-1} " # coupling constant g in 10^(-11) /GeV

param3=" [-10.2,-8.0]  | -8.812 | -8.812 | 1 | U               | Amplitude   |              " # Amplitude of power law, in "TeV-1 cm-2 s-1" 
param4=" [0,4]         | 2.11   | 2.11   | 0 | U               | index       |              " # Spectral index of the PWL 
param5=" 300           | 300    | 300    | 0 | U               | E0          |              " # Reference energy (?) E0, In GeV
param6=" [1 , 4]       | 2.75   | 2.75   | 1 | U               | Ecut        |              " # Cut-off energy Ecut, in GeV 

param7=" [3.8,165]     | 25     | 25     | 0 | U               | rms_B       |              " # rms of B field, default = 10.
param8=" [34,61]       | 46     | 46     | 0 | U               | e_norm      |              " # normalization of electron density, default = 39.
param9=" [2.7,6.4]     | 4.05   | 4.05   | 0 | U               | e_norm_2    |              " # second normalization of electron density, see Churazov et al. 2003, Eq. 4, default = 4.05
param10=" [300,1000]   | 500    | 500    | 0 | U               | cluster_ext |     kpc      " # extension of the cluster, default = 500.
param11=" [25,129]     | 57     | 57     | 0 | U               | e_dens_1    |     kpc      " # electron density parameter, see Churazov et al. 2003, Eq. 4, default = 80.
param12=" [90,797]     | 268    | 268    | 0 | U               | e_dens_2    |     kpc      " # electron density parameter, see Churazov et al. 2003, Eq. 4, default = 200.
param13=" [0.6,2.4]    | 1.2    | 1.2    | 0 | U               | e_dens_3    |              " # electron density parameter, see Churazov et al. 2003, Eq. 4, default = 1.2
param14=" [0.38,1.24]  | 0.69   | 0.69   | 0 | U               | e_dens_4    |              " # electron density parameter, see Churazov et al. 2003, Eq. 4, default = 0.58
param15=" [0.13,3.04]  | 0.62   | 0.62   | 0 | U               | B_scaling   |              " # scaling of B-field with electron denstiy, default = 0.5
param16=" [-1.22,0.39] | -0.41  | -0.41  | 1 | U               | Max_turb    |              " # maximum turbulence scale in kpc^-1, taken from A2199 cool-core cluster, see Vacca et al. 2012, default = 0.18
param17=" [0.62,1.24]  | 0.93   | 0.93   | 1 | U               | min_turb    |              " # minimum turbulence scale, taken from A2199 cool-core cluster, see Vacca et al. 2012, default = 9. 
param18=" [1.17,3.30]  | 1.97   | 1.97   | 0 | U               | turb_index  |              " # turbulence spectral index, taken from A2199 cool-core cluster, see Vacca et al. 2012, default = 2.80  



obs_seed=" 0 "			# Random seed for statistical fluctuations of mock observation




#-----------------------------------------------------------------------------------------------
#-------- TECHNICAL PARAMETERS (may be changed when re-running) --------------------------------
#-----------------------------------------------------------------------------------------------


n_truncations=" 3 "			# How many times to truncate the priors, and re-train
					# the neural network. 
use_old_truncations=" 1 "              # Whether to remember previous truncations on re-run. 
						  
retrain_last_round=" 1 "                # If use_old_truncations=1 and all truncations are already
                                        # finished, retrain_last_round=1 will rerun training
                                        # for the last round

# -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  - 
# Simulation parameters	


use_old_sims=" 1 "                    # Whether to load simulations from previous run on re-run (=1),
				       # or from a separate place (=path), or start from scratch (=0).
save_old_sims=" 0 "		       # If 0, old simulations are deleted on re-run, rather than
				       # archived, unless $use_old_sims=1.
simulate=" 0 "                        # Whether or not to simulate at all. 

n_sim_train=" 10_000, 10_000, 100_000, 1_000_000  "    # Number of simulations for training (split into traiing
					# and testing set automatically). Comma-separated values
					# indicate different numbers of sims for corresponding
					# truncaitons. 
					
n_sim_coverage=" 10_000 "		# Number of simulations for coverage tests. 

n_sim_explim=" 1_000 "                   # Number of simulations for expected limits

n_prior_samples=" 400_000 "          # Number of prior samples to draw for posterior histograms

partition_sim=" normal "		# Usually "normal", since simulation doesn't use GPUs. 
devel_sim=" 0 "		 	# if yes, jobs run sooner, but max walltime is 2h. 

n_jobs_sim=" 100 "		        # Number of jobs to share simulation over
max_memory_sim=" 25 "			# Total memory per job, in GB, must be integer
max_time_sim=" 01-00:00:00 "		# Max walltime per job ("dd-hh:mm:ss")  

# -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  - 
# Training, inference and validation parameters

use_old_net=" 1 "                     # Whether to load simulations from previous run on re-run (=1),
				       # or start from scratch (=0).
continue_training=" 0 "				       
				       
save_old_net=" 1 "                    # If 0, old net is deleted on re-run, rather than
				       # archived, unless $use_old_net=1.
train=" 1 "                           # Whether to train at all. 

draw_DRP=" 0 "                        # Whether to dra samples for use during DRP-validation. 


architecture=" $FOML3/analysis_scripts/ALP_sim/network_power.py "         # Which architecture-defining 
									   # file to import.  
restricted_posterior=" 0 "             # 0: inference for 1- and 2-dimensional posteriors.
                                       # 1: Only 1D posteriors. 2: Only 2D posteriors. 

train_batch_size_1d=" 512 "		# Batch size during training (for 1D and 2D posteriors) 
max_epochs=" 3000 "  


                                       # Hyperparameters for neural network (new ones can be defined
                                       # analogously). Comma-separated variables imply grid-testing. 
hyperparams=" 	--learning_rate (float) : 5e-3  \
		--stopping_patience (int): 30   \
		--blocks (int): 2		 \
		--features (int): 128 	 \
		--dropout (float): 0.1	 \
		--data_features (int): 64  \
		--power_features (int): 4  \
"	



start_grid_test_at_count=" 0 "         # re-start a grid test at that grid point number


gpus=" 1 "   				# Request GPU from cluster, yes or no
partition_train=" accel "  		# "normal", "accel" (if GPU), "accel_long" (GPU & time>1d)
devel_train=" 0 "			# if yes, jobs run sooner, but max walltime is 2h.

max_memory_train=" 50 "		# Total memory per job, in GB, must be integer
max_time_train=" 00-04:30:00 "	# Max walltime ("dd-hh:mm:ss")



prediction_pairs="  (0,1)            "

                                      # under implementation
DRP_coverage_parameters="      10000	 |   1000  |   0    |   1    |  5     ,\
				  2	 |    1    |  100   |   1    |  1	 "







#-----------------------------------------------------------------------------------------------
#------------------------------------- Execution -----------------------------------------------
#-----------------------------------------------------------------------------------------------

# Declaring some derived variables
results_parent_dir=$PWD/analysis_results
results_dir=$results_parent_dir/$run_name
#n_sim=$(($n_sim_train+$n_sim_coverage))

# Running analysis
$analysis_scripts_location/run_swyft_analysis_truncation.sh \
"\
config_file=$0 ;\
on_cluster=$on_cluster ;\
start_dir=$PWD ;\
results_parent_dir=$results_parent_dir ;\
results_dir=$results_dir ;\
conda_env=$swyft_env ;\
parent_directory=$parent_directory ;\
scripts_dir=$analysis_scripts_location ;\
safe_directory=$safe_directory  ;\
update_config=$update_config=int ;\
update_config_on_cluster=$update_config_on_cluster=int ;\
max_memory_config=$max_memory_config ;\
max_time_config=$max_time_config ;\
partition_config=$partition_config ;\
qos_config=$qos_config ;\
run_name=$run_name  ;\
gpus=$gpus=int  ;\
dirstore=$dirstore  ;\
account=$account  ;\
update_physics=$update_physics=int ;\
save_physics=$save_physics=int ;\
POI_indices=$POI_indices=int ;\
model=$model ;\
nbins=$nbins=int ;\
nbins_etrue=$nbins_etrue=int ;\
emin=$emin=float ;\
emax=$emax=float ;\
livetime=$livetime=float ;\
ALP_seed=$ALP_seed ;\
floor_exp=$floor_exp=float ;\
floor_obs=$floor_obs=float ;\
IRF_file=$IRF_file ;\
model_params=$param1+$param2+$param3+$param4+$param5+$param6+$param7+$param8+$param9+$param10+\
$param11+$param12+$param13+$param14+$param15+$param16+$param17+$param18 ;\
obs_seed=$obs_seed ;\
n_truncations=$n_truncations=int ;\
use_old_truncations=$use_old_truncations=int ;\
retrain_last_round=$retrain_last_round=int ;\
use_old_sims=$use_old_sims ;\
save_old_sims=$save_old_sims=int ;\
simulate=$simulate=int ;\
n_sim_train=$n_sim_train=int ;\
n_sim_coverage=$n_sim_coverage=int ;\
n_sim_explim=$n_sim_explim=int ;\
n_prior_samples=$n_prior_samples=int ;\
partition_sim=$partition_sim ;\
devel_sim=$devel_sim=int ;\
n_jobs_sim=$n_jobs_sim=int ;\
max_memory_sim=$max_memory_sim ;\
max_time_sim=$max_time_sim ;\
use_old_net=$use_old_net ;\
continue_training=$continue_training=int ;\
save_old_net=$save_old_net=int ;\
architecture=$architecture ;\
restricted_posterior=$restricted_posterior=int ;\
train=$train=int ;\
prediction_pairs=$prediction_pairs ;\
draw_DRP=$draw_DRP=int ;\
train_batch_size_1d=$train_batch_size_1d=int ;\
max_epochs=$max_epochs=int ;\
hyperparams=$hyperparams ;\
start_grid_test_at_count=$start_grid_test_at_count=int ;\
partition_train=$partition_train ;\
devel_train=$devel_train=int ;\
max_memory_train=$max_memory_train ;\
max_time_train=$max_time_train ;\
DRP_coverage_parameters=$DRP_coverage_parameters=int ;\
"

#running_states=$running_states ;\
#stopping_states=$stopping_states ;\
# "




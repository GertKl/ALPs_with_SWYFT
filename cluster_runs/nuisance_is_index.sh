#!/bin/bash

# Aim:


# Conclusion:

# 



#-----------------------------------------------------------------------------------------------
#---------- Environment configuration ----------------------------------------------------------
#-----------------------------------------------------------------------------------------------

on_cluster=hepp			# Which cluster to run on. Options: "local", "fox" or "hepp" 

conda_env=swyft4-dev			# Name of conda-env. with the necessary installations

parent_directory=$FOML3 					# Directory containing /cluster_runs 

analysis_scripts_location=$FOML3/analysis_scripts/ALP_sim	# Location of /analysis_scripts

safe_directory=$FOML3/cluster_runs/results


#-----------------------------------------------------------------------------------------------
#---------- SERIES PARAMETERS (Must NOT be changed when re-running) ----------------------------
#-----------------------------------------------------------------------------------------------

# -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  - 
# Technical

update_config=1

update_config_on_cluster=0
max_memory_config=5
max_time_config=00-00:00:05
partition_config=normal
qos_config="devel"


run_name="nuisance_is_index"      # Name of the series (of runs), identifying the results folder
	
				
account=ec12			# Mostly redundant, should always be ec12 


# -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  - 
# Physical model configuration 

update_physics=1		# If 0, loads configuration from previous runs, unless this is
				# the first run. 
save_physics=1


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

ALP_seed="          	0     " # Seed for random B-field configurations. None if random seed. 

floor_exp="        -1.15     " # Minimum value of any bin in expected (log-)(residual)counts 

floor_obs="        -1.15     " # Minimum value of any bin in observed (log-)(residual)counts  


IRF_file="$FOML3/IRFs/CTA/Prod5-North-20deg-AverageAz-4LSTs09MSTs.180000s-v0.1.fits"   # Location of IRF file

     	
		

# Model parameter configuration

POI_indices="     0,1,2        " # Which parameters to analyze for 
				# (e.g. "0,1,3" for 3 parameters, excluding parameter of index 2;
				# NOTE: counting ONLY those parameters where the value isn't fixed!)



# 	   Simulated | Observed | Null-hyp.| is log? | name         |  unit 	
#      -------------------------------------------------------------------
			
param1="   [-2 : 4]         |    10    |   -6    |    1    |    m        |     nev     " # mass m in neV
param2="   [-2 : 1]         |    10    |   -5    |    1    |    g        | e-11GeV^{-1} " # coupling constant g in 10^(-11) /GeV
param3="    -8.812          |    10    | -8.812  |    1    | Amplitude   |             " # Amplitude of power law, in "TeV-1 cm-2 s-1" 
param4="  [1.5:2.4]         |    10    |  2.11   |    0    | index       |             " # Spectral index of the PWL 
param5="     300            |    10    |   300   |    0    | E0          |             " # Reference energy (?) E0, In GeV
param6="     2.75           |    10    |  2.75   |    1    | Ecut        |             " # Cut-off energy Ecut, in GeV 
param7="      25            |    10    |   25    |    0    | rms_B       |             " # rms of B field, default = 10.
param8="      39            |    10    |   39    |    0    | e_norm      |             " # normalization of electron density, default = 39.
param9="     4.05           |    10    |  4.05   |    0    | e_norm_2    |             " # second normalization of electron density, see Churazov et al. 2003, Eq. 4, default = 4.05
param10="    500            |    10    |  500    |    0    | cluster_ext |     kpc     " # extension of the cluster, default = 500.
param11="     80            |    10    |   80    |    0    | e_dens_1    |             " # electron density parameter, see Churazov et al. 2003, Eq. 4, default = 80.
param12="     280           |    10    |  280    |    0    | e_dens_2    |             " # electron density parameter, see Churazov et al. 2003, Eq. 4, default = 200.
param13="     1.2           |    10    |  1.2    |    0    | e_dens_3    |             " # electron density parameter, see Churazov et al. 2003, Eq. 4, default = 1.2
param14="    0.58           |    10    |  0.58   |    0    | e_dens_4    |             " # electron density parameter, see Churazov et al. 2003, Eq. 4, default = 0.58
param15="     0.5           |    10    |  0.5    |    0    | B_scaling   |             " # scaling of B-field with electron denstiy, default = 0.5
param16="    0.18           |    10    |  0.18   |    0    | Max_turb    |             " # maximum turbulence scale in kpc^-1, taken from A2199 cool-core cluster, see Vacca et al. 2012, default = 0.18
param17="      9            |    10    |    9    |    0    | min_turb    |             " # minimum turbulence scale, taken from A2199 cool-core cluster, see Vacca et al. 2012, default = 9. 
param18="    2.8            |    10    |  2.8    |    0    | turb_index  |             " # turbulence spectral index, taken from A2199 cool-core cluster, see Vacca et al. 2012, default = 2.80 






#-----------------------------------------------------------------------------------------------
#-------- TECHNICAL PARAMETERS (may be changed when re-running) --------------------------------
#-----------------------------------------------------------------------------------------------

							  
# -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  - 
# Simulation parameters	


use_old_sims=1  # $FOML3/cluster_runs/storee/storicist
save_old_sims=0
simulate=1


n_sim_train=1000000			# Number of simulations for training (split into traiing
					# and testing set automatically)
n_sim_coverage=100000			# Number of simulations for coverage tests. 

partition_sim=normal			# Usually "normal", since simulation doesn't use GPUs. 
devel_sim=0				# if yes, jobs run sooner, but max walltime is 2h. 

n_jobs_sim=100				# Number of jobs to share simulation over
max_memory_sim=10			# Total memory per job, in GB, must be integer
max_time_sim=01-00:00:00		# Max walltime per job ("dd-hh:mm:ss")   


# -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  - 
# Training, inference and validation parameters

use_old_net=0
save_old_net=1
train=1


architecture=""
restricted_posterior=0

train_batch_size_1d=4096 		# Batch size during training (for 1D and 2D posteriors) 
max_epochs=3000
stopping_patience=20


gpus=1					# Request GPU from cluster, yes or no
partition_train=accel			# "normal", "accel" (if GPU), "accel_long" (GPU & time>1d)
devel_train=0				# if yes, jobs run sooner, but max walltime is 2h.

max_memory_train=50			# Total memory per job, in GB, must be integer
max_time_train=00-04:30:00		# Max walltime ("dd-hh:mm:ss")


# -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  - 
# Inference 

infer=1				# Whether to do any inference
infer_1d=1 				# Whether to do inference for 1D posteriors
infer_2d=0 				# Whether to do inference for 2D posteriors

n_sample_1d=100000 			# Number of samples from 1D posterior (for histograms)
n_sample_2d=100000 			# Number of samples from 2D posterior (for histograms)

sample_batch_size_1d=10		# Batch size when sampling. Related to memory-use of
sample_batch_size_2d=10		# processing units, I think.

plot_1d=1				# Whether to plot 1D histograms
plot_corner=0				# Whether to plot corner-plot (incl. 2D histogram)

color_truth="        1,0,1           " # Color to indicate the observed value with

#-----------------------------------------------------------------------------------------------
#------------------------------------- Execution -----------------------------------------------
#-----------------------------------------------------------------------------------------------

# Declaring some derived variables
results_parent_dir=$PWD/analysis_results
results_dir=$results_parent_dir/$run_name

# Some helpful lists for the pipeline to know. 

#stopping_states="\
#FAILED ,\
#CANCELLED ,\
#CANCELLED+ ,\
#COMPLETED ,\
#TIMEOUT ,\
#PREEMPTED ,\
#NODE_FAIL ,\
#OUT_OF_MEMORY \
#"

#running_states="\
#PENDING ,\
#RUNNING ,\
#SUSPENDED \
#"




# Running analysis
$analysis_scripts_location/run_swyft_analysis.sh \
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
model_params=$param1,$param2,$param3,$param4,$param5,$param6,$param7,$param8,$param9,$param10,\
$param11,$param12,$param13,$param14,$param15,$param16,$param17,$param18 ;\
use_old_sims=$use_old_sims ;\
save_old_sims=$save_old_sims=int ;\
simulate=$simulate=int ;\
n_sim_train=$n_sim_train=int ;\
n_sim_coverage=$n_sim_coverage=int ;\
n_sim=$(($n_sim_train+$n_sim_coverage))=int ;\
partition_sim=$partition_sim ;\
devel_sim=$devel_sim=int ;\
n_jobs_sim=$n_jobs_sim=int ;\
max_memory_sim=$max_memory_sim ;\
max_time_sim=$max_time_sim ;\
use_old_net=$use_old_net=int ;\
save_old_net=$save_old_net=int ;\
architecture=$architecture ;\
restricted_posterior=$restricted_posterior=int ;\
train=$train=int ;\
train_batch_size_1d=$train_batch_size_1d=int ;\
max_epochs=$max_epochs=int ;\
stopping_patience=$stopping_patience=int ;\
partition_train=$partition_train ;\
devel_train=$devel_train=int ;\
max_memory_train=$max_memory_train ;\
max_time_train=$max_time_train ;\
infer=$infer=int ;\
infer_1d=$infer_1d=int ;\
infer_2d=$infer_2d=int ;\
n_sample_1d=$n_sample_1d=int ;\
n_sample_2d=$n_sample_2d=int ;\
sample_batch_size_1d=$sample_batch_size_1d=int ;\
sample_batch_size_2d=$sample_batch_size_2d=int ;\
plot_1d=$plot_1d=int ;\
plot_corner=$plot_corner=int ;\
color_truth=$color_truth=float ;\
"

#running_states=$running_states ;\
#stopping_states=$stopping_states ;\
# "



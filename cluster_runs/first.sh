#!/bin/bash

# Aim:


# Conclusion:

# 



#-----------------------------------------------------------------------------------------------
#---------- Environment configuration ----------------------------------------------------------
#-----------------------------------------------------------------------------------------------

cluster=1				# Whether to run on slurm cluster. Runs locally if 0. 

conda_env=swyft4-dev			# Name of conda-env. with the necessary installations

parent_directory=$FOML3 					# Directory containing /cluster_runs 
analysis_scripts_location=$FOML3/analysis_scripts/ALP_sim	# Location of /analysis_scripts
safe_directory=$FOML3/cluster_runs/results


#-----------------------------------------------------------------------------------------------
#---------- SERIES PARAMETERS (Must NOT be changed when re-running) ----------------------------
#-----------------------------------------------------------------------------------------------

# -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  - 
# Technical

run_name="first" 		# Name of the series (of runs), identifying the results folder




gpus=1				# Request GPU from cluster, yes or no



dirstore="0"			# If 1, operates with simulations on disk during simulation and,
				# otherwise in RAM. 
				
				
account=ec12			# Mostly redundant, should always be ec12 


# -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  - 
# Model configuration 

update_model=1

model1="            	      " # Which model to analyze
				# Options: 		
				
				#	"", 			(ALP signature in gamma-spectrum)
				#	"spectral_fit", 	(Gamma-spectrum without ALPs)
				#	"spectral_fit_log", 	(Spectrum with log-scale params)
				#	"toy_line"		(Toy model of form data=ax+b)
				#	"toy_sine" 		(Toy model with data=sinusoidal)
				

model2="              10     " # Bins: Number of bins in spectrum 

model3="             300     " # Livetime; observation time of telescope in hours.

model4="               0     " # Seed for random B-field configurations. None if random seed. 


IRF_file="$FOML3/IRFs/CTA/Prod5-North-20deg-AverageAz-4LSTs09MSTs.180000s-v0.1.fits"

model5=$IRF_file       # Location of IRF file
				






# Model parameter configuration

update_params=1

POI_indices="     0          " # Which parameters to analyze for 
				# (e.g. "0:1:3" for 3 parameters, excluding parameter of index 2;
				# counting those parameters where the value isn't fixed)



# 	      Simulated    ::    Observed    ::    Null-hyp.   ::     is log?     	
#            ----------------------------------------------------------------------
			
param1=" 	  10       ::       10       ::       10       ::        0         " # mass m in neV
param2=" 	  10       ::       10       ::       10       ::        0         " # coupling constant g in 10^(-11) /GeV

param3=" 	  10       ::       10       ::       10       ::        0         " # Amplitude of power law, in "TeV-1 cm-2 s-1" 
param4=" 	  10       ::       10       ::       10       ::        0         " # Spectral index of the PWL 
param5=" 	  10       ::       10       ::       10       ::        0         " # Reference energy (?) E0, In GeV
param6=" 	  10       ::       10       ::       10       ::        0         " # Cut-off energy Ecut, in GeV 

param7=" 	  10       ::       10       ::       10       ::        0         " # rms of B field, default = 10.
param8=" 	  10       ::       10       ::       10       ::        0         " # normalization of electron density, default = 39.
param9=" 	  10       ::       10       ::       10       ::        0         " # second normalization of electron density, see Churazov et al. 2003, Eq. 4, default = 4.05
param10=" 	  10       ::       10       ::       10       ::        0         " # extension of the cluster, default = 500.
param11=" 	  10       ::       10       ::       10       ::        0         " # electron density parameter, see Churazov et al. 2003, Eq. 4, default = 80.
param12=" 	  10       ::       10       ::       10       ::        0         " # electron density parameter, see Churazov et al. 2003, Eq. 4, default = 200.
param13=" 	  10       ::       10       ::       10       ::        0         " # electron density parameter, see Churazov et al. 2003, Eq. 4, default = 1.2
param14=" 	  10       ::       10       ::       10       ::        0         " # electron density parameter, see Churazov et al. 2003, Eq. 4, default = 0.58
param15=" 	  10       ::       10       ::       10       ::        0         " # scaling of B-field with electron denstiy, default = 0.5
param16=" 	  10       ::       10       ::       10       ::        0         " # maximum turbulence scale in kpc^-1, taken from A2199 cool-core cluster, see Vacca et al. 2012, default = 0.18
param17=" 	  10       ::       10       ::       10       ::        0         " # minimum turbulence scale, taken from A2199 cool-core cluster, see Vacca et al. 2012, default = 9. 
param18=" 	  10       ::       10       ::       10       ::        0         " # turbulence spectral index, taken from A2199 cool-core cluster, see Vacca et al. 2012, default = -2.80 







#-----------------------------------------------------------------------------------------------
#-------- TECHNICAL PARAMETERS (may be changed when re-running) --------------------------------
#-----------------------------------------------------------------------------------------------

							  
# -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  - 
# Simulation parameters	

simulate=1
sim_from_scratch=0

n_sim=100 				# Number of simulations


partition_sim=normal			# Usually "normal", since simulation doesn't use GPUs. 
devel_sim=1				# if yes, jobs run sooner, but max walltime is 2h. 

n_jobs_sim=2				# Number of jobs to share simulation over
max_memory_sim=5			# Total memory per job, in GB, must be integer
max_time_sim=00-00:10:00		# Max walltime per job ("dd-hh:mm:ss")   


# -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  - 
# Training parameters

train=1
train_1d=1				# Whether to train for 1D-posteriors
train_2d=0				# Whether to train for 2D posteriors
train_from_scratch_1D=0		# Train from scratch? If True, overwrites net, if one
train_from_scratch_2D=0		# already exists. Corresponding to 1D- and 2D posteriors. 

	
train_batch_size_1d=10			# Batch size during training (for 1D and 2D posteriors) 
train_batch_size_2d=10			# Must be lower than nsim, preferably a multiple. 
learning_rate_1d=1e-3                  # Learning rate during training (for 1D and 2D posteriors)
learning_rate_2d=1e-3                  # Must be lower than nsim, preferably a multiple. 


partition_train=accel			# "normal", "accel" (if GPU), "accel_long" (GPU & time>1d)
devel_train=1				# if yes, jobs run sooner, but max walltime is 2h.

max_memory_train=40			# Total memory per job, in GB, must be integer
max_time_train=00-00:10:00		# Max walltime ("dd-hh:mm:ss")


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




#-----------------------------------------------------------------------------------------------
#------------------------------------- Execution -----------------------------------------------
#-----------------------------------------------------------------------------------------------

# Declaring some derived variables
results_parent_dir=$PWD/analysis_results
results_dir=$results_parent_dir/$run_name

# Running analysis
$analysis_scripts_location/run_swyft_analysis.sh \
"\
cluster=$cluster ;\
start_dir=$PWD ;\
results_parent_dir=$results_parent_dir ;\
results_dir=$results_dir ;\
conda_env=$swyft_env ;\
parent_directory=$parent_directory ;\
scripts_dir=$analysis_scripts_location ;\
safe_directory=$safe_directory  ;\
run_name=$run_name  ;\
gpus=$gpus  ;\
dirstore=$dirstore  ;\
account=$account  ;\
update_model=$update_model ;\
POI_indices=$POI_indices ;\
model_config=$model1,$model2,$model3,$model4,$model5 ;\
update_params=$update_params ;\
model_params=$param1,$param2,$param3,$param4,$param5,$param6,$param7,$param8,$param9,$param10,\
$param11,$param12,$param13,$param14,$param15,$param16,$param17,$param18 \
simulate=$simulate \
sim_from_scratch=$sim_from_scratch \
n_sim=$n_sim \
partition_sim=$partition_sim \
devel_sim=$devel_sim \
n_jobs_sim=$n_jobs_sim \
max_memory_sim=$max_memory_sim \
max_time_sim=$max_time_sim \
train=$train \
train_1d=$train_1d \
train_2d=$train_2d \
train_from_scratch_1D=$train_from_scratch_1D \
train_from_scratch_2D=$train_from_scratch_2D \
train_batch_size_1d=$train_batch_size_1d \
train_batch_size_2d=$train_batch_size_2d \
learning_rate_1d=$learning_rate_1d \
learning_rate_2d=$learning_rate_2d \
partition_train=$partition_train \
devel_train=$devel_train \
max_memory_train=$max_memory_train \
max_time_train=$max_time_train \
infer=$infer \
infer_1d=$infer_1d \
infer_2d=$infer_2d \
n_sample_1d=$n_sample_1d \
n_sample_2d=$n_sample_2d \
sample_batch_size_1d=$sample_batch_size_1d \
sample_batch_size_2d=$sample_batch_size_2d \
plot_1d=$plot_1d \
plot_corner=$plot_corner\
"



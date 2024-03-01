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
# Physical model configuration 

update_config=1		# If 0, loads configuration from previous runs, unless this is
				# the first run. 


model="            	      " # Which model to analyze
				# Options: 		
				
				#	"", 			(ALP signature in gamma-spectrum)
				#	"spectral_fit", 	(Gamma-spectrum without ALPs)
				#	"spectral_fit_log", 	(Spectrum with log-scale params)
				#	"toy_line"		(Toy model of form data=ax+b)
				#	"toy_sine" 		(Toy model with data=sinusoidal)


nbins="              150     " # Bins: Number of bins in spectrum
nbins_etrue="        450     " # Bins: Number of bins in spectrum

emin="               6e1     " # minimum energy in GeV
emax="               3e3     " # maximum energy in GeV
  

livetime="           300     " # Livetime; observation time of telescope in hours.

ALP_seed="             0     " # Seed for random B-field configurations. None if random seed. 

floor_exp="        -1.15     " # Minimum value of any bin in expected (log-)(residual)counts 

floor_obs="        -1.15     " # Minimum value of any bin in observed (log-)(residual)counts  


IRF_file="$FOML3/IRFs/CTA/Prod5-North-20deg-AverageAz-4LSTs09MSTs.180000s-v0.1.fits"   # Location of IRF file

     	
		

# Model parameter configuration

POI_indices="     0,3,7      " # Which parameters to analyze for 
				# (e.g. "0:1:3" for 3 parameters, excluding parameter of index 2;
				# counting those parameters where the value isn't fixed)



# 	   Simulated | Observed | Null-hyp.| is log? | name         |  unit 	
#      -------------------------------------------------------------------
			
param1="     10      |    10    |    10    |    0    |    m        |     nev     " # mass m in neV
param2=" [0.2 : 0.8] |    10    |    10    |    0    |    g        | 1e-11GeV^-1 " # coupling constant g in 10^(-11) /GeV
param3="     10      |    10    |    10    |    0    | Amplitude   |             " # Amplitude of power law, in "TeV-1 cm-2 s-1" 
param4="     10      |    10    |    10    |    0    | index       |             " # Spectral index of the PWL 
param5="     10      |    10    |    10    |    0    | E0          |             " # Reference energy (?) E0, In GeV
param6="     10      |    10    |    10    |    0    | Ecut        |             " # Cut-off energy Ecut, in GeV 
param7="     10      |    10    |    10    |    0    | rms_B       |             " # rms of B field, default = 10.
param8="     10      |    10    |    10    |    0    | e_norm      |             " # normalization of electron density, default = 39.
param9="     10      |    10    |    10    |    0    | e_norm_2    |             " # second normalization of electron density, see Churazov et al. 2003, Eq. 4, default = 4.05
param10="    10      |    10    |    10    |    0    | cluster_ext |     kpc     " # extension of the cluster, default = 500.
param11="    10      |    10    |    10    |    0    | e_dens_1    |             " # electron density parameter, see Churazov et al. 2003, Eq. 4, default = 80.
param12="    10      |    10    |    10    |    0    | e_dens_2    |             " # electron density parameter, see Churazov et al. 2003, Eq. 4, default = 200.
param13="    10      |    10    |    10    |    0    | e_dens_3    |             " # electron density parameter, see Churazov et al. 2003, Eq. 4, default = 1.2
param14="    10      |    10    |    10    |    0    | e_dens_4    |             " # electron density parameter, see Churazov et al. 2003, Eq. 4, default = 0.58
param15="    10      |    10    |    10    |    0    | B_scaling   |             " # scaling of B-field with electron denstiy, default = 0.5
param16="    10      |    10    |    10    |    0    | Max_turb    |             " # maximum turbulence scale in kpc^-1, taken from A2199 cool-core cluster, see Vacca et al. 2012, default = 0.18
param17="    10      |    10    |    10    |    0    | min_turb    |             " # minimum turbulence scale, taken from A2199 cool-core cluster, see Vacca et al. 2012, default = 9. 
param18="    10      |    10    |    10    |    0    | turb_index  |             " # turbulence spectral index, taken from A2199 cool-core cluster, see Vacca et al. 2012, default = -2.80 



#-----------------------------------------------------------------------------------------------
#-------- TECHNICAL PARAMETERS (may be changed when re-running) --------------------------------
#-----------------------------------------------------------------------------------------------

							  
# -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  - 
# Simulation parameters	

import_old_sims=1
simulate=1

n_sim=100 				# Number of simulations


partition_sim=normal			# Usually "normal", since simulation doesn't use GPUs. 
devel_sim=1				# if yes, jobs run sooner, but max walltime is 2h. 

n_jobs_sim=2				# Number of jobs to share simulation over
max_memory_sim=5			# Total memory per job, in GB, must be integer
max_time_sim=00-00:10:00		# Max walltime per job ("dd-hh:mm:ss")   


# -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  - 
# Training parameters

train=1
use_architecture="" 
import_weights=0
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

color_truth="        1,0,1           " # Color to indicate the observed value with

#-----------------------------------------------------------------------------------------------
#------------------------------------- Execution -----------------------------------------------
#-----------------------------------------------------------------------------------------------

# Declaring some derived variables
results_parent_dir=$PWD/analysis_results
results_dir=$results_parent_dir/$run_name

# Running analysis
$analysis_scripts_location/run_swyft_analysis.sh \
"\
cluster=$cluster=int ;\
start_dir=$PWD ;\
results_parent_dir=$results_parent_dir ;\
results_dir=$results_dir ;\
conda_env=$swyft_env ;\
parent_directory=$parent_directory ;\
scripts_dir=$analysis_scripts_location ;\
safe_directory=$safe_directory  ;\
run_name=$run_name  ;\
gpus=$gpus=int  ;\
dirstore=$dirstore  ;\
account=$account  ;\
update_config=$update_config=int ;\
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
simulate=$simulate=int ;\
sim_from_scratch=$sim_from_scratch=int ;\
n_sim=$n_sim=int ;\
partition_sim=$partition_sim ;\
devel_sim=$devel_sim=int ;\
n_jobs_sim=$n_jobs_sim=int ;\
max_memory_sim=$max_memory_sim ;\
max_time_sim=$max_time_sim ;\
train=$train=int ;\
train_1d=$train_1d=int ;\
train_2d=$train_2d=int ;\
train_from_scratch_1D=$train_from_scratch_1D=int ;\
train_from_scratch_2D=$train_from_scratch_2D=int ;\
train_batch_size_1d=$train_batch_size_1d=int ;\
train_batch_size_2d=$train_batch_size_2d=int ;\
learning_rate_1d=$learning_rate_1d=float ;\
learning_rate_2d=$learning_rate_2d=float ;\
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



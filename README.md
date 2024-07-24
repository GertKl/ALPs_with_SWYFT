# Framework for performing Neural Ratio Estimation (NRE) for gamma-ray astronomy

This pipeline implements statistical inference for gamma-ray astronomy, in particular ALP-searches. By using Neural Ratio Estimation, such analyses become computationally feasible without needing to reduce their complexity by applying overconfident constraints. This implementation has been developed with a focus on fluid re- configuration and execution of the analysis. This facilitates experimentation with, and scrutinization of, the application of NRE to our physics case.  

NOTE: The framework is primarily developed for private use, so incompatibilities with different systems can occur. However, the main code usually runs well on linux if following the instructions below. 

# Setup (Cloning from Git)

Open a terminal, navigate to your home directory and type (assuming that you have git installed, I use v2.43.5):

```
git clone --recurse-submodules https://github.com/GertKl/ALPs_with_SWYFT.git
cd ALPs_with_SWYFT/swyft
git checkout master
```

Make sure to include the `--recurse-submodules`-option in the first line. The SWYFT code is imported as a submodule, which is necessary in order to include my changes to the package in the installation. The third line is necessary to make sure that the submodule isn't left hanging in a detached HEAD state. The third line is necessary to make sure that the submodule isn't left hanging in a detached HEAD state. You're basically creating a branch with SWYFT version 0.4.5, including my changes to SWYFT (as opposed to a potentially more recent version, without my changes, which you would get by cloning SWYFT from its master branch).


Note that the repository (the directory ``ALPs_with_SWYFT`` and it's contents) and the submodule (subdirectory ``swyft`` and it's contents) are essentially independent. This means that changes to the two modules have to be commited independently. However, any commits to the submodule (relevant when making changes to the swyft installation) should be followed by commits in the main module as well (otherwise the main module will point to the previous commit of the submodule). For more details, see https://gist.github.com/gitaarik/8735255?permalink_comment_id=2335765. 


## Installation of Swyft


Install conda (if you haven't already), and create a conda environment from the file *env_noswyft.yaml*. The file is found in `ALPs_with_SWYFT/environments`. To create the environment (after installing conda), in the terminal, write:

``` 
conda activate
conda env create --file env_noswyft_wo_wandb.yml --name <your_env_name>
```

To install SWYFT, write:

```
conda acivate <your_env_name>
cd <path_to_SWYFT_clone>
pip install -e .
conda install wandb
```

# Running the analysis

### Short version 

Change the variables in the script `cluster_runs/run.sh`, and run it. When it is done, run the notebook 'analysis_results.ipynb' which appears in the folder `cluster_runs/analysis_results/$run_name`.

### Details

Open a run-script (in `/cluster_runs`), by default called `run.sh` (but it can be called anything), and modify the variables under the heading "Environment configuration". The variables should be self-explanatory (with help of the comments in the file). 

Then modify the parameters under the headings "Series parameters" and "Technical Parameters" according to your needs. In the terminal, move to `cluster_runs`, and run the run-script. For example, in the terminal, write:

```
cd ALPs_with_SWYFT/cluster_runs
./run.sh
```

A new folder containing results and backup files will be created in `cluster_runs/analysis_results`, called whatever the `$run_name`-variable is set to (see run-file). The contained folders are:

    archive		(Earlier outputs and backups, if the same analysis has been run several times)      
    sim_output	(Simulation output)      
    train_output	(Training and posterior estimation output)   
    val_output	(Validation output)   

The "loose" files will be used by the analysis pipeline, and also serve as backup if changes are made. 

To see, and play around with, the results of the analysis, run the notebook `analysis_results.ipynb`. It has been pre-written to access all analysis variables, and to process and visualize central results.   

If you run the run-script again, without changing the variable `$run_name`, the new output will be stored in the same folders. Depending on your configuration in the run-script, the old analysis may be overwritten or built on (e.g. simulations may be added to, and the neural network may be overwritten or training may be continued). Many of the old outputs and backups will be stored in a sub-folder of `archive`, called, for example, `trial__0`. Files belonging to that iteration of the analysis will be indexed correspondingly, e.g. `sim\_output__0.txt`. Files belonging to the next run will be indexed one higher, e.g. `sim\_output__1.sh`.


### Expected Warnings

A scary warning that you can safely ignore during neural network training (thought there may be more):

```
UserWarning: Lightning couldn't infer the indices fetched for your dataloader.
  warning_cache.warn("Lightning couldn't infer the indices fetched for your dataloader.")
```



# Some basics about the pipeline structure

* All the necessary scripts are found in `analysis_scripts/ALP_sim`, which is it's own Git repository.
* The central code for the physical simulations is `ALP_quick_sim.py`, which contains the convenience class `ALP_sim`. The latter can be used to generate and visualize gamma-ray spectra (containing ALP-signals) as well as toy-models, and can be easily extended with more models.
* The run script (e.g. `run.sh`) defines all the user variables, and parses them to `run_swyft_analysis_truncation.sh`
* `run_swyft_analysis_truncation.sh` ensures that the correct file structure is in place, and calls on other scripts. Central scripts are:
  - `set_parameters.py`, which converts variables, for easier processing, and makes them available to other scripts,
  - `run_truncation_rounds.sh`, which executes simulation and neural network training in tandem, for more efficient inference,
  - `simulate_batch.py`, by which simulations are generated (in parallel),
  - `train.py`, by which neural network training and inference is executed,
  - `network.py`, in which a basic, editable, neural network architecture is implemented using the SWYFT framework (based on PyTorch)









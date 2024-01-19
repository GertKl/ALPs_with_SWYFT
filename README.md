# ALPs_with_SWYFT

# Setup

### Cloning from Git

Open a terminal, navigate to your home directory and type (assuming that you have git installed):

```
git clone --recurse-submodules https://github.com/GertKl/NRE_with_Slurm.git
cd NRE_with_Slurm/swyft
```

Make sure to include the "recurse-submodules" option in the first line. The SWYFT code is imported as a submodule, which is necessary in order to include my changes to the package in the installation. The third line is necessary to make sure that the submodule isn't left hanging in a detached HEAD state. 


Note that the repository (the directory ``ALPs_with_SWYFT`` and it's contents) and the submodule (subdirectory ``swyft`` and it's contents) are essentially independent. This means that changes to the two modules have to be commited independently. However, any commits to the submodule (relevant when making changes to the swyft installation) should be followed by commits in the main module as well (otherwise the main module will point to the previous commit of the submodule). For more details, see https://gist.github.com/gitaarik/8735255?permalink_comment_id=2335765. 


# Installation of Swyft


Install conda (if you haven't already), and create a conda environment from the file *env_noswyft.yaml*. The file is found in `ALPs_with_SWYFT/environments`. To create the environment (after installing conda), in the terminal, write:

``` 
conda activate
conda env create --file env_noswyft.yaml --name <your_env_name>
```

To install SWYFT, you can either:

1. If you cloned SWYFT (either as a submodule, or separately, see Setup), in the terminal write:

```
cd <path_to_SWYFT_clone>
pip install -e .
```

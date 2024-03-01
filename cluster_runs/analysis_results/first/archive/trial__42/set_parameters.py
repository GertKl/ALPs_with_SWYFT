#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Thu Feb 22 15:18:47 2024

@author: gert
"""


import argparse
import os
import re
import numpy as np
import json

from ALP_quick_sim import ALP_sim

    
if __name__ == "__main__":
   
    # Parsing results directory path and arguments-string.  
    
    parser = argparse.ArgumentParser(description="")
    
    parser.add_argument("-results_dir", type=str)
    parser.add_argument("-args", type=str)

    args = parser.parse_args()
    
    
    
    # Making basic dict of configuration arguments from raw arguments string. 

    config_dict = {}
    config_list = args.args.split(";")

    for item in config_list:
        
        # Converting argument strings into lists.
        
        config_argument_name_and_value = re.sub(r'\s','',item).split("=")
        print(config_argument_name_and_value)
        print()
        
        is_item_1d=True
        is_row_1d=True
        
        if len(config_argument_name_and_value)>1:
            
            if len(config_argument_name_and_value)>3:
                raise ValueError('Argument name and value defined incorrectly \
                                 in configuration script: ' + item)
            
            config_dict_item = config_argument_name_and_value[1].split(":")
            if len(config_dict_item)>1: is_item_1d=False
            
            for row, item_row in enumerate(config_dict_item):
                
                config_dict_item_row = item_row.split("|")
                if len(config_dict_item_row)>1: is_row_1d=False
                config_dict_item[row] = config_dict_item_row[0] if is_row_1d else config_dict_item_row
                
            config_dict_item = config_dict_item[0] if is_item_1d else config_dict_item
                
            # Converting elements of argument into specified type, if given. 
            if len(config_argument_name_and_value)==3:
                config_dict_item = np.array(config_dict_item).astype(config_argument_name_and_value[2])
                if is_item_1d==0 or is_row_1d==0:
                    config_dict_item = list(config_dict_item)
                else:
                    config_dict_item = getattr(__builtins__, config_argument_name_and_value[2])(config_dict_item)
            

            config_dict[config_argument_name_and_value[0]] = config_dict_item
            
            print( {config_argument_name_and_value[0]:config_dict[config_argument_name_and_value[0]]} )
            print()

    
    
    
    # Formatting selected arguments
    
    
    # Formatting model parameter information. 
    
    model_params = np.array(config_dict['model_params'])
    
    sim_params = list(model_params[:,0])
    bounds = []
    for isp, sim_param in enumerate(sim_params):
        sim_params[isp] = eval(sim_param)
        if isinstance(sim_params[isp], list):
            bounds.append(sim_params[isp])
        elif not isinstance(sim_params[isp], (int, float)):
            raise TypeError("A parameter argument (" + str(sim_params[isp]) + ") was evaluated to an unexpected \
                            type ("+str(type(sim_params[isp]))+")")
        
    obs_params = list(model_params[:,1].astype(float))
    null_params = list(model_params[:,2].astype(float))
    is_log = list(model_params[:,3].astype(int))
    param_names = list(model_params[:,4].astype(str))
    param_units = list(model_params[:,5].astype(str))
    
    config_dict['sim_params'] = sim_params
    config_dict['obs_params'] = obs_params
    config_dict['bounds'] = bounds

    
    # Making a list of prior bounds.
    



    # Creating and formatting ALP_sim object. 
    
    
    print("Initializing new ALP_sim object...", end='')
    A = ALP_sim(set_null=0, set_obs=0)
    print("done.")
    print()

    A.configure_model(
        model=config_dict['model'],
        noise="poisson",
        log_params=is_log,
        null_params=null_params,
        param_names=param_names,
        param_units=param_units,
        ALP_seed=eval(config_dict['ALP_seed']),
        floor=float(config_dict['floor_exp']),
        floor_obs=float(config_dict['floor_obs']), # not reflected in training set of all_larger_bounds
        logcounts=True,
        residuals=True
    )
    
    if config_dict['update_obs']: 
        print("Configuring observations geometry...", end='')
        A.configure_obs(
            nbins = int(config_dict['nbins']),
            nbins_etrue = int(config_dict['nbins_etrue']),
            emin = float(config_dict['emin']),
            emax = float(config_dict['emax']),
            livetime = float(config_dict['livetime']),
            irf_file = config_dict['IRF_file'],
        )
        print("done.")
    
    else: 
        print("Skipping configuration of observations geometry.")
    
    
    config_dict['A'] = A
    
    
     
    
    
    
    print("Params:")
    print(sim_params)
    print(obs_params)
    print(null_params)
    print(is_log)
    print()
    
    print("Config_dict:")
    print()
    print(json.dumps(config_dict, indent=4))

    # print(config_dict)
    # print()
        


    
    
    
    
    
    
    
    
    # # Format marginals-specifying vector

    # marg_temp = eval(args.mod2.replace(":",","))
    # try:
    #     marg = list(marg_temp)
    # except TypeError as Err:
    #     if isinstance(marg_temp, int):
    #         marg = [marg_temp]
    #     else:
    #         raise Err
    


    # # Deconstructing model parameters-information
    
    # param_info_vec = args.params2.replace(" ","").split("::")
    
    
    
    
    # config_objects = {
    #     'A':A, 
    #     'n_sim':n_sim,
    #     'n_cpus':n_cpus, 
    #     'bounds':bounds, 
    #     'truths':truths, 
    #     'simulation_batch_size':simulation_batch_size, 
    #     'store_name':store_name,'
    #     store_dir':store_dir, 
    #     'files_name':files_name, 
    #     'files_dir':files_dir, 
    #     'start_dir':start_dir, 
    #     'conda_env':conda_env,
    #     'slurm':slurm,
    #     'slurm_train':slurm_train, 
    #     'slurm_dir':slurm_dir,
    #     'slurm_dir_on_cluster':slurm_dir_on_cluster, 
    #     'gpus':gpus,'max_time_sim':max_time_sim,
    #     'max_memory_sim':max_memory_sim,
    #     'partition_sim':partition_sim,
    #     'devel_sim':devel_sim,
    #     'max_time_train':max_time_train,
    #     'max_memory_train':max_memory_train,
    #     'partition_train':partition_train,
    #     'devel_train':devel_train,
    #     'account':account, 
    #     'colors':colors, 
    #     'marginals':marginals
    #     }
    
    # with open(results_dir+'/config_objects.pickle','wb') as file:
    #     pickle.dump(config_objects, file)
    
    


    

    
    





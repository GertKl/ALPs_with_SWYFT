#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Thu Feb 22 15:18:47 2024

@author: gert
"""


import argparse
import os
import re
    
if __name__ == "__main__":
   
    # Parsing results directory path and arguments-string.  
    
    parser = argparse.ArgumentParser(description="")
    
    parser.add_argument("-results_dir", type=str)
    parser.add_argument("-args", type=str)

    args = parser.parse_args()
    
    
    # 


    config_dict = {}
    
    config_list = args.args.split(";")
    
    for item in config_list:
        
        config_argument_name_and_value = re.sub(r'\s','',item).split("=")
        config_dict[config_argument_name_and_value[0]] = config_argument_name_and_value[1].split("::")
        
    
    print("Config_dict:")
    print()
    print(config_dict)
    print()
        


    
    
    
    
    
    
    
    
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
    
    


    

    
    





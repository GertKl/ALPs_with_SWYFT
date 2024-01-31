#!/bin/bash



./ALP_B_config_files/simulate.sh

wait

./ALP_g_dependent_files/simulate.sh

wait

./ALP_toy_10ksims_files/simulate.sh

wait

./ALP_toy_cut_files/simulate.sh

wait



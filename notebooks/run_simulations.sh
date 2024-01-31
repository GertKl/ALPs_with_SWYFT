#!/bin/bash



python config_simulate_batch.py

chmod +x simulate_batch.sh

for ((i=1;i<=2;i++))
do

./simulate_batch.sh

done



exit
#!/bin/bash


trap "" SIGTERM

#sleep $((21*60*60))

./grid_informed_power.sh

./grid_informed_normal.sh



exit 0


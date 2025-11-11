#!/bin/bash


trap "" SIGTERM

sleep $((3*60*60))

./flare1_informed.sh


exit 0


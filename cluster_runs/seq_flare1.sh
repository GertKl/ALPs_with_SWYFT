#!/bin/bash


trap "" SIGTERM

sleep $((5*60*60))

#./flare1_confident1.sh

./flare1_informed.sh

#./flare1_semi_informed.sh

./flare1_agnostic.sh



exit 0


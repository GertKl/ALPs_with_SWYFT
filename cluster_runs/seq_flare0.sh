#!/bin/bash


trap "" SIGTERM

#sleep $((5*60*60))

./flare0_confident1.sh

./flare0_informed.sh

./flare0_semi_informed.sh

./flare0_agnostic.sh



exit 0


#!/bin/bash


trap "" SIGTERM

#sleep $((5*60*60))

./flare2_confident1.sh

./flare2_informed.sh

./flare2_semi_informed.sh

./flare2_agnostic.sh



exit 0


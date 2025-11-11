#!/bin/bash


trap "" SIGTERM

sleep $((11*60*60))

./flare3_confident1.sh

./flare3_informed.sh

./flare3_semi_informed.sh

./flare3_agnostic.sh



exit 0


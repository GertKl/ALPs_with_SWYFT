#!/bin/bash


trap "" SIGTERM

#sleep $((21*60*60))

#./flare0_agnostic.sh

#./flare0_semi_informed.sh

#./flare0_informed.sh

./flare0_confident1.sh

./flare0_confident3.sh

./flare0_confident2.sh



exit 0


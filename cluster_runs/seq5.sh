#!/bin/bash

echo waiting to start seq5.sh...
while [  $(squeue -u $USER | wc -l) -gt 1 ] ; do
	sleep 60
done

./test_inference-1.sh

echo --------------- Starting next run -------------------

./test_inference-2.sh


echo finished seq5.sh

exit 0


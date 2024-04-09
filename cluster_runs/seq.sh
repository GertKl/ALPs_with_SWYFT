#!/bin/bash


while [  $(squeue -u $USER | wc -l) -gt 1 ] ; do
	sleep 60
done



./test_inference_4-1.sh

echo --------------- Starting next run -------------------

./test_inference_4-2.sh

echo --------------- Starting next run -------------------

./test_inference_4-3.sh


echo finished seq3.sh

exit 0


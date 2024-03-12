#!/bin/bash

while [  $(squeue -u $USER | wc -l) -gt 1 ] ; do
	sleep 10
done

./test_gpu_100k_0.sh

while [  $(squeue -u $USER | wc -l) -gt 1 ] ; do
	sleep 10
done

./test_gpu_100k_1.sh


while [  $(squeue -u $USER | wc -l) -gt 1 ] ; do
	sleep 10
done

./test_gpu_100k_2.sh


while [  $(squeue -u $USER | wc -l) -gt 1 ] ; do
	sleep 10
done

./test_gpu_100k_3.sh


while [  $(squeue -u $USER | wc -l) -gt 1 ] ; do
	sleep 10
done

./test_gpu_100k_4.sh


while [  $(squeue -u $USER | wc -l) -gt 1 ] ; do
	sleep 10
done

./test_gpu_100k_5.sh


while [  $(squeue -u $USER | wc -l) -gt 1 ] ; do
	sleep 10
done

exit 0


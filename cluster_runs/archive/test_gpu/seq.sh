#!/bin/bash


while [  $(squeue -u $USER | wc -l) -gt 1 ] ; do
	sleep 10
done

./test_gpu_1.sh


while [  $(squeue -u $USER | wc -l) -gt 1 ] ; do
	sleep 10
done

./test_gpu_2.sh


while [  $(squeue -u $USER | wc -l) -gt 1 ] ; do
	sleep 10
done

./test_gpu_3.sh


while [  $(squeue -u $USER | wc -l) -gt 1 ] ; do
	sleep 10
done

./test_gpu_4.sh


while [  $(squeue -u $USER | wc -l) -gt 1 ] ; do
	sleep 10
done

./test_gpu_5.sh


while [  $(squeue -u $USER | wc -l) -gt 1 ] ; do
	sleep 10
done

./seq2.sh


while [  $(squeue -u $USER | wc -l) -gt 1 ] ; do
	sleep 10
done

exit 0


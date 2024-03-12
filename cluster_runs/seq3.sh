#!/bin/bash


echo waiting to start...

while [  $(squeue -u $USER | wc -l) -gt 1 ] ; do
	sleep 120
done

./simulate_g_values_1.sh
echo waiting

while [  $(squeue -u $USER | wc -l) -gt 1 ] ; do
	sleep 20
done

./simulate_g_values_2.sh
echo waiting

while [  $(squeue -u $USER | wc -l) -gt 1 ] ; do
	sleep 20
done

./simulate_g_values_3.sh
echo waiting

while [  $(squeue -u $USER | wc -l) -gt 1 ] ; do
	sleep 20
done

./simulate_g_values_4.sh
echo waiting

while [  $(squeue -u $USER | wc -l) -gt 1 ] ; do
	sleep 20
done

./simulate_g_values_5.sh
echo waiting

while [  $(squeue -u $USER | wc -l) -gt 1 ] ; do
	sleep 20
done

./simulate_g_values_6.sh
echo waiting

while [  $(squeue -u $USER | wc -l) -gt 1 ] ; do
	sleep 20
done

./simulate_g_values_7.sh
echo waiting

while [  $(squeue -u $USER | wc -l) -gt 1 ] ; do
	sleep 20
done

exit 0


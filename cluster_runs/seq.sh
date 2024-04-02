#!/bin/bash


./test_inference-1.sh

echo --------------- Starting next run -------------------

./test_inference-2.sh

echo --------------- Starting next run -------------------

./test_inference_4-0.sh

echo --------------- Starting next run -------------------

./test_inference_4-1.sh

echo --------------- Starting next run -------------------

./test_inference_4-2.sh

echo --------------- Starting next run -------------------

./test_inference_4-3.sh


echo --------------- Starting next run -------------------

./with_m.sh


echo finished seq3.sh

exit 0


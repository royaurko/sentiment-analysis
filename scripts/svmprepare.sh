#!/bin/bash

#Create the necessary directories in the libsvm_results folder.
for ((i=0;i<$1;i++))
do
mkdir -p ./libsvm_results/$2/fold_$i
done

#!/bin/bash
#$1 represents the name of the dataset, eg dataset1
#$2 represents the no of folds wanted
#$3 represents the size of each class of dataset, eg 1000 positives and 1000 negatives => $3 = 1000

for((i=0;i<$2;i++))
do
cat ./mincut_results/$1/fold_1_0_0/fold_$i/internal_1_1_1_matrix | ./mincut_files/mincut_scripts/internal_edges.sh > ./mincut_results/$1/fold_1_0_0/fold_$i/hipr_input_temp
done
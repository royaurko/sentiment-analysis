#!/bin/bash
for ((i=0;i<$2;i++))
do
./mincut_files/hipr/hi_pr < ./mincut_results/$1/fold_1_0_0/fold_$i/hipr_input > ./mincut_results/$1/fold_1_0_0/fold_$i/hipr_output
done
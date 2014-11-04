#!/bin/bash
#$1 represents the name of the dataset, eg dataset1
#$2 represents the no of folds wanted
#$3 represents the size of each class of dataset, eg 1000 positives and 1000 negatives => $3 = 1000

for ((i=0;i<$2;i++))
do 
cat ./libsvm_results/$1/fold_$i/result | awk 'BEGIN{ print "p max 202 40200";print "n 1 s"; print "n 2 t";} { if(FNR != 1){ print "a 1 " FNR " " int($2 *10000); print "a " FNR " 2 " int($3 * 10000); }}' > ./libsvm_results/$1/fold_$i/outer_edges
done

# cat ./libsvm_results/$1/fold0/result | awk 'BEGIN{ print "p max 202 40200";print "n 1 s"; print "n 2 t";} {if(FNR != 1){ print "a 1 " FNR " " int($2 *10000); print "a " FNR " 2 " int($3 * 10000); }}' > ./libsvm_results/fold0/outer_edges
# 
# 
# 
# cat ./libsvm_results/fold1/result | awk 'BEGIN{ print "p max 202 40200";print "n 1 s"; print "n 2 t";} { if(FNR != 1){ print "a 1 " FNR " " int($2 *10000); print "a " FNR " 2 " int($3 * 10000); }}' > ./libsvm_results/fold1/outer_edges
# 
# cat ./libsvm_results/fold2/result | awk 'BEGIN{ print "p max 202 40200";print "n 1 s"; print "n 2 t";} { if(FNR != 1){ print "a 1 " FNR " " int($2 *10000); print "a " FNR " 2 " int($3 * 10000); }}' > ./libsvm_results/fold2/outer_edges
# 
# cat ./libsvm_results/fold3/result | awk 'BEGIN{ print "p max 202 40200";print "n 1 s"; print "n 2 t";} { if(FNR != 1){ print "a 1 " FNR " " int($2 *10000); print "a " FNR " 2 " int($3 * 10000); }}' > ./libsvm_results/fold3/outer_edges
# 
# cat ./libsvm_results/fold4/result | awk 'BEGIN{ print "p max 202 40200";print "n 1 s"; print "n 2 t";} { if(FNR != 1){ print "a 1 " FNR " " int($2 *10000); print "a " FNR " 2 " int($3 * 10000); }}' > ./libsvm_results/fold4/outer_edges
# 
# cat ./libsvm_results/fold5/result | awk 'BEGIN{ print "p max 202 40200";print "n 1 s"; print "n 2 t";} { if(FNR != 1){ print "a 1 " FNR " " int($2 *10000); print "a " FNR " 2 " int($3 * 10000); }}' > ./libsvm_results/fold5/outer_edges
# 
# cat ./libsvm_results/fold6/result | awk 'BEGIN{ print "p max 202 40200";print "n 1 s"; print "n 2 t";} { if(FNR != 1){ print "a 1 " FNR " " int($2 *10000); print "a " FNR " 2 " int($3 * 10000); }}' > ./libsvm_results/fold6/outer_edges
# 
# cat ./libsvm_results/fold7/result | awk 'BEGIN{ print "p max 202 40200";print "n 1 s"; print "n 2 t";} { if(FNR != 1){ print "a 1 " FNR " " int($2 *10000); print "a " FNR " 2 " int($3 * 10000); }}' > ./libsvm_results/fold7/outer_edges
# 
# cat ./libsvm_results/fold8/result | awk 'BEGIN{ print "p max 202 40200";print "n 1 s"; print "n 2 t";} { if(FNR != 1){ print "a 1 " FNR " " int($2 *10000); print "a " FNR " 2 " int($3 * 10000); }}' > ./libsvm_results/fold8/outer_edges
# 
# cat ./libsvm_results/fold9/result | awk 'BEGIN{ print "p max 202 40200";print "n 1 s"; print "n 2 t";} { if(FNR != 1){ print "a 1 " FNR " " int($2 *10000); print "a " FNR " 2 " int($3 * 10000); }}' > ./libsvm_results/fold9/outer_edges

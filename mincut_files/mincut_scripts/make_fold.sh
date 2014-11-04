#!/bin/bash



#First create the 10 fold matrices. 
#Taking the 100 columns from the positive indices and 100 columns from negative indices.
#Create matrix for fold_0
#$1 represents the name of the dataset, eg dataset1
#$2 represents the no of folds wanted
#$3 represents the size of each class of dataset, eg 1000 positives and 1000 negatives => $3 = 1000

let s=$3/$2
for ((i=0;i<$2;i++))
do
let a=$i*$s+1
let b=($i+1)*$s
let c=$3+$a
let d=$3+$b
echo "select data from mincutTable where (cast(serial as INTEGER)>=$a AND cast(serial as INTEGER)<=$b) OR (cast(serial as INTEGER)>=$c AND cast(serial as INTEGER)<=$d);" | sqlite3 $1.db > ./mincut_results/$1/fold_1_0_0/fold_$i/matrix_fold
done

# 
# echo "select data from mincutTable where cast(serial as INTEGER)<=100 OR (cast(serial as INTEGER)>=1001 AND cast(serial as INTEGER)<=1100);" | sqlite3 $1.db > ./mincut_results/$1/fold_1_0_0/fold_0/matrix_fold
# 
# #Create matrix for fold_1
# echo "select data from mincutTable where (cast(serial as INTEGER)>=101 AND cast(serial as INTEGER)<=200) OR (cast(serial as INTEGER)>=1101 AND cast(serial as INTEGER)<=1200);" | sqlite3 $1.db > ./mincut_results/$1/fold_1_0_0/fold_1/matrix_fold
# 
# #Create matrix for fold_2
# echo "select data from mincutTable where (cast(serial as INTEGER)>=201 AND cast(serial as INTEGER)<=300) OR (cast(serial as INTEGER)>=1201 AND cast(serial as INTEGER)<=1300);" | sqlite3 $1.db > ./mincut_results/$1/fold_1_0_0/fold_2/matrix_fold
# 
# #Create matrix for fold_3
# echo "select data from mincutTable where (cast(serial as INTEGER)>=301 AND cast(serial as INTEGER)<=400) OR (cast(serial as INTEGER)>=1301 AND cast(serial as INTEGER)<=1400);" | sqlite3 $1.db > ./mincut_results/$1/fold_1_0_0/fold_3/matrix_fold
# 
# #Create matrix for fold_4
# echo "select data from mincutTable where (cast(serial as INTEGER)>=401 AND cast(serial as INTEGER)<=500) OR (cast(serial as INTEGER)>=1401 AND cast(serial as INTEGER)<=1500);" | sqlite3 $1.db > ./mincut_results/$1/fold_1_0_0/fold_4/matrix_fold
# 
# #Create matrix for fold_5
# echo "select data from mincutTable where (cast(serial as INTEGER)>=501 AND cast(serial as INTEGER)<=600) OR (cast(serial as INTEGER)>=1501 AND cast(serial as INTEGER)<=1600);" | sqlite3 $1.db > ./mincut_results/$1/fold_1_0_0/fold_5/matrix_fold
# 
# #Create matrix for fold_6
# echo "select data from mincutTable where (cast(serial as INTEGER)>=601 AND cast(serial as INTEGER)<=700) OR (cast(serial as INTEGER)>=1601 AND cast(serial as INTEGER)<=1700);" | sqlite3 $1.db > ./mincut_results/$1/fold_1_0_0/fold_6/matrix_fold
# 
# #Create matrix for fold_7
# echo "select data from mincutTable where (cast(serial as INTEGER)>=701 AND cast(serial as INTEGER)<=800) OR (cast(serial as INTEGER)>=1701 AND cast(serial as INTEGER)<=1800);" | sqlite3 $1.db > ./mincut_results/$1/fold_1_0_0/fold_7/matrix_fold
# 
# #Create matrix for fold_8
# echo "select data from mincutTable where (cast(serial as INTEGER)>=801 AND cast(serial as INTEGER)<=900) OR (cast(serial as INTEGER)>=1801 AND cast(serial as INTEGER)<=1900);" | sqlite3 $1.db > ./mincut_results/$1/fold_1_0_0/fold_8/matrix_fold
# 
# #Create matrix for fold_9
# echo "select data from mincutTable where (cast(serial as INTEGER)>=901 AND cast(serial as INTEGER)<=1000) OR (cast(serial as INTEGER)>=1901 AND cast(serial as INTEGER)<=2000);" | sqlite3 $1.db > ./mincut_results/$1/fold_1_0_0/fold_9/matrix_fold

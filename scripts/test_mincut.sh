#!/bin/bash
#Create the output directory for the ten fold results.

for ((i=0;i<$2;i++))
do
mkdir -p ./mincut_results/$1/fold_1_0_0/fold_$i
done


chmod 777 ./mincut_files/mincut_scripts/*.sh
echo "Making the 10 fold matrices..."
./mincut_files/mincut_scripts/make_fold.sh $1 $2 $3
echo "Creating the internal edge matrices out of the matrix_fold files. To be found in the same path with file name internal_1_1_1_matrix..."
./mincut_files/mincut_scripts/create_internal_edges_matrix.sh $1 $2 $3
echo "Creating the outer edges using the svm data. The outer edges can be found in the libsvm_results/fold folders with the name outer_edges... "
./mincut_files/mincut_scripts/gen_outer_edges.sh $1 $2 $3
echo "Concatenating the two and preparing the input file for the mincut algorithm. The input files are found in mincut_results/fold_1_0_0/fold folders with the name hipr_input... "
./mincut_files/mincut_scripts/inter_fold.sh $1 $2 $3
./mincut_files/mincut_scripts/copy_libsvm_mincut_hipr.sh $1 $2 $3
echo "Running the mincut algorithm ..."
./mincut_files/mincut_scripts/run_mincut.sh $1 $2 $3
echo "Done! The output files are in the mincut_results/fold_1_0_0/fold folders with the name hipr_output."
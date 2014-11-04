#!/bin/bash
echo "Normalizing the kernel matrices..."
java -cp ./preprocess_files Normalize_matrix preprocess_files/kernel_matrix/$1/matrix_$2 > preprocess_files/normalized_matrix/$1/normalized_matrix_$2
java -cp ./preprocess_files Normalize_matrix preprocess_files/kernel_matrix/$1/matrix_$3 > preprocess_files/normalized_matrix/$1/normalized_matrix_$3
cat preprocess_files/normalized_matrix/$1/normalized_matrix_$2 > preprocess_files/normalized_matrix/$1/normalized_matrix_$1
cat preprocess_files/normalized_matrix/$1/normalized_matrix_$3 >> preprocess_files/normalized_matrix/$1/normalized_matrix_$1
echo "Done!"
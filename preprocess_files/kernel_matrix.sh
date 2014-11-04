#!/bin/bash

echo "Generating kernel matrix for the class $2 ..."
java -cp ./preprocess_files Kernel_matrix_Create preprocess_files/stop/$1/$2 preprocess_files/tfidf/$1/tfidf_$2 preprocess_files/kernel_matrix/$1/matrix_$2
echo "Generating kernel matrix for the class $3 ..."
java -cp ./preprocess_files Kernel_matrix_Create preprocess_files/stop/$1/$3 preprocess_files/tfidf/$1/tfidf_$3 preprocess_files/kernel_matrix/$1/matrix_$3
echo "Done!"
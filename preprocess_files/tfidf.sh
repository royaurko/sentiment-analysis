#!/bin/bash


echo "Calculating tf-idf for the dataset..."
java -cp ./preprocess_files InverseDocument_freqCount preprocess_files/stop/$1/$2 dummy > preprocess_files/tfidf/$1/tfidf_$2
java -cp ./preprocess_files InverseDocument_freqCount preprocess_files/stop/$1/$3 dummy > preprocess_files/tfidf/$1/tfidf_$3
echo "Done!"
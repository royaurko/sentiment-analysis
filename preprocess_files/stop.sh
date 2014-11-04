#!/bin/bash
#This script will take three arguments. The first is the name of the dataset and the other two are the labels of the two classes within that dataset.
#This script has an optional argument which takes in the stopping list in case the default list is not used.


if [ $# -lt 4 ]
then 
         echo "Performing stemming and stopping using default stop list (preprocess_files/stop_word)..."
	 java -cp ./preprocess_files Remove_stopword dataset/$1/$2 preprocess_files/stop_word preprocess_files/stop/$1/$2
         java -cp ./preprocess_files Remove_stopword dataset/$1/$3 preprocess_files/stop_word preprocess_files/stop/$1/$3
	 echo "Done!"
else
	 echo "Performing stemming and stopping using $4 ..."
	 java -cp ./preprocess_files Remove_stopword dataset/$1/$2 $4 preprocess_files/stop/$1/$2
         java -cp ./preprocess_files Remove_stopword dataset/$1/$3 $4 preprocess_files/stop/$1/$3
	 echo "Done!"
fi
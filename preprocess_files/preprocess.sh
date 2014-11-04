#!/bin/bash

# Compile the stemmer and stopper programs.
#javac preprocess_files/Stemmer.java
#javac -cp ./preprocess_files preprocess_files/Remove_stopword.java


#Create the temporary directories where the data set after passing through stemming and stopping will be placed


#Pass both the classes of dataset through the stopper.
echo "Performing Stemming and Stopping on the dataset..."
java -cp ./preprocess_files Remove_stopword dataset/$1/$2 preprocess_files/stop_word preprocess_files/stop/$1/$2
java -cp ./preprocess_files Remove_stopword dataset/$1/$3 preprocess_files/stop_word preprocess_files/stop/$1/$3

#Compile the tfidf calculator and pass both the classes of dataset through it.
#javac -g:none -nowarn -cp ./preprocess_files preprocess_files/InverseDocument_freqCount.java > preprocess_files/dummy
echo "Calculating tf-idf for the dataset..."
java -cp ./preprocess_files InverseDocument_freqCount preprocess_files/stop/$1/$2 dummy > preprocess_files/tfidf/$1/tfidf_$2
java -cp ./preprocess_files InverseDocument_freqCount preprocess_files/stop/$1/$3 dummy > preprocess_files/tfidf/$1/tfidf_$3

echo "Generating matrix for the dataset..."
javac -cp ./preprocess_files preprocess_files/Kernel_matrix_Create.java
echo "Generating matrix for the class $2 ..."
java -cp ./preprocess_files Kernel_matrix_Create preprocess_files/stop/$1/$2 preprocess_files/tfidf/$1/tfidf_$2 preprocess_files/kernel_matrix/$1/matrix_$2
echo "Generating matrix for the class $3 ..."
java -cp ./preprocess_files Kernel_matrix_Create preprocess_files/stop/$1/$3 preprocess_files/tfidf/$1/tfidf_$3 preprocess_files/kernel_matrix/$1/matrix_$3
#cat preprocess_files/kernel_matrix/$1/matrix_$2 > preprocess_files/kernel_matrix/$1/matrix_$1


#Copy the two dataset matrices into one single matrix to be normalized.
./preprocess_files/concat.sh < preprocess_files/kernel_matrix/$1/matrix_$2 > preprocess_files/kernel_matrix/$1/temp_matrix_$2
read a < temp
#echo $a
rm -f temp
./preprocess_files/concat.sh < preprocess_files/kernel_matrix/$1/matrix_$3 > preprocess_files/kernel_matrix/$1/temp_matrix_$3
read b < temp
#echo $b
a=`expr $a + $b`
#echo $a
rm -f temp
echo $a > preprocess_files/kernel_matrix/$1/matrix_$1 
cat  preprocess_files/kernel_matrix/$1/temp_matrix_$2 >> preprocess_files/kernel_matrix/$1/matrix_$1
cat  preprocess_files/kernel_matrix/$1/temp_matrix_$3 >> preprocess_files/kernel_matrix/$1/matrix_$1

#Normalize the kernel matrices


# java -cp ./preprocess_files Normalize_matrix kernel_matrix/$1/matrix_$2 > normalized_matrix/$1/normalized_matrix_$2
# java -cp ./preprocess_files Normalize_matrix kernel_matrix/$1/matrix_$3 > normalized_matrix/$1/normalized_matrix_$3
 

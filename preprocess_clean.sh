if [ $# -lt 1 ]
then
echo "Specify the name of the dataset to be cleaned in the argument."
exit
fi

rm -rf ./preprocess_files/stop/$1/
rm -rf ./preprocess_files/tfidf/$1/
rm -rf ./preprocess_files/kernel_matrix/$1/

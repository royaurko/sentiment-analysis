#first number the dataset files and store it in a file called numbered_dataset
#nl --number-format=ln svm_dataset_scaled > numbered_dataset

#replace the tabs by the default separator | used by sqlite3
# nl svm_files/svm_dataset > numbered_dataset
# cat numbered_dataset | sed 's/[\t]/|/g' > svm_files/sqlite_dataset
# rm numbered_dataset

#number the matrix file and store it in a file called numbered_matrix
mkdir -p ./mincut_files/$1
cp ./preprocess_files/normalized_matrix/$1/normalized_matrix_$1 ./mincut_files/$1/normalized_matrix_$1
nl ./mincut_files/$1/normalized_matrix_$1 > numbered_matrix
#replace tabs by default separator | used by sqlite3
cat numbered_matrix | sed 's/[\t]/|/g' > mincut_files/$1/sqlite_matrix_$1
rm numbered_matrix
#create a table that will hold the data
# echo "create table svmtable (serial INTEGER,data BLOB);" | sqlite3 $2.db
echo "create table mincutTable (serial INTEGER, data BLOB);" | sqlite3 $1.db
#import the data from the file sqlite_dataset
# echo ".import svm_files/sqlite_dataset maintable" | sqlite3 $2.db
echo ".import mincut_files/$1/sqlite_matrix_$1 mincutTable" | sqlite3 $1.db

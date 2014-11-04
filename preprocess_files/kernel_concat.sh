./preprocess_files/concat.sh < preprocess_files/kernel_matrix/$1/matrix_$2 > preprocess_files/kernel_matrix/$1/temp_matrix_$2
read a < temp

./preprocess_files/concat.sh < preprocess_files/kernel_matrix/$1/matrix_$3 > preprocess_files/kernel_matrix/$1/temp_matrix_$3
read b < temp

a=`expr $a + $b`

rm -f temp
echo $a > preprocess_files/kernel_matrix/$1/matrix_$1 
cat  preprocess_files/kernel_matrix/$1/temp_matrix_$2 >> preprocess_files/kernel_matrix/$1/matrix_$1
cat  preprocess_files/kernel_matrix/$1/temp_matrix_$3 >> preprocess_files/kernel_matrix/$1/matrix_$1
rm -f preprocess_files/kernel_matrix/$1/temp_matrix_$2
rm -f preprocess_files/kernel_matrix/$1/temp_matrix_$3


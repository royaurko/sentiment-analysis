#!/bin/bash
mkdir -p ./preprocess_files/stop/$1_total


cd ./preprocess_files/stop/$1/$2
for file in `dir -d *`
do 
cat $file > ../../$1_total/a_$file
done

cd ../$3
for file in `dir -d *`
do 
cat $file > ../../$1_total/b_$file
done
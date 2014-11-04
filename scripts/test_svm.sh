#!/bin/bash

#We will perform a n fold svm classification here.
#Features of the SVM we are using here:
#The svm being used is a nu-SVM. (can be changed using -s)
#The kernel type is a Radial Basis Function (RBF) kernel (Can be changed using -t )

#The testing part...

for ((i=0;i<$1;i++))
do
./svm_files/libsvm/svm-scale -l 0 -s libsvm_results/$2/fold_$i/range libsvm_results/$2/fold_$i/train_fold_$i > libsvm_results/$2/fold_$i/svm_train_scale
./svm_files/libsvm/svm-scale -r libsvm_results/$2/fold_$i/range libsvm_results/$2/fold_$i/test_fold_$i > libsvm_results/$2/fold_$i/svm_test_scale
./svm_files/libsvm/svm-train -s 1 -b 1 libsvm_results/$2/fold_$i/svm_train_scale libsvm_results/$2/fold_$i/svm_train_scale.model
./svm_files/libsvm/svm-predict -b 1 libsvm_results/$2/fold_$i/svm_test_scale libsvm_results/$2/fold_$i/svm_train_scale.model libsvm_results/$2/fold_$i/result > libsvm_results/$2/fold_$i/accuracy
done
echo "Done!"
# #For fold-0 divide the dataset into first 200 positives and negatives and train svm on rest of svm.
# echo "select data from maintable where cast(serial as INTEGER)<=100 OR (cast(serial as INTEGER)>=1001 AND cast(serial as INTEGER)<=1100);" | sqlite3 complete_dataset.db > libsvm_results/fold0/svm_test
# echo "select data from maintable where NOT (cast(serial as INTEGER)<=100 OR cast(serial as INTEGER)>=1001 AND cast(serial as INTEGER)<=1100);" | sqlite3 complete_dataset.db > libsvm_results/fold0/svm_train
# ./svm_files/libsvm/svm-scale -l 0 -s libsvm_results/fold0/range libsvm_results/fold0/svm_train > libsvm_results/fold0/svm_train_scale
# ./svm_files/libsvm/svm-scale -r libsvm_results/fold0/range libsvm_results/fold0/svm_test > libsvm_results/fold0/svm_test_scale
# ./svm_files/libsvm/svm-train -s 1 -b 1 libsvm_results/fold0/svm_train_scale libsvm_results/fold0/svm_train_scale.model
# ./svm_files/libsvm/svm-predict -b 1 libsvm_results/fold0/svm_test_scale libsvm_results/fold0/svm_train_scale.model libsvm_results/fold0/result > libsvm_results/fold0/accuracy
# 
# 
# #fold-1
# echo "select data from maintable where (cast(serial as INTEGER)>=101 AND cast(serial as INTEGER)<=200) OR (cast(serial as INTEGER)>=1101 AND cast(serial as INTEGER)<=1200);" | sqlite3 complete_dataset.db > libsvm_results/fold1/svm_test
# echo "select data from maintable where NOT ((cast(serial as INTEGER)>=101 AND cast(serial as INTEGER)<=200) OR (cast(serial as INTEGER)>=1101 AND cast(serial as INTEGER)<=1200));" | sqlite3 complete_dataset.db > libsvm_results/fold1/svm_train
# ./svm_files/libsvm/svm-scale -l 0 -s libsvm_results/fold1/range libsvm_results/fold1/svm_train > libsvm_results/fold1/svm_train_scale
# ./svm_files/libsvm/svm-scale -r libsvm_results/fold1/range libsvm_results/fold1/svm_test > libsvm_results/fold1/svm_test_scale
# ./svm_files/libsvm/svm-train -s 1 -b 1 libsvm_results/fold1/svm_train_scale libsvm_results/fold1/svm_train_scale.model
# ./svm_files/libsvm/svm-predict -b 1 libsvm_results/fold1/svm_test_scale libsvm_results/fold1/svm_train_scale.model libsvm_results/fold1/result > libsvm_results/fold1/accuracy
# 
# #fold-2
# echo "select data from maintable where (cast(serial as INTEGER)>=201 AND cast(serial as INTEGER)<=300) OR (cast(serial as INTEGER)>=1201 AND cast(serial as INTEGER)<=1300);" | sqlite3 complete_dataset.db > libsvm_results/fold2/svm_test
# echo "select data from maintable where NOT ((cast(serial as INTEGER)>=201 AND cast(serial as INTEGER)<=300) OR (cast(serial as INTEGER)>=1201 AND cast(serial as INTEGER)<=1300));" | sqlite3 complete_dataset.db > libsvm_results/fold2/svm_train
# ./svm_files/libsvm/svm-scale -l 0 -s libsvm_results/fold2/range libsvm_results/fold2/svm_train > libsvm_results/fold2/svm_train_scale
# ./svm_files/libsvm/svm-scale -r libsvm_results/fold2/range libsvm_results/fold2/svm_test > libsvm_results/fold2/svm_test_scale
# ./svm_files/libsvm/svm-train -s 1 -b 1 libsvm_results/fold2/svm_train_scale libsvm_results/fold2/svm_train_scale.model
# ./svm_files/libsvm/svm-predict -b 1 libsvm_results/fold2/svm_test_scale libsvm_results/fold2/svm_train_scale.model libsvm_results/fold2/result > libsvm_results/fold2/accuracy
# 
# #fold-3
# echo "select data from maintable where (cast(serial as INTEGER)>=301 AND cast(serial as INTEGER)<=400) OR (cast(serial as INTEGER)>=1301 AND cast(serial as INTEGER)<=1400);" | sqlite3 complete_dataset.db > libsvm_results/fold3/svm_test
# echo "select data from maintable where NOT ((cast(serial as INTEGER)>=301 AND cast(serial as INTEGER)<=400) OR (cast(serial as INTEGER)>=1301 AND cast(serial as INTEGER)<=1400));" | sqlite3 complete_dataset.db > libsvm_results/fold3/svm_train
# ./svm_files/libsvm/svm-scale -l 0 -s libsvm_results/fold3/range libsvm_results/fold3/svm_train > libsvm_results/fold3/svm_train_scale
# ./svm_files/libsvm/svm-scale -r libsvm_results/fold3/range libsvm_results/fold3/svm_test > libsvm_results/fold3/svm_test_scale
# ./svm_files/libsvm/svm-train -s 1 -b 1 libsvm_results/fold3/svm_train_scale libsvm_results/fold3/svm_train_scale.model
# ./svm_files/libsvm/svm-predict -b 1 libsvm_results/fold3/svm_test_scale libsvm_results/fold3/svm_train_scale.model libsvm_results/fold3/result > libsvm_results/fold3/accuracy
# 
# #fold-4
# echo "select data from maintable where (cast(serial as INTEGER)>=401 AND cast(serial as INTEGER)<=500) OR (cast(serial as INTEGER)>=1401 AND cast(serial as INTEGER)<=1500);" | sqlite3 complete_dataset.db > libsvm_results/fold4/svm_test
# echo "select data from maintable where NOT ((cast(serial as INTEGER)>=401 AND cast(serial as INTEGER)<=500) OR (cast(serial as INTEGER)>=1401 AND cast(serial as INTEGER)<=1500));" | sqlite3 complete_dataset.db > libsvm_results/fold4/svm_train
# ./svm_files/libsvm/svm-scale -l 0 -s libsvm_results/fold4/range libsvm_results/fold4/svm_train > libsvm_results/fold4/svm_train_scale
# ./svm_files/libsvm/svm-scale -r libsvm_results/fold4/range libsvm_results/fold4/svm_test > libsvm_results/fold4/svm_test_scale
# ./svm_files/libsvm/svm-train -s 1 -b 1 libsvm_results/fold4/svm_train_scale libsvm_results/fold4/svm_train_scale.model
# ./svm_files/libsvm/svm-predict -b 1 libsvm_results/fold4/svm_test_scale libsvm_results/fold4/svm_train_scale.model libsvm_results/fold4/result > libsvm_results/fold4/accuracy
# 
# #fold-5
# echo "select data from maintable where (cast(serial as INTEGER)>=501 AND cast(serial as INTEGER)<=600) OR (cast(serial as INTEGER)>=1501 AND cast(serial as INTEGER)<=1600);" | sqlite3 complete_dataset.db > libsvm_results/fold5/svm_test
# echo "select data from maintable where NOT ((cast(serial as INTEGER)>=501 AND cast(serial as INTEGER)<=600) OR (cast(serial as INTEGER)>=1501 AND cast(serial as INTEGER)<=1600));" | sqlite3 complete_dataset.db > libsvm_results/fold5/svm_train
# ./svm_files/libsvm/svm-scale -l 0 -s libsvm_results/fold5/range libsvm_results/fold5/svm_train > libsvm_results/fold5/svm_train_scale
# ./svm_files/libsvm/svm-scale -r libsvm_results/fold5/range libsvm_results/fold5/svm_test > libsvm_results/fold5/svm_test_scale
# ./svm_files/libsvm/svm-train -s 1 -b 1 libsvm_results/fold5/svm_train_scale libsvm_results/fold5/svm_train_scale.model
# ./svm_files/libsvm/svm-predict -b 1 libsvm_results/fold5/svm_test_scale libsvm_results/fold5/svm_train_scale.model libsvm_results/fold5/result > libsvm_results/fold5/accuracy
# 
# 
# #fold-6
# echo "select data from maintable where (cast(serial as INTEGER)>=601 AND cast(serial as INTEGER)<=700) OR (cast(serial as INTEGER)>=1601 AND cast(serial as INTEGER)<=1700);" | sqlite3 complete_dataset.db > libsvm_results/fold6/svm_test
# echo "select data from maintable where NOT ((cast(serial as INTEGER)>=601 AND cast(serial as INTEGER)<=700) OR (cast(serial as INTEGER)>=1601 AND cast(serial as INTEGER)<=1700));" | sqlite3 complete_dataset.db > libsvm_results/fold6/svm_train
# ./svm_files/libsvm/svm-scale -l 0 -s libsvm_results/fold6/range libsvm_results/fold6/svm_train > libsvm_results/fold6/svm_train_scale
# ./svm_files/libsvm/svm-scale -r libsvm_results/fold6/range libsvm_results/fold6/svm_test > libsvm_results/fold6/svm_test_scale
# ./svm_files/libsvm/svm-train -s 1 -b 1 libsvm_results/fold6/svm_train_scale libsvm_results/fold6/svm_train_scale.model
# ./svm_files/libsvm/svm-predict -b 1 libsvm_results/fold6/svm_test_scale libsvm_results/fold6/svm_train_scale.model libsvm_results/fold6/result > libsvm_results/fold6/accuracy
# 
# 
# #fold-7
# echo "select data from maintable where (cast(serial as INTEGER)>=701 AND cast(serial as INTEGER)<=800) OR (cast(serial as INTEGER)>=1701 AND cast(serial as INTEGER)<=1800);" | sqlite3 complete_dataset.db > libsvm_results/fold7/svm_test
# echo "select data from maintable where NOT ((cast(serial as INTEGER)>=701 AND cast(serial as INTEGER)<=800) OR (cast(serial as INTEGER)>=1701 AND cast(serial as INTEGER)<=1800));" | sqlite3 complete_dataset.db > libsvm_results/fold7/svm_train
# ./svm_files/libsvm/svm-scale -l 0 -s libsvm_results/fold7/range libsvm_results/fold7/svm_train > libsvm_results/fold7/svm_train_scale
# ./svm_files/libsvm/svm-scale -r libsvm_results/fold7/range libsvm_results/fold7/svm_test > libsvm_results/fold7/svm_test_scale
# ./svm_files/libsvm/svm-train -s 1 -b 1 libsvm_results/fold7/svm_train_scale libsvm_results/fold7/svm_train_scale.model
# ./svm_files/libsvm/svm-predict -b 1 libsvm_results/fold7/svm_test_scale libsvm_results/fold7/svm_train_scale.model libsvm_results/fold7/result > libsvm_results/fold7/accuracy
# 
# #fold-8
# echo "select data from maintable where (cast(serial as INTEGER)>=801 AND cast(serial as INTEGER)<=900) OR (cast(serial as INTEGER)>=1801 AND cast(serial as INTEGER)<=1900);" | sqlite3 complete_dataset.db > libsvm_results/fold8/svm_test
# echo "select data from maintable where NOT ((cast(serial as INTEGER)>=801 AND cast(serial as INTEGER)<=900) OR (cast(serial as INTEGER)>=1801 AND cast(serial as INTEGER)<=1900));" | sqlite3 complete_dataset.db > libsvm_results/fold8/svm_train
# ./svm_files/libsvm/svm-scale -l 0 -s libsvm_results/fold8/range libsvm_results/fold8/svm_train > libsvm_results/fold8/svm_train_scale
# ./svm_files/libsvm/svm-scale -r libsvm_results/fold8/range libsvm_results/fold8/svm_test > libsvm_results/fold8/svm_test_scale
# ./svm_files/libsvm/svm-train -s 1 -b 1 libsvm_results/fold8/svm_train_scale libsvm_results/fold8/svm_train_scale.model
# ./svm_files/libsvm/svm-predict -b 1 libsvm_results/fold8/svm_test_scale libsvm_results/fold8/svm_train_scale.model libsvm_results/fold8/result > libsvm_results/fold8/accuracy
# 
# 
# #fold-9
# echo "select data from maintable where (cast(serial as INTEGER)>=901 AND cast(serial as INTEGER)<=1000) OR (cast(serial as INTEGER)>=1901 AND cast(serial as INTEGER)<=2000);" | sqlite3 complete_dataset.db > libsvm_results/fold9/svm_test
# echo "select data from maintable where NOT ((cast(serial as INTEGER)>=901 AND cast(serial as INTEGER)<=1000) OR (cast(serial as INTEGER)>=1901 AND cast(serial as INTEGER)<=2000));" | sqlite3 complete_dataset.db > libsvm_results/fold9/svm_train
# ./svm_files/libsvm/svm-scale -l 0 -s libsvm_results/fold9/range libsvm_results/fold9/svm_train > libsvm_results/fold9/svm_train_scale
# ./svm_files/libsvm/svm-scale -r libsvm_results/fold9/range libsvm_results/fold9/svm_test > libsvm_results/fold9/svm_test_scale
# ./svm_files/libsvm/svm-train -s 1 -b 1 libsvm_results/fold9/svm_train_scale libsvm_results/fold9/svm_train_scale.model
# ./svm_files/libsvm/svm-predict -b 1 libsvm_results/fold9/svm_test_scale libsvm_results/fold9/svm_train_scale.model libsvm_results/fold9/result > libsvm_results/fold9/accuracy
# 
# #over whole dataset, i.e. train over whole dataset and test it over whole dataset.
# echo "select data from maintable;" | sqlite3 complete_dataset.db > libsvm_results/over_dataset/svm_test
# echo "select data from maintable;" | sqlite3 complete_dataset.db > libsvm_results/over_dataset/svm_train
# ./svm_files/libsvm/svm-scale -l 0 -s libsvm_results/over_dataset/range libsvm_results/over_dataset/svm_train > libsvm_results/over_dataset/svm_train_scale
# ./svm_files/libsvm/svm-scale -r libsvm_results/over_dataset/range libsvm_results/over_dataset/svm_test > libsvm_results/over_dataset/svm_test_scale
# ./svm_files/libsvm/svm-train -s 1 -b 1 libsvm_results/over_dataset/svm_train_scale libsvm_results/over_dataset/svm_train_scale.model
# ./svm_files/libsvm/svm-predict -b 1 libsvm_results/over_dataset/svm_test_scale libsvm_results/over_dataset/svm_train_scale.model libsvm_results/over_dataset/result > libsvm_results/over_dataset/accuracy
# 
# #Create another ten fold by doing something here.
# 
# 
# echo "Done! The output files may be viewed in the libsvm_results/fold folders."











#!/bin/bash
#$1 represents the name of the dataset, eg dataset1
#$2 represents the no of folds wanted
#$3 represents the size of each class of dataset, eg 1000 positives and 1000 negatives => $3 = 1000
let s=$3/$2

for ((j=0;j<$2;j++))
do
let a=$j*$s
let b=($j+1)*$s
let c=$j*$s+$3
let d=($j+1)*$s+$3

cat ./mincut_results/$1/fold_1_0_0/fold_$j/matrix_fold | awk '{
		for(i = 1 ; i <= NF ; i++)
		{
			if( ( i > '"$a"' && i <= '"$b"') || (i >'"$c"' && i <= '"$d"') )
				data = data " " $i ;
		}
		print data;
		data = "";
}' > ./mincut_results/$1/fold_1_0_0/fold_$j/internal_1_1_1_matrix
done

# cat ./mincut_results/$1/fold_1_0_0/fold_0/matrix_fold | awk '{
# 		for(i = 1 ; i <= NF ; i++)
# 		{
# 			if( ( i > 0 && i <= 100) || (i >1000 && i <= 1100) )
# 				data = data " " $i ;
# 		}
# 		print data;
# 		data = "";
# }' > ./mincut_results/$1/fold_1_0_0/fold_0/internal_1_1_1_matrix
# 
# 
# 
# 
# cat ./mincut_results/$1/fold_1_0_0/fold_1/matrix_fold | awk '{
# 		for(i = 1 ; i <= NF ; i++)
# 		{
# 			if( ( i > 100 && i <= 200) || (i >1100 && i <= 1200) )
# 				data = data " " $i ;
# 		}
# 		print data;
# 		data = "";
# }' > ./mincut_results/$1/fold_1_0_0/fold_1/internal_1_1_1_matrix
# 
# 
# 
# cat ./mincut_results/$1/fold_1_0_0/fold_2/matrix_fold | awk '{
# 		for(i = 1 ; i <= NF ; i++)
# 		{
# 			if( ( i > 200 && i <= 300) || (i >1200 && i <= 1300) )
# 				data = data " " $i ;
# 		}
# 		print data;
# 		data = "";
# }' > ./mincut_results/$1/fold_1_0_0/fold_2/internal_1_1_1_matrix
# 
# 
# 
# cat ./mincut_results/$1/fold_1_0_0/fold_3/matrix_fold | awk '{
# 		for(i = 1 ; i <= NF ; i++)
# 		{
# 			if( ( i > 300 && i <= 400) || (i >1300 && i <= 1400) )
# 				data = data " " $i ;
# 		}
# 		print data;
# 		data = "";
# }' > ./mincut_results/$1/fold_1_0_0/fold_3/internal_1_1_1_matrix
# 
# 
# 
# cat ./mincut_results/$1/fold_1_0_0/fold_4/matrix_fold | awk '{
# 		for(i = 1 ; i <= NF ; i++)
# 		{
# 			if( ( i > 400 && i <= 500) || (i >1400 && i <= 1500) )
# 				data = data " " $i ;
# 		}
# 		print data;
# 		data = "";
# }' > ./mincut_results/$1/fold_1_0_0/fold_4/internal_1_1_1_matrix
# 
# 
# 
# cat ./mincut_results/$1/fold_1_0_0/fold_5/matrix_fold | awk '{
# 		for(i = 1 ; i <= NF ; i++)
# 		{
# 			if( ( i > 500 && i <= 600) || (i >1500 && i <= 1600) )
# 				data = data " " $i ;
# 		}
# 		print data;
# 		data = "";
# }' > ./mincut_results/$1/fold_1_0_0/fold_5/internal_1_1_1_matrix
# 
# 
# 
# cat ./mincut_results/$1/fold_1_0_0/fold_6/matrix_fold | awk '{
# 		for(i = 1 ; i <= NF ; i++)
# 		{
# 			if( ( i > 600 && i <= 700) || (i >1600 && i <= 1700) )
# 				data = data " " $i ;
# 		}
# 		print data;
# 		data = "";
# }' > ./mincut_results/$1/fold_1_0_0/fold_6/internal_1_1_1_matrix
# 
# 
# 
# cat ./mincut_results/$1/fold_1_0_0/fold_7/matrix_fold | awk '{
# 		for(i = 1 ; i <= NF ; i++)
# 		{
# 			if( ( i > 700 && i <= 800) || (i >1700 && i <= 1800) )
# 				data = data " " $i ;
# 		}
# 		print data;
# 		data = "";
# }' > ./mincut_results/$1/fold_1_0_0/fold_7/internal_1_1_1_matrix
# 
# 
# 
# cat ./mincut_results/$1/fold_1_0_0/fold_8/matrix_fold | awk '{
# 		for(i = 1 ; i <= NF ; i++)
# 		{
# 			if( ( i > 800 && i <= 900) || (i >1800 && i <= 1900) )
# 				data = data " " $i ;
# 		}
# 		print data;
# 		data = "";
# }' > ./mincut_results/$1/fold_1_0_0/fold_8/internal_1_1_1_matrix
# 
# 
# 
# cat ./mincut_results/$1/fold_1_0_0/fold_9/matrix_fold | awk '{
# 		for(i = 1 ; i <= NF ; i++)
# 		{
# 			if( ( i > 900 && i <= 1000) || (i >1900 && i <= 2000) )
# 				data = data " " $i ;
# 		}
# 		print data;
# 		data = "";
# }' > ./mincut_results/$1/fold_1_0_0/fold_9/internal_1_1_1_matrix
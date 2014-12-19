#Description

A suite of tools to classify movie reviews as expressing *positive* or *negative* sentiment.

#Usage

* Place the dataset to be experimented on in the dataset folder.

* Then run 

```
./configure --dset <your_dataset> [FLAGS]

```

* Optional flags may be used in case the parameters in your dataset differ from the default values. 


## List of default values

--label1 -> This has a default value of neg. If your dataset has a different label specify the label with the --label1 flag.

--label2 -> This has a default value of pos. If your dataset has a different label specify the label with the --label2 flag.

--n      -> This represents the n-fold validation. Typically this is 10. If you want to change the value, use the --n flag.

--size   -> This represents the number of raw files in each class of your dataset. The default value is 1000. 

--stoplist -> If you want to use your own stop file, place it in the preprocess_files folder and use the --stoplist

flag with the just the name of the file. (No need to specify path)

--help   -> This opens up the help menu.

The makefile is now generated. To run type 

```

$ make all

```



## Explanation of folder convention


* The makefile maintains a build history in the build folder.

* The first few recipes of the makefile are preprocessing functions. To view the intermediate files generated during

preprocessing you can visit the preprocess_files folder.

* The folder preprocess_files/stop/<your_dataset> contains the dataset with the stop words removed.

* The folder preprocess_files/tfidf/<your_dataset> contains the tfidf calculations performed on the dataset.

* The folder preprocess_files/kernel_matrix/<your_dataset> contains the kernel matrix generated from the dataset using the tfidf values.

* The folder preprocess_files/normalized_matrix/<your_dataset> contains the matrices after normalizing the kernel matrix.

* The folder libsvm_results/<your_dataset> contains the folders generated from the n-fold validation using libsvm. 

* The folder mincut_results/<your_dataset> contains the result of the max-flow-min-cut method on <your_dataset>.
 




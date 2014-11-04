import java.io.*;
import java.util.*;
import java.lang.*;
import javax.swing.*;


// This code Creates Kernel Matrix

public class Kernel_matrix_Create
{
	
	File inputRevDir;
	File instanceList;
	File outputFile;
	int value_n = 3;

	int no_of_file;
	int no_of_words;		// no of words in score_table file
	
	int row_no;			// no of row in current k_single and k_double 
	int column_no;			// no of column in current k_single and k_double 

	
	boolean [][]matche_String_table;

	String []row_str_word;
	String []column_str_word;
	

	double [][][]kernel_value_matrix;        // matrix of size (no_of_file  X no_of_file X value_n)  which stores value of kernel 
						// for each comination of file for n  = 1 to value_n
	

	double [][]double_k;
	double [][][]single_k;
	
	double [][]score_table;		//stores scores of words  matching,gap , and matching * matching
	
//	Hashtable<String, Integer> instanceListHash;
	Hashtable<String, Integer> instanceListHash = new Hashtable<String, Integer>();
	
	Kernel_matrix_Create(String[] args)
	{
		inputRevDir = new File(args[0]);
		instanceList = new File(args[1]);
		outputFile = new File(args[2]);
		//Hashtable<String, Integer> instanceListHash = new Hashtable<String, Integer>();
	}

	//creates Ki' matrix  i = which_i
	//

	void create_one_to_n_kernel(int row_index, int column_index)
	{

		double [][]square_value_sum = new double[value_n + 1][row_no];     
		// this matrix stores 
		// 0th row	value of square of matched symbol 
		// 1st 2nd 3rd ....  stores temp sum of n=1 n =2 n=3 kernel value
		
		int index_word;
		for( int i =1 ; i< row_no ; i++)
		{
			index_word = instanceListHash.get(row_str_word[i]);
			square_value_sum[0][i] = score_table[index_word][2];
			
		}

		for( int i = 1 ; i <= value_n ; i++)
		{
			for( int j = 0 ; j < row_no ; j++)
			{
				square_value_sum[i][j] = 0;
			}
		}

		for( int i = 2; i< column_no ; i++)	// starting from 2nd row 
		{
			for( int j =1; j < row_no ; j++)
			{
				if(matche_String_table[i][j] == true)
				{
					for( int l = 1; l <= value_n ; l++)
					{
						if( j < l)
						{
							square_value_sum[l][j] = 0; 	
						}
						else
						{
							if( l ==1)
								square_value_sum[l][j] = square_value_sum[l][j] + 1;
							else
								square_value_sum[l][j] = square_value_sum[l][j] + single_k[l-2][i-1][j-1];	
						}
					}
				}
			}
		}
/*
		if( row_index == 1 && column_index == 0)
		{

			for(int i = 1 ; i < column_no ; i++)
			{
				for( int j =1 ; j< row_no ; j++)
				{
					System.out.print("   " + single_k[0][i][j] );
				}
				System.out.println("");
			}

			for(int i = 0 ; i <= value_n ; i++)
			{
				for( int j =1 ; j< row_no ; j++)
				{
					System.out.print("   " + square_value_sum[i][j] );
				}
				System.out.println("");
			}
		}
*/
		for( int i = 1 ; i< row_no ; i++)
		{	
			double value_square_of = square_value_sum[0][i] ;

			for( int j =0 ; j < value_n ; j++)
			{
				kernel_value_matrix[j][row_index][column_index] = kernel_value_matrix[j][row_index][column_index]
										+  value_square_of * square_value_sum[j+1][i];

			}
		}

		for( int j = 0 ; j< value_n ; j++)
		{
			kernel_value_matrix[j][column_index][row_index] = kernel_value_matrix[j][row_index][column_index];
		}




	}

	void single_k_create( int which_i)
	{
		which_i  = which_i -1;
		for(int i = 0; i< column_no ; i++)
		{
			for( int j =0; j <row_no ; j++)
			{
				if( i == 0 || j  ==0)
				{
					single_k[which_i][i][j] = 0;
				}
				else
				{
					int index_word = instanceListHash.get(row_str_word[j]);
					single_k[which_i][i][j]  = score_table[index_word][1] * single_k[which_i][i][j-1] + double_k[i][j];
					
				}

			}
		}


	}

	//creates Ki" matrix   i = which_i
	void double_k_create( int which_i, int row_index, int column_index)
	{
		for(int i = 0 ; i < column_no ; i++)
		{
			for( int j =0; j<row_no ; j++)
			{
				if( i ==0 || j ==0)
				{
					double_k[i][j] = 0;
					continue;
				}

				if( i < which_i || j < which_i)
				{
					double_k[i][j] = 0;

				//	if ( which_i == 2)
				//		System.out.println("value of i and j " + i + "  ___  " + j);
				}
				else
				{
				/*		String check_this = column_str_word[i];
						try{
							int index_word = instanceListHash.get(column_str_word[i]);
							
						}catch (Exception E)
							{
								System.out.println(" -- "  + i + column_str_word[i]);
							}
				*/
				int index_word = instanceListHash.get(column_str_word[i]);
					if( matche_String_table[i][j] == true)
					{
						//int index_word = instanceListHash.get(column_str_word[i]);											
						if( which_i ==1)
						{
							double_k[i][j]  = score_table[index_word][1] * double_k[i-1][j] + 
									score_table[index_word][2] * 1;		
						}
						else
						{

							double_k[i][j]  = score_table[index_word][1] * double_k[i-1][j] + 
									score_table[index_word][2] * single_k[which_i -2][i-1][j-1];  
									// which_i -2 b'coz single_k start from 0 index in single_k matrix	
						}

					}
					else
					{
						//int index_word = instanceListHash.get(column_str_word[i]);											
						double_k[i][j] = score_table[index_word][1] * double_k[i-1][j];
					}
				}

/*				if(which_i == 2 && column_index == 0 && row_index==0)
				{
						System.out.println("\n" +i + "I AND J  " + j);
					for(int l = 1 ; l < column_no ; l++)
					{
						for( int m =1 ; m <row_no ; m++)
						{
							System.out.print("      " + double_k[l][m]) ;
						}
							System.out.println(" ");

					}
				}
*/

			}
		}
	}


	//creates matche matrix which contains boolean value
	//a = no of words in str1
	//b = no of words in str2
	//creates matrix of size [ max(a,d)]  [ min (a,b) ]
	
	void create_matche_String_table( String str1 ,String str2)
	{
	
		String []temp;
		
		str1 = "a " + str1 ;    	// to make array starting array index from 1 attached one word at 0 index
		str2 = "a " + str2 ;		// to make array starting array index from 1 attached one word at 0 index

		row_str_word = str1.split("\\s" );
		column_str_word = str2.split("\\s" );

		//System.out.println(str1 + "\n" + str2);
		
		if( row_str_word.length <= column_str_word.length)
		{
			row_no = row_str_word.length  ;		// starting index from 1 
			column_no = column_str_word.length ;		// starting index from 1

		}
		else
		{
			row_no = column_str_word.length  ;
			column_no = row_str_word.length ;

			temp = row_str_word;
			row_str_word = column_str_word;
			column_str_word = temp;


		}

	//	System.out.println( row_str_word.length + "==" + column_str_word.length  );

		matche_String_table = new boolean[column_no][row_no];
/*
		for( int i = 1 ; i < column_no ; i++)
				System.out.println(column_str_word[i]);

		for( int i = 1 ; i < row_no; i++)
				System.out.println(row_str_word[i]);

*/
		for( int i = 1 ; i < column_no ; i++)
		{
			for ( int j = 1 ; j < row_no ; j++)
			{
				if( column_str_word[i].compareTo( row_str_word[j]) == 0)
				{
					matche_String_table[i][j] = true ;
				}
				else
				{
					matche_String_table[i][j] = false  ;
				}

				//System.out.print("    " + matche_String_table[i][j] );

			}

				//System.out.println( );
		}
			
	}

    
    void create_matrix() throws EOFException,IOException,FileNotFoundException,ArrayStoreException,NullPointerException
    {
		
		String instanceListPath = instanceList.getAbsolutePath();
		FileReader fileReader = new FileReader(instanceListPath);
		BufferedReader bufferedReader = new BufferedReader(fileReader);
		
		//no_of words stored in 1st line of instance-list
		 no_of_words = Integer.valueOf(bufferedReader.readLine()).intValue();   
		
		score_table = new double[no_of_words+1][3];  // starting from 1 

		String instance = bufferedReader.readLine();



		String outputFilePath = outputFile.getAbsolutePath();
    		FileWriter fileWriter = new FileWriter(outputFilePath ,true);
		BufferedWriter bufferedWriter = new BufferedWriter(fileWriter);
		
		String outData = new String();
		String one_line = new String();

		int nth_intance =1 ; 
		while(instance != null)
		{
			//storing the word as key and 1 as value in instanceListHash
			String []word_score = instance.split("\\s");        //

//			System.out.println(instance + " ===== " + word_score[0]);
			instanceListHash.put(word_score[0] , nth_intance);	//store word in to Hash table 
			
			score_table[nth_intance][0] = Double.valueOf(word_score[1]).doubleValue();
			score_table[nth_intance][1] = Double.valueOf(word_score[2]).doubleValue();
			score_table[nth_intance][2] = Double.valueOf(word_score[3]).doubleValue();
			
//			System.out.println(nth_intance + " ===== " + word_score[0]);
			nth_intance++;

			instance = bufferedReader.readLine();
		}
		bufferedReader.close();
		fileReader.close();


		//System.out.println(instanceListHash.size() + "\n");
		
		//considering each review file 1 by 1
		File[] inputRevFiles = inputRevDir.listFiles();
		Arrays.sort(inputRevFiles);
		
		no_of_file  = inputRevFiles.length ;

		kernel_value_matrix  = new double[value_n][no_of_file][no_of_file];

		for(int i=0; i < inputRevFiles.length; i++)
		{
			File inputRevFile = inputRevFiles[i];
			String inputRevFilePath = inputRevFile.getAbsolutePath();
			
			String inputRevFileName = inputRevFile.getName();
			System.out.println(inputRevFileName + "\n");
		
			String file_one = inputRevFileName;

			FileReader fileReader_Rev = new FileReader(inputRevFilePath);
			BufferedReader bufferedReader_Rev = new BufferedReader(fileReader_Rev);
		 	
		 	
		 	String line_Rev_1 = bufferedReader_Rev.readLine();

			for(int j = 0 ; j <= i  ; j++)
			{

			//	if( i == j)
			//		continue;

				inputRevFile = inputRevFiles[j];
				inputRevFilePath = inputRevFile.getAbsolutePath();
			
				inputRevFileName = inputRevFile.getName();
				
			//	System.out.println(file_one + "======"+ inputRevFileName + "\n");
			
				fileReader_Rev = new FileReader(inputRevFilePath);
				bufferedReader_Rev = new BufferedReader(fileReader_Rev);
		 			
		 		String line_Rev_2 = bufferedReader_Rev.readLine();
		
			//	System.out.println(line_Rev_1 + "==========" + line_Rev_2);
				
				create_matche_String_table(line_Rev_1 ,line_Rev_2);

			//	System.out.println(line_Rev_1 + "==========" + line_Rev_2);
				double_k = new double[column_no][row_no];
				single_k = new double[value_n-1][column_no][row_no];

				for( int l =  1; l < value_n ; l++)
				{
					double_k_create(l,i,j);        // passing i and j for dubuge purpose
					//if ( l == 2)
					//	break;
					single_k_create(l);
				}

				create_one_to_n_kernel(i , j);

/*

				for(int l = 1 ; l < column_no ; l++)
				{
					for( int m =1  ; m < row_no ; m++)
					{
						System.out.print("      " + single_k[0][l][m] ) ;
					}

						System.out.println("  ");

				}

*/
			}


			
    		}


// My code
                 
                bufferedWriter.write(""+no_of_file+"\n");
//end of my code
		for(int i = 0 ; i < no_of_file ; i++)
		{

			for(int j =  0; j<no_of_file; j++)
			{

					outData = outData  + kernel_value_matrix[0][i][j] ;
					for( int m =1 ; m < value_n ; m++)
					{
						 outData = outData +"_"+ kernel_value_matrix[m][i][j] ;
					}
					one_line = one_line +" "+ outData;
						outData = "";
			}
			bufferedWriter.write(one_line + "\n");
			one_line = "";
		}
	
			//bufferedWriter.write(outData);   
			bufferedWriter.close();
			fileWriter.close();

/*          		
 *
    		
    		bufferedReader_Rev.close();
			fileReader_Rev.close();
			bufferedReader_RevPOS.close();
			fileReader_RevPOS.close();
		
			if(outData == "")emptyExtract_count++;
			//writing extract to outfile
    		FileWriter fileWriter = new FileWriter(outputDirPath + "/" + inputRevFileName);
			BufferedWriter bufferedWriter = new BufferedWriter(fileWriter);
			bufferedWriter.write(outData);   
			bufferedWriter.close();
			
			total_rev_length += rev_line_count;
			total_extract_length += extract_line_count;
		}
		System.out.println("no. of empty extracts = " + emptyExtract_count);
		
		avg_extract_pc = ((double)total_extract_length/total_rev_length)*100;
		System.out.println("avg_extract_pc = " + avg_extract_pc);


		*/
	}

	public static void main(String[] args) {
        try {
            new Kernel_matrix_Create(args).create_matrix();
        } catch (Throwable t) {
            System.out.println("Thrown: " + t);
            t.printStackTrace(System.out);
        }
    }
}

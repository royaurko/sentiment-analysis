import java.io.*;
import java.util.*;
import java.lang.*;
import javax.swing.*;


public class Normalize_matrix{
	
	File instanceList;
	File outputDir;
	
	int no_of_fold = 5;
	float myu_1 = 1;    // for myu = 0.5 and n = 3 its turns out that u1 = 1 u2 = 2 and u3 = 4
	float myu_2 = 0;
	float myu_3 = 0;
	Normalize_matrix(String[] args){
		instanceList = new File(args[0]);
	//	outputDir = new File(args[1]);
	}

	//this code takes input kernel_matris  "format is for k(xi , xj) =  k1/k1/k3  for all xi and xj
	//and converts into 5 fold training and test file using    formated   k(xi, xj) = myu_1 * k1 + myu_2 * k2 + myu_3 * k3
    
    void create_files() throws EOFException,IOException,FileNotFoundException,ArrayStoreException
    {
		
		String instanceListPath = instanceList.getAbsolutePath();
		FileReader fileReader = new FileReader(instanceListPath);
		BufferedReader bufferedReader = new BufferedReader(fileReader);
		
		//template stored in 1st line of instance-list   no of rows in matrix
		
		String template = bufferedReader.readLine();
		int no_of_row =   Integer.valueOf(template).intValue();
		
		String[][] kernel_matrix = new String[no_of_row +1][no_of_row+1];
		
		double[][] diagonal_vlaue = new double[no_of_row +1][3];

			String instance = bufferedReader.readLine();
			int row_index =1;
		while( instance != null)
		{
			kernel_matrix[row_index++] = instance.split("\\s");		
			instance = bufferedReader.readLine();
		}

		
		bufferedReader.close();
		fileReader.close();
		
		for(int i =1; i<= no_of_row ; i++)
		{
			String[] value_of_ii = kernel_matrix[i][i].split("_");
			diagonal_vlaue[i][0] =  Double.valueOf(value_of_ii[0]).doubleValue(); 
			diagonal_vlaue[i][1] =  Double.valueOf(value_of_ii[1]).doubleValue(); 
			diagonal_vlaue[i][2] =  Double.valueOf(value_of_ii[2]).doubleValue(); 
		}
	
		String final_kernel_value = "";
		for(int i = 1; i<= no_of_row ; i++)
		{
			for( int j = 1; j <= no_of_row ;j++)
			{
				String[] value_kernel_one_to_n = kernel_matrix[i][j].split("_");
				final_kernel_value = final_kernel_value  + " " + 
							(Double.valueOf(value_kernel_one_to_n[0]).doubleValue()/(double) Math.sqrt( diagonal_vlaue[i][0] *diagonal_vlaue[j][0])) + "_" +  
				(Double.valueOf(value_kernel_one_to_n[1]).doubleValue()/ (double)Math.sqrt( diagonal_vlaue[i][1] *diagonal_vlaue[j][1]))
				+"_"+  (Double.valueOf(value_kernel_one_to_n[2]).doubleValue()/ (double)									Math.sqrt( diagonal_vlaue[i][2] *diagonal_vlaue[j][2])); 

			}
			System.out.println( final_kernel_value);
			final_kernel_value = "";
		}
/*		for(int i=1 ; i<= no_of_row ; i++)
		{
			for(int j = 1; j<= no_of_row ; j++)
			{
				System.out.print( kernel_matrix[i][j] + "   ");
			}
			System.out.println("");
		}
*/			
		/*	FileWriter[] fileWriter_test = new FileWriter[no_of_fold];
			FileWriter[] fileWriter_train = new FileWriter[no_of_fold];

			BufferedWriter[] bufferedWriter_test = new BufferedWriter[no_of_fold];
			BufferedWriter[] bufferedWriter_train = new BufferedWriter[no_of_fold];

			String outputDirPath = outputDir.getAbsolutePath();

			for(int m = 0 ;m <no_of_fold ; m++)
			{

					fileWriter_test[m] = new FileWriter(outputDirPath + "/fold_"+ m + "/test_fold_" + m,true);
					fileWriter_train[m] = new FileWriter(outputDirPath + "/fold_"+ m + "/train_fold_" + m,true);
					
					bufferedWriter_test[m] = new BufferedWriter(fileWriter_test[m]);
					bufferedWriter_train[m] = new BufferedWriter(fileWriter_train[m]);
		

			}

		bufferedReader.close();
		fileReader.close();

		String[] train_data = new String[no_of_fold];
		String[] test_data  = new String[no_of_fold];
		int[][] index_test_data = new int[no_of_fold][2];   // stores value of current index  for input of libSVM
		int[][] index_train_data = new int[no_of_fold][2];

		for(int i= 0 ;i< no_of_fold; i++)
		{
			train_data[i] = new String();
			test_data[i] = new String();

			index_test_data[i][0]  = 1;		//stores index of test data point
			index_test_data[i][1]  = 1;		//stores current index of feature
			index_train_data[i][0] = 1;
			index_train_data[i][1] = 1;
		}

		for(int i =1; i <= no_of_row; i++)
		{
			System.out.println(i);
			for( int f = 0 ; f< no_of_fold ;f++)
			{
				if( i % no_of_fold ==f)			// put ith row in fth fold test
				{
						if( i <= (no_of_row/2))
						{
							test_data[f] = test_data[f] + "-1 0:" + index_test_data[f][0];
							index_test_data[f][0] += 1;
						}
						else
						{
							test_data[f] = test_data[f] + "+1 0:" + index_test_data[f][0];
							index_test_data[f][0] += 1;
						}
					for( int j = 1; j<= no_of_row ; j++)
					{	

						if( j % no_of_fold != f)    // 
						{
							String[] value_kernel_one_to_n = kernel_matrix[i][j].split("/");

							float final_kernel_value = 
								myu_1 * (Double.valueOf(value_kernel_one_to_n[0]).doubleValue()/(double) Math.sqrt( diagonal_vlaue[i][0] *diagonal_vlaue[j][0])) 
								+  myu_2 * (Double.valueOf(value_kernel_one_to_n[1]).doubleValue()/ (double)
									Math.sqrt( diagonal_vlaue[i][1] *diagonal_vlaue[j][1])) 
									+  myu_3 * (Double.valueOf(value_kernel_one_to_n[2]).doubleValue()/ (double)									Math.sqrt( diagonal_vlaue[i][2] *diagonal_vlaue[j][2])); 

							test_data[f] = test_data[f] + " " + index_test_data[f][1]+ ":" +final_kernel_value; 
							
							index_test_data[f][1] += 1;
						}	
					}
					test_data[f] = test_data[f] + "\n";
							index_test_data[f][1] = 1;
				}		
				else		// else put ith row in fth fold train set
				{
						if( i <= (no_of_row/2))
						{
							train_data[f] = train_data[f] + "-1 0:" + index_train_data[f][0];
							 index_train_data[f][0] += 1;
						}
						else
						{
							train_data[f] = train_data[f] + "+1 0:" + index_train_data[f][0];;
 							index_train_data[f][0] += 1;
						}
					for( int j = 1; j<= no_of_row ; j++)
					{
						if( j % no_of_fold != f)    // 
						{
							String[] value_kernel_one_to_n = kernel_matrix[i][j].split("/");
							
							
							float final_kernel_value = 
										myu_1 * (Double.valueOf(value_kernel_one_to_n[0]).doubleValue() /(double) Math.sqrt( diagonal_vlaue[i][0] *diagonal_vlaue[j][0])) 
									+  myu_2 * (Double.valueOf(value_kernel_one_to_n[1]).doubleValue() /(double) Math.sqrt( diagonal_vlaue[i][1] *diagonal_vlaue[j][1])) 
									+  myu_3 * (Double.valueOf(value_kernel_one_to_n[2]).doubleValue()/ (double)Math.sqrt( diagonal_vlaue[i][2] *diagonal_vlaue[j][2])) ;

							train_data[f] = train_data[f] + " " + index_train_data[f][1] +":"+ final_kernel_value;

							index_train_data[f][1] += 1;
						}	
					}
							train_data[f] = train_data[f] + "\n"; 
							index_train_data[f][1] = 1;
				}
			}

//			String outputDirPath = outputDir.getAbsolutePath();
			if(i % 3 == 0)
			{
				for(int m = 0; m< no_of_fold ;m++)
				{
			
				//	FileWriter fileWriter = new FileWriter(outputDirPath + "/fold_"+ m + "/test_fold_" + m,true);
				//	BufferedWriter bufferedWriter = new BufferedWriter(fileWriter);
					bufferedWriter_test[m].write(test_data[m]);   
				//	bufferedWriter_.close();

				//	fileWriter = new FileWriter(outputDirPath + "/fold_" +m+ "/train_fold_" + m,true);
				//	bufferedWriter = new BufferedWriter(fileWriter);
					bufferedWriter_train[m].write(train_data[m]);   
				//	bufferedWriter.close();

					test_data[m] = "";
					train_data[m] = "";
				}

			}
		}
			for(int m = 0; m< no_of_fold; m++)
			{
					bufferedWriter_test[m].write(test_data[m]);   
					bufferedWriter_train[m].write(train_data[m]);  
					
					bufferedWriter_train[m].close();
					bufferedWriter_test[m].close();

			}
*/

/*			for(int j = 0; j< no_of_fold ; j++)
			{
				System.out.print( "train data fold no = "+ j +"\n"+train_data[j] + "   "+ "\n");
				System.out.print( "test data fold no = " + j + "\n" + test_data[j] + "   " + "\n");
				
				
			}
*/
	
	/*
		String outputDirPath = outputDir.getAbsolutePath();
				
	    	

		for(int i = 0; i< no_of_fold ;i++)
		{
		
			FileWriter fileWriter = new FileWriter(outputDirPath + "/fold_"+ i + "/test_fold_" + i);
			BufferedWriter bufferedWriter = new BufferedWriter(fileWriter);
			bufferedWriter.write(test_data[i]);   
			bufferedWriter.close();

			fileWriter = new FileWriter(outputDirPath + "/fold_" +i+ "/train_fold_" + i);
			bufferedWriter = new BufferedWriter(fileWriter);
			bufferedWriter.write(train_data[i]);   
			bufferedWriter.close();


		}
	*/		
	}

	public static void main(String[] args) {
        try {
            new Normalize_matrix(args).create_files();
        } catch (Throwable t) {
            System.out.println("Thrown: " + t);
            t.printStackTrace(System.out);
        }
    }
}

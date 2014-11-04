import java.io.*;
import java.util.*;
import java.lang.*;
import javax.swing.*;

// This code counts IDF score(Decay factor) for each word
// IDF (word1)   = log ( N /NP)
// where N = total no of document
//
// Decay(word) = IDF(word) / Log N
//
//Input path of Dir containg rev.
//java InverseDocument_freqCount revDir >> score_table 

public class InverseDocument_freqCount
{
	
	File inputRevDir;
	File outputFile;
	int no_of_document;
	
	InverseDocument_freqCount(String[] args){
		inputRevDir = new File(args[0]);
		outputFile = new File(args[1]);
	}
    
    void count_score() throws EOFException,IOException,FileNotFoundException,ArrayStoreException
    {
		String outputDirPath = inputRevDir.getAbsolutePath();
		File[] inputRevFiles = inputRevDir.listFiles();
		
		Arrays.sort(inputRevFiles);
	
		no_of_document = inputRevFiles.length;

		
		
		Hashtable<String, Integer> instanceListHash = new Hashtable<String, Integer>();
		Hashtable<String, Integer> documentListHash[] = new Hashtable[no_of_document];
//		Hashtable instanceListHash = new Hashtable();
//		Hashtable documentListHash[] = new Hashtable[no_of_document];

		for ( int i =0 ;i< no_of_document; i++)
		{
			documentListHash[i] = new Hashtable<String, Integer>();
		}
		
		int count_word =0 ;	
		
		for(int j=0; j<inputRevFiles.length; j++)
		{
			int file_word_count = 0;
			File inputRevFile = inputRevFiles[j];
			String inputRevFilePath = inputRevFile.getAbsolutePath();
			
			String inputRevFileName = inputRevFile.getName();
			//System.out.println(inputRevFileName + "\n");


			
			FileReader fileReader_Rev = new FileReader(inputRevFilePath);
			BufferedReader bufferedReader_Rev = new BufferedReader(fileReader_Rev);
		 	
		 	
		 	String file_line = bufferedReader_Rev.readLine();

			String []words = file_line.split(" ");
			for( int i =0 ; i< words.length ; i++)
			{
				if(!documentListHash[j].containsKey( words[i]) )
				{
					documentListHash[j].put(words[i],count_word++);
				}
				if(!instanceListHash.containsKey(words[i]))
				{
					instanceListHash.put(words[i],file_word_count++);
				}

			}

			bufferedReader_Rev.close();
			fileReader_Rev.close();
			
				
    		}

		instanceListHash.remove("");

	String[] sorted_word = new String[instanceListHash.size()];
	Enumeration e = instanceListHash.keys();
	int local_count =0;
	while( e. hasMoreElements() )
	{
			String temp_word =  (String)e.nextElement() ;
			//sorted_word[local_count++] = (String)e.nextElement() ;
			if (temp_word.length() == 0)
				continue;
			sorted_word[local_count++] = temp_word ;
			instanceListHash.remove(sorted_word[local_count-1]);
	}

	Arrays.sort(sorted_word);


	for(int j =0 ; j< sorted_word.length ; j++)
	{
		instanceListHash.put( sorted_word[j] , j);
	//	System.out.println(sorted_word[j]);
	}

	int[] score_table = new int[sorted_word.length];
	for(int i = 0 ; i< sorted_word.length ; i++)
	{
		int file_count = 0;
		for( int j =0 ; j< no_of_document ; j++)
		{	
			if(documentListHash[j].containsKey(sorted_word[i]))
			{
				file_count++;
			}
		}
		score_table[i] = file_count;
	}

	System.out.println(sorted_word.length);	
	double match_idf,gap_idf,square_match_idf;	
	for(int j =0 ; j< sorted_word.length ; j++)
	{
		match_idf = (double)((Math.log((double) (no_of_document /score_table[j]) )/ Math.log ((double )no_of_document)));
		gap_idf = (double )(1 - match_idf) ;
		square_match_idf =(double)( match_idf * match_idf );

		System.out.println(sorted_word[j] +  " " + match_idf +  " " + gap_idf + " " + square_match_idf );
	}

	}

	public static void main(String[] args) {
        try {
            new InverseDocument_freqCount(args).count_score();
        } catch (Throwable t) {
            System.out.println("Thrown: " + t);
            t.printStackTrace(System.out);
        }
    }
}

import java.io.*;
import java.util.*;
import java.lang.*;
import javax.swing.*;

// This code removes stopword and symbols like (, $ %) from the text 
// 1st parameter  is dir path containing texts file
// 2nd   "        is file path containing stopwords
// 3rd   "        is output dir path

public class Remove_stopword
{
	File inputRevDir;
	File stopword_file;
	File outputDir;

	Remove_stopword( String[] args) 
	{
		inputRevDir = new File(args[0]);
		stopword_file = new File(args[1]);
		outputDir = new File(args[2]);
	}

  public static boolean IsDigit(char c)
  {
                 if(((c-48) >= 0) &&     ((c-48) <=9) )
		 {
                          return true;
		  }
		          return false;
   }

public String justStem(String word)
        {
                char[] w = new char[501];
                Stemmer stemmer = new Stemmer();
                for (int i = 0; i < word.length(); i++)
                {
                        int ch = word.charAt(i);
                        if (Character.isLetter((char) ch))
                        {
                                stemmer.add((char)ch);
                        }
                        else
                                break;
                }
                stemmer.stem();
                String u = stemmer.toString();
                return u;
        }
		
    	void remove_stopword() throws EOFException,IOException,FileNotFoundException,ArrayStoreException
    	{

		Hashtable<String, Integer> stopword_Hash = new Hashtable<String, Integer>(1000);
		
		//reading the words from stopword file and storing in wordlistHash
		String stopword_listPath = stopword_file.getAbsolutePath();
		FileReader stopword_reader = new FileReader(stopword_listPath);
		BufferedReader stopword_bufferedReader = new BufferedReader(stopword_reader);
		
		//template stored in 1st line of instance-list
		String stopword_word = stopword_bufferedReader.readLine();
		//System.out.println(template_tags[0] + "\n" + template_tags[1]);
		
		String instance = stopword_bufferedReader.readLine();
		while(instance != null){
			//storing the word as key and 1 as value in instanceListHash
			stopword_Hash.put(instance,1);
			instance = stopword_bufferedReader.readLine();
		}
		stopword_bufferedReader.close();
		stopword_reader.close();
		//System.out.println(instanceListHash.size() + "\n");
		
		String outputDirPath = outputDir.getAbsolutePath();
		
		//considering each review file 1 by 1
		File[] inputRevFiles = inputRevDir.listFiles();
		Arrays.sort(inputRevFiles);

		
		for(int j=0; j<inputRevFiles.length; j++)
		{
			File inputRevFile = inputRevFiles[j];
			String inputRevFilePath = inputRevFile.getAbsolutePath();
			
			String inputRevFileName = inputRevFile.getName();
			//System.out.println(inputRevFileName + "\n");
			
			FileReader rev_fileReader = new FileReader(inputRevFilePath);
			BufferedReader rev_bufferedReader = new BufferedReader(rev_fileReader);

			String line = rev_bufferedReader.readLine();
			String final_file = new String();


				int stop =0 ;	
			while( line != null)
			{
				//System.out.println(line );
			

				line = line.replaceAll("-"," ");
				line = line.replaceAll("\'"," ");
				line = line.replaceAll("_"," ");
				line = line.replaceAll(","," ");
			//	line = line.replaceAll(". "," ");
			//	line = line.replaceAll(" ."," ");
				
				line = line.replaceAll("[\\W&&[^,.;\']]"," ");
				
			//	line = line.replaceAll("\""," ");
		//		line = line.replaceAll("\\s\\s","\\s");
		//		line = line.replaceAll("\\s\\s\\s","\\s");

				String []words = line.split("\\s");
				for ( int word_index = 0 ; word_index < words.length ; word_index++)
				{
				//	words[word_index] = justStem(words[word_index]);
					
				//	if(words[word_index].length() >1j !IsDigit(words[word_index].charAt(1)) && !IsDigit(words[word_index].charAt(2)) )
					if(words[word_index].length() == 0)
						continue;
					if ( !IsDigit(words[word_index].charAt(0))  && !stopword_Hash.containsKey( words[word_index] ))
					{
						if(stop == 0)
						{
							final_file = words[word_index];
							stop =1;
						}
						else
						{
							final_file = final_file +" " +words[word_index];
						}
					}

				}
				line = rev_bufferedReader.readLine();

			}

				//System.out.println(final_file );
    			rev_bufferedReader.close();
			rev_fileReader.close();

    			FileWriter fileWriter = new FileWriter(outputDirPath + "/" + inputRevFileName);
			BufferedWriter bufferedWriter = new BufferedWriter(fileWriter);
			bufferedWriter.write(final_file);   
			bufferedWriter.close();
			
		 	

    		}

	}			
	public static void main(String[] args) 
	{
        	try 
		{
            		new Remove_stopword(args).remove_stopword();
        	} catch (Throwable t) 
		{
            		System.out.println("Thrown: " + t);
            		t.printStackTrace(System.out);
        	}
    	}
			

	
}
/*
public class Extract_NegPosTemplates{
	
	File inputRevDir;
	File inputRevPOSDir;
	File instanceList;
	File outputDir;
	
	Extract_NegPosTemplates(String[] args){
		inputRevDir = new File(args[0]);
		inputRevPOSDir = new File(args[1]);
		instanceList = new File(args[2]);
		outputDir = new File(args[3]);
	}
    
    void extract_NegPosTemplates() throws EOFException,IOException,FileNotFoundException,ArrayStoreException{
    	//for each reviewPOS, we go thru each sentence and if it contains any instance from the instanceList (and matching the template ofcourse) 
    	//then we add the corresponding sentence of review (the one without the POS tags) to the extract outfile.
    	
    	//hashtable for storing the unique words (from the instanceList) as keys and 1 as value. 
		Hashtable<String, Integer> instanceListHash = new Hashtable<String, Integer>(10000);
		
		//reading the words from file and storing in wordlistHash
		String instanceListPath = instanceList.getAbsolutePath();
		FileReader fileReader = new FileReader(instanceListPath);
		BufferedReader bufferedReader = new BufferedReader(fileReader);
		
		//template stored in 1st line of instance-list
		String template = bufferedReader.readLine();
		String[] template_tags = template.split(" ");
		//System.out.println(template_tags[0] + "\n" + template_tags[1]);
		
		String instance = bufferedReader.readLine();
		while(instance != null){
			//storing the word as key and 1 as value in instanceListHash
			instanceListHash.put(instance,1);
			instance = bufferedReader.readLine();
		}
		bufferedReader.close();
		fileReader.close();
		//System.out.println(instanceListHash.size() + "\n");
		
		String outputDirPath = outputDir.getAbsolutePath();
		
		//considering each review file 1 by 1
		File[] inputRevFiles = inputRevDir.listFiles();
		File[] inputRevPOSFiles = inputRevPOSDir.listFiles();
		
		int emptyExtract_count = 0;
		int total_rev_length = 0;
		int total_extract_length = 0;
		float avg_extract_pc = 0;
		
		for(int j=0; j<inputRevFiles.length; j++){
			File inputRevFile = inputRevFiles[j];
			String inputRevFilePath = inputRevFile.getAbsolutePath();
			File inputRevPOSFile = inputRevPOSFiles[j];
			String inputRevPOSFilePath = inputRevPOSFile.getAbsolutePath();
			
			String inputRevFileName = inputRevFile.getName();
			System.out.println(inputRevFileName + "\n");
			
			FileReader fileReader_Rev = new FileReader(inputRevFilePath);
			BufferedReader bufferedReader_Rev = new BufferedReader(fileReader_Rev);
		 	
		 	FileReader fileReader_RevPOS = new FileReader(inputRevPOSFilePath);
			BufferedReader bufferedReader_RevPOS = new BufferedReader(fileReader_RevPOS);
		 	
		 	String line_Rev = bufferedReader_Rev.readLine();
		 	String line_RevPOS = bufferedReader_RevPOS.readLine();
			
			int rev_line_count = 0;
			int extract_line_count = 0;
			
			String outData = "";
			while(line_Rev != null && line_RevPOS != null){
				rev_line_count++;
				//for each line(sentence) from the review, we check it contains any instance from the instanceListHash....
				//...if yes, we keep that sentence in the extract
			
				//splitting the reviewPOS-sentence into word-tokens
				String[] line_RevPOS_word_tokens = line_RevPOS.split("[^a-zA-Z0-9_!?/-]");
				String[] line_RevPOS_words = new String[line_RevPOS_word_tokens.length];
				String[] line_RevPOS_tags = new String[line_RevPOS_word_tokens.length];
				int k1 = 0;
				for (int k=0; k<line_RevPOS_word_tokens.length; k++){
					if(line_RevPOS_word_tokens[k].matches("[a-zA-Z0-9_!?/-]+") && line_RevPOS_word_tokens[k].contains("/")){
						String[] temp_token = line_RevPOS_word_tokens[k].split("/");
						if(temp_token.length == 2 && temp_token[0].matches("[a-zA-Z0-9_!?-]+") && temp_token[1].matches("[A-Z]+")){
							line_RevPOS_words[k1] = temp_token[0];
							line_RevPOS_tags[k1] = temp_token[1];
							k1++;
						}
					}
				}
			 	
			 	int line_RevPOS_words_length = k1;
			 	
				//now finding out if there is an instance of the tag-template in the reviewPOS sentence
				for(int p=0; p<(line_RevPOS_words_length-template_tags.length); p++){
					int flag=0;
					instance = "";
					for(int q=0; q<template_tags.length; q++){
						instance = instance + line_RevPOS_words[p+q] + " ";
						//suppose template is JJ NN, i.e. adj noun, then we allow instances of finer templates like JJR NNP etc. also (but we don't allow the reverse i.e if template is JJS NNS, we don't allow instances of superset JJ NN)
						if(line_RevPOS_tags[p+q].contains(template_tags[q]) == false){
							flag=1;
						}
					}
					//to remove last space
					instance = instance.substring(0,instance.length()-1);
					
					//if flag is 0 then it means instance matches template
					//AND if this matching instance is in instanceList...
					//...then the sentence contains an instance from the list so we include that sentence in our extract
					if(flag==0 && instanceListHash.containsKey(instance)){
						//System.out.println("instance = " + instance);
						outData = outData + line_Rev + "\n";
						extract_line_count++;
						break;
					}
				}
			 	
				line_Rev = bufferedReader_Rev.readLine();
				line_RevPOS = bufferedReader_RevPOS.readLine();
    		}
    		
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
		
		avg_extract_pc = ((float)total_extract_length/total_rev_length)*100;
		System.out.println("avg_extract_pc = " + avg_extract_pc);
	}

	public static void main(String[] args) {
        try {
            new Extract_NegPosTemplates(args).extract_NegPosTemplates();
        } catch (Throwable t) {
            System.out.println("Thrown: " + t);
            t.printStackTrace(System.out);
        }
    }
}*/

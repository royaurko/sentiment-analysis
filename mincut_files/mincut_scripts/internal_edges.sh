#!/bin/bash

sed "s\_\ \g" | awk ' 	
		BEGIN {id = 3}
		{ 
			id_to = 3;
			for(i =1 ; i<= NF-2 ; i= i+3) 
			{
				if( id_to != id) 
				{
					data = $i * 1000;

					if( $(i+1) != 0.0)
						data1 = (-1/log($(i+1)) * 100);
					if( $(i+2) != 0.0)
						data2 = (-1/log($(i+2)) * 100);

					print "a " id " " id_to " "  int(data   + data1 *0 + 0 * data2 * 2) ; 
				
				}
				data = 0;
				data1 = 0;
				data2 = 0;
					
					id_to++;
				
			}
			id++;

}' 


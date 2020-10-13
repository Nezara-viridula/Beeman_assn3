#! /bin/bash

#Make directory for all files

mkdir Assn_3

#make back up copy of data set and move it to new directory

cp BTS_data.txt BTS_dataAS3cp.txt

mv BTS_dataAS3cp.txt /mnt/c/Users/morgan/Desktop/coding/unix_2_files/Assn_3

#cd into directory to work in

cd /mnt/c/Users/morgan/Desktop/coding/unix_2_files/Assn_3

#cut unique snakeID from BTSdatacp.txt and make into a new file

cut -f1 BTS_dataAS3cp.txt | sort | uniq | grep -v ID > unique_snakeID.txt 

#make for each line in unique_snakeID.txt into a file

while read line; do touch file_$line; done < unique_snakeID.txt 

#Make an array with unique ID names and check number of elements created 
ID_array=($(cut -f1 BTS_dataAS3cp.txt | grep -v ID | sort | uniq))
echo "${#ID_array[@]} array elements. Files are now being created."

#use for loop to grep corrosponding data for each file
for ID in ${ID_array[@]}; do grep "$ID" BTS_dataAS3cp.txt > file_"$ID"; done

#remove intermediate files 
rm BTS_dataAS3cp.txt unique_snakeID.txt

#double check number of files
ls | echo "There were $(wc -l) files created in this directory"

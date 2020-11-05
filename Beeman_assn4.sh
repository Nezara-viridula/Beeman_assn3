#! /bin/bash

#Always make backup file
cp possible_voters.txt possible_votersbackup.txt

#cut age data and remove header
cut -f2 possible_voters.txt | grep -v Age >> voters_age.txt

#make loop to read yes/no based of voter age

while read line; do if [ "$line" -lt 18 ]; then
	echo "no"
else
	echo "yes"
fi; done < voters_age.txt >> yesno_voters.txt

#Add header to yes/no file

echo -e "Eligible(y/n)" |cat - yesno_voters.txt > eligible.txt

#now I want to append yes/no data to original file 

paste possible_voters.txt eligible.txt > eligible_voters.txt

#print first 10 lines to page
head possible_voters.txt| column -t
head eligible_voters.txt| column -t

#echo number of eligible voters
grep yes eligible_voters.txt| echo -e "There are $(wc -l) eligible voters this year!"

#clean up files
rm voters_age.txt
rm yesno_voters.txt
rm eligible.txt


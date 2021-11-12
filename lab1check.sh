#!/bin/bash

#display help information
help()
{
echo "Synopsis:"
echo
echo "This script should be in the same directory as your students' namesymkey.bin and namemessage.txt.enc files. This script takes one argument which should be a text file that contains the names your students are using (one per line). The script will iterate through the student names in the file decrypting their encrypted message file and comparing it to what the lab instructions said to create. If the file contains what it should the script displays name: OK. Otherwise it displays name: Not OK."
echo
echo "Syntax: lab2check.sh [-t] namefile.txt"
echo
echo "options:"
echo
echo "h      Print this help page"
echo
}

#get options
while getopts ":h" option; do
   case $option in
      h) #display help
         help
         exit;;
     \?) #incorrect option
         echo "Error: Invalid option"
         exit;;
   esac
done

if [[ $# -eq 0 ]]
then
   echo "You must provide a file with a list of student names as an argument. Run the script with -h option for more information."
fi

filename = $1
while read line; do
file1 = "${line}symkey.bin"
file2 = "${line}message.txt.enc"
file3 = "${line}message.txt"
#Use student's symmetric key file to decrypt students encrypted message file
openssl enc -d -aes-128-cbc -in $filetwo -out $filethree -pass file:./$fileone
#Create a file with the intended content of the decrypted message file
date >> checkmsg.txt
echo "${line} AES Encryption" >> checkmsg.txt
#compare symmetric key file to the one sent by student in lab 1; the -i 29 skips the time/date stamp because those won't match
var1=`cmp -i 29 checkmsg.txt $filethree`
#if the files match, display "OK", otherwise display "Not OK"
if [[ -z "$var1" ]]
then
   echo "${line}: OK"
else
   echo "${line}: Not OK"
fi
#Delete the checking file so it can be recreated for the next student in the loop
rm checkmsg.txt
done < $filename

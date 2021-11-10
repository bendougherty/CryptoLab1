#!/bin/bash

filename = $1
while read line; do
file1 = "${line}symkey.bin"
file2 = "${line}message.txt.enc"
file3 = "${line}message.txt"
openssl enc -d -aes-128-cbc -in $filetwo -out $filethree -pass file:./$fileone
echo $line
cat $filethree
echo " "
done < $filename

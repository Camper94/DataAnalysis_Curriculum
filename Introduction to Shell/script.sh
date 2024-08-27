#Script_Name : script.py
#Description : Introduction to Shell
#Author : Sofiane Boumelit
#Date : August 27, 2024

#Chapter III: Combing Tools
#How can I store a command's output in a file?
#All of the tools you have seen so far let you name input files. 
#Most don't have an option for naming an output file because they don't need one. 
#Instead, you can use redirection to save any command's output anywhere you want. If you run this command:

#head -n 5 seasonal/summer.csv
#it prints the first 5 lines of the summer data on the screen. If you run this command instead:

#head -n 5 seasonal/summer.csv > top.csv
#nothing appears on the screen. Instead, head's output is put in a new file called top.csv. 
#You can take a look at that file's contents using cat:

#cat top.csv
#The greater-than sign > tells the shell to redirect head's output to a file. 
#It isn't part of the head command; instead, it works with every shell command that produces output.

#Combine tail with redirection to save the last 5 lines of seasonal/winter.csv in a file called last.csv

tail -n 5 seasonal/winter.csv > last.csv


#How can I use a command's output as an input?
#Suppose you want to get lines from the middle of a file. 
#More specifically, suppose you want to get lines 3-5 from one of our data files. 
#You can start by using head to get the first 5 lines and redirect that to a file, 
#and then use tail to select the last 3:

#head -n 5 seasonal/winter.csv > top.csv
#tail -n 3 top.csv
#A quick check confirms that this is lines 3-5 of our original file, because it is the last 3 lines of the first 5.

#Select the last two lines from seasonal/winter.csv and save them in a file called bottom.csv.
tail -n 2 seasonal/winter.csv > bottom.csv
#Select the first line from bottom.csv in order to get the second-to-last line of the original file.
head -n 1 bottom.csv


#What's a better way to combine commands?
#Using redirection to combine commands has two drawbacks:

#It leaves a lot of intermediate files lying around (like top.csv).
#The commands to produce your final result are scattered across several lines of history.
#The shell provides another tool that solves both of these problems at once called a pipe. 
#Once again, start by running head:

#head -n 5 seasonal/summer.csv
#Instead of sending head's output to a file, add a vertical bar and the tail command without a filename:

#head -n 5 seasonal/summer.csv | tail -n 3
#The pipe symbol tells the shell to use the output of the command on the left as the input to the command on the right.

#Use cut to select all of the tooth names from column 2 of the comma delimited file seasonal/summer.csv, 
#then pipe the result to grep, with an inverted match, to exclude the header line containing the word "Tooth". 
#cut and grep were covered in detail in Chapter 2, exercises 8 and 11 respectively.
cut -d, -f 2 seasonal/summer.csv | grep -v Tooth

#How can I combine many commands?
#You can chain any number of commands together. For example, this command:
#cut -d , -f 1 seasonal/spring.csv | grep -v Date | head -n 10
#will:
#select the first column from the spring data;
#remove the header line containing the word "Date"; and
#select the first 10 lines of actual data.
#In the previous exercise, 
#you used the following command to select all the tooth names from column 2 of seasonal/summer.csv:

#cut -d , -f 2 seasonal/summer.csv | grep -v Tooth
#Extend this pipeline with a head command to only select the very first tooth name.
cut -d, -f 2 seasonal/summer.csv | grep -v Tooth | head -n 1

#How can I count the records in a file?
#The command wc (short for "word count") prints the number of characters, 
#words, and lines in a file. You can make it print only one of these using -c, -w, or -l respectively.

#Count how many records in seasonal/spring.csv have dates in July 2017 (2017-07).
#To do this, use grep with a partial date to select the lines and pipe this result into wc 
#with an appropriate flag to count the lines.


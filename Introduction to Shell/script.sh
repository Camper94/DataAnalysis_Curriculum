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
grep 2017-07 seasonal/spring.csv | wc -l


#How can I specify many files at once?
#Most shell commands will work on multiple files if you give them multiple filenames. 
#For example, you can get the first column from all of the seasonal data files at once like this:

#cut -d , -f 1 seasonal/winter.csv seasonal/spring.csv seasonal/summer.csv seasonal/autumn.csv
#But typing the names of many files over and over is a bad idea: it wastes time, 
#and sooner or later you will either leave a file out or repeat a file's name. 
#To make your life better, the shell allows you to use wildcards to specify a list of files with a single expression. 
#The most common wildcard is *, which means "match zero or more characters". 
#Using it, we can shorten the cut command above to this:

#cut -d , -f 1 seasonal/*
#or:
#cut -d , -f 1 seasonal/*.csv

#Write a single command using head to get the first three lines from both seasonal/spring.csv and seasonal/summer.csv, 
#a total of six lines of data, but not from the autumn or winter data files. 
#Use a wildcard instead of spelling out the files' names in full.
head -n 3 seasonal/s*.csv

#What other wildcards can I use?
#The shell has other wildcards as well, though they are less commonly used:

#? matches a single character, so 201?.txt will match 2017.txt or 2018.txt, but not 2017-01.txt.
#[...] matches any one of the characters inside the square brackets, so 201[78].txt matches 2017.txt or 2018.txt, 
#but not 2016.txt.
#{...} matches any of the comma-separated patterns inside the curly brackets, 
#so {*.txt, *.csv} matches any file whose name ends with .txt or .csv, but not files whose names end with .pdf.
#Which expression would match singh.pdf and johel.txt but not sandhu.pdf or sandhu.txt?
{singh.pdf, j*.txt}

#How can I sort lines of text?
#As its name suggests, sort puts data in order. 
#By default it does this in ascending alphabetical order, 
#but the flags -n and -r can be used to sort numerically and reverse the order of its output, 
#while -b tells it to ignore leading blanks and -f tells it to fold case (i.e., be case-insensitive). 
#Pipelines often use grep to get rid of unwanted records and then sort to put the remaining records in order.

#Remember the combination of cut and grep to select all the tooth names from column 2 of seasonal/summer.csv?
#cut -d , -f 2 seasonal/summer.csv | grep -v Tooth
#Starting from this recipe, sort the names of the teeth in seasonal/winter.csv (not summer.csv) 
#in descending alphabetical order. To do this, extend the pipeline with a sort step.
cut -d, -f 2 seasonal/winter.csv | grep -v Tooth | sort -r

#How can I remove duplicate lines?
#Another command that is often used with sort is uniq, whose job is to remove duplicated lines. 
#More specifically, it removes adjacent duplicated lines. If a file contains:

#2017-07-03
#2017-07-03
#2017-08-03
#2017-08-03
#then uniq will produce:

#2017-07-03
#2017-08-03
#but if it contains:

#2017-07-03
#2017-08-03
#2017-07-03
#2017-08-03
#then uniq will print all four lines. The reason is that uniq is built to work with very large files. 
#In order to remove non-adjacent lines from a file, 
#it would have to keep the whole file in memory (or at least, all the unique lines seen so far). 
#By only removing adjacent duplicates, it only has to keep the most recent unique line in memory.

#Write a pipeline to:
#get the second column from seasonal/winter.csv,
#remove the word "Tooth" from the output so that only tooth names are displayed,
#sort the output so that all occurrences of a particular tooth name are adjacent; and
#display each tooth name once along with a count of how often it occurs.
#The start of your pipeline is the same as the previous exercise:

#cut -d , -f 2 seasonal/winter.csv | grep -v Tooth
#Extend it with a sort command, 
#and use uniq -c to display unique lines with a count of how often each occurs rather than using uniq and wc.

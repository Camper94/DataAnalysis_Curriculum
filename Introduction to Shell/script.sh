#Script_Name : script.py
#Description : Introduction to Shell
#Author : Sofiane Boumelit
#Date : August 27, 2024

#Chapter III: Combing Tools
#Description: The real power of the Unix shell lies not in the individual commands, 
#but in how easily they can be combined to do new things. 
#This chapter will show you how to use this power to select the data you want, 
#and introduce commands for sorting values and removing duplicates.

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
cut -d, -f 2 seasonal/winter.csv | grep -v Tooth | sort | uniq -c

#How can I save the output of a pipe?
#The shell lets us redirect the output of a sequence of piped commands:
#cut -d , -f 2 seasonal/*.csv | grep -v Tooth > teeth-only.txt
#However, > must appear at the end of the pipeline: if we try to use it in the middle, like this:
#cut -d , -f 2 seasonal/*.csv > teeth-only.txt | grep -v Tooth
#then all of the output from cut is written to teeth-only.txt, 
#so there is nothing left for grep and it waits forever for some input.
#What happens if we put redirection at the front of a pipeline as in:
#> result.txt head -n 3 seasonal/winter.csv

#The command's output is redirected to the file as usual .

#How can I stop a running program?
#The commands and scripts that you have run so far have all executed quickly, 
#but some tasks will take minutes, hours, or even days to complete. 
#You may also mistakenly put redirection in the middle of a pipeline, causing it to hang up. 
#If you decide that you don't want a program to keep running, you can type Ctrl + C to end it. 
#This is often written ^C in Unix documentation; note that the 'c' can be lower-case.
head
^C

#Wrapping up
#To wrap up, you will build a pipeline to find out how many records are in the shortest of the seasonal data files.
#Use wc with appropriate parameters to list the number of lines in all of the seasonal data files. 
#(Use a wildcard for the filenames instead of typing them all in by hand.)
#Use wc with appropriate parameters to list the number of lines in all of the seasonal data files. 
#(Use a wildcard for the filenames instead of typing them all in by hand.)
wc -l seasonal/*.csv

#Add another command to the previous one using a pipe to remove the line containing the word "total".
wc -l seasonal/*.csv | grep -v "total"

#Add two more stages to the pipeline that use sort -n and head -n 1 to find the file containing the fewest lines.
wc -l seasonal/*.csv | grep -v "total" | sort -n | head -n 1

#Chapter VI: Batch Processing
#Description : Most shell commands will process many files at once. 
#This chapter shows you how to make your own pipelines do that. 
#Along the way, you will see how the shell uses variables to store information.

#How does the shell store information?
#Like other programs, the shell stores information in variables. 
#Some of these, called environment variables, are available all the time. 
#Environment variables' names are conventionally written in upper case, 
#and a few of the more commonly-used ones are shown below.

#Variable	Purpose	Value
#HOME	User's home directory	/home/repl
#PWD	Present working directory	Same as pwd command
#SHELL	Which shell program is being used	/bin/bash
#USER	User's ID	repl
#To get a complete list (which is quite long), you can type set in the shell.

#Use set and grep with a pipe to display the value of HISTFILESIZE, 
#which determines how many old commands are stored in your command history. What is its value?
set | grep HISTFILESIZE
HISTFILESIZE=2000

#How can I print a variable's value?
#A simpler way to find a variable's value is to use a command called echo, which prints its arguments. Typing

#echo hello DataCamp!
#prints

#hello DataCamp!
#If you try to use it to print a variable's value like this:

#echo USER
#it will print the variable's name, USER.

#To get the variable's value, you must put a dollar sign $ in front of it. Typing

#echo $USER
#prints

#repl
#This is true everywhere: to get the value of a variable called X, you must write $X. 
#(This is so that the shell can tell whether you mean "a file named X" or "the value of a variable named X".)
#The variable OSTYPE holds the name of the kind of operating system you are using. Display its value using echo.
echo $OSTYPE

#How else does the shell store information?
#The other kind of variable is called a shell variable, which is like a local variable in a programming language.

#To create a shell variable, you simply assign a value to a name:

#training=seasonal/summer.csv
#without any spaces before or after the = sign. Once you have done this, you can check the variable's value with:

#echo $training
#seasonal/summer.csv
#Define a variable called testing with the value seasonal/winter.csv.
head -n 1 $testing

#How can I repeat a command many times?
#Shell variables are also used in loops, which repeat commands many times. If we run this command:

#for filetype in gif jpg png; do echo $filetype; done
#it produces:

#gif
#jpg
#png
#Notice these things about the loop:

#The structure is for …variable… in …list… ; do …body… ; done
#The list of things the loop is to process (in our case, the words gif, jpg, and png).
#The variable that keeps track of which thing the loop is currently processing (in our case, filetype).
#The body of the loop that does the processing (in our case, echo $filetype).
#Notice that the body uses $filetype to get the variable's value instead of just filetype, 
#just like it does with any other shell variable. 
#Also notice where the semi-colons go: the first one comes between the list and the keyword do, 
#and the second comes between the body and the keyword done.
for filetype in docx odt pdf; do echo $filetype; done

#How can I repeat a command once for each file?
#You can always type in the names of the files you want to process when writing the loop, 
#but it's usually better to use wildcards. Try running this loop in the console:

#for filename in seasonal/*.csv; do echo $filename; done
#It prints:

#seasonal/autumn.csv
#seasonal/spring.csv
#seasonal/summer.csv
#seasonal/winter.csv
#because the shell expands seasonal/*.csv to be a list of four filenames before it runs the loop.

#Modify the wildcard expression to people/* so that the loop prints the names of the files 
#in the people directory regardless of what suffix they do or don't have. 
#Please use filename as the name of your loop variable.
for filename in people/*; do echo $filename; done

#How can I record the names of a set of files?
#People often set a variable using a wildcard expression to record a list of filenames. 
#For example, if you define datasets like this:

#datasets=seasonal/*.csv
#you can display the files' names later using:

#for filename in $datasets; do echo $filename; done
#This saves typing and makes errors less likely.

#If you run these two commands in your home directory, how many lines of output will they print?

#files=seasonal/*.csv
#for f in $files; do echo $f; done
#Four:the names of all four seasonal data files.

#A variable's name versus its value
#A common mistake is to forget to use $ before the name of a variable. 
#When you do this, the shell uses the name you have typed rather than the value of that variable.

#A more common mistake for experienced users is to mis-type the variable's name. 
#For example, if you define datasets like this:

#datasets=seasonal/*.csv
#and then type:

#echo $datsets
#the shell doesn't print anything, because datsets (without the second "a") isn't defined.

#If you were to run these two commands in your home directory, what output would be printed?

#files=seasonal/*.csv
#for f in files; do echo $f; done
#(Read the first part of the loop carefully before answering.)
#Answer : One line: the word "files"

#How can I run many commands in a single loop?
#Printing filenames is useful for debugging, but the real purpose of loops is to do things with multiple files. 
#This loop prints the second line of each data file:

#for file in seasonal/*.csv; do head -n 2 $file | tail -n 1; done
#It has the same structure as the other loops you have already seen: 
#all that's different is that its body is a pipeline of two commands instead of a single command.
for file in seasonal/*.csv; do grep 2017-07 $file | tail -n 1;done

#Why shouldn't I use spaces in filenames?
#It's easy and sensible to give files multi-word names like July 2017.csv when you are using a graphical file explorer. 
#However, this causes problems when you are working in the shell. 
#For example, suppose you wanted to rename July 2017.csv to be 2017 July data.csv. You cannot type:

#mv July 2017.csv 2017 July data.csv
#because it looks to the shell as though you are trying to move four files called July, 2017.csv, 2017, 
#and July (again) into a directory called data.csv. 
#Instead, you have to quote the files' names so that the shell treats each one as a single parameter:

#mv 'July 2017.csv' '2017 July data.csv'
#If you have two files called current.csv and last year.csv (with a space in its name) and you type:

#rm current.csv last year.csv
#what will happen: 
#The shell will print an error message because last and year.csv do not exist and The shell will delete current.csv. 

#How can I do many things in a single loop?
#The loops you have seen so far all have a single command or pipeline in their body, 
#but a loop can contain any number of commands. 
#To tell the shell where one ends and the next begins, you must separate them with semi-colons:

#for f in seasonal/*.csv; do echo $f; head -n 2 $f | tail -n 1; done
#seasonal/autumn.csv
#2017-01-05,canine
#seasonal/spring.csv
#2017-01-25,wisdom
#seasonal/summer.csv
#2017-01-11,canine
#seasonal/winter.csv
#2017-01-03,bicuspid
#Suppose you forget the semi-colon between the echo and head commands in the previous loop, 
#so that you ask the shell to run:

#for f in seasonal/*.csv; do echo $f head -n 2 $f | tail -n 1; done
#What will the shell do? Print one line for each of the four files.

#Chapter V: Creating new tools
#Description : History lets you repeat things with just a few keystrokes, 
#and pipes let you combine existing commands to create new ones. 
#In this chapter, you will see how to go one step further and create new commands of your own.

#How can I edit a file?
#Unix has a bewildering variety of text editors. 
#For this course, we will use a simple one called Nano. 
#If you type nano filename, it will open filename for editing (or create it if it doesn't already exist). 
#You can move around with the arrow keys, delete characters using backspace, 
#and do other operations with control-key combinations:

#Ctrl + K: delete a line.
#Ctrl + U: un-delete a line.
#Ctrl + O: save the file ('O' stands for 'output'). You will also need to press Enter to confirm the filename!
#Ctrl + X: exit the editor.

#Run nano names.txt to edit a new file in your home directory and enter the following four lines:

#Lovelace
#Hopper
#Johnson
#Wilson
#To save what you have written, type Ctrl + O to write the file out, 
#then Enter to confirm the filename, then Ctrl + X to exit the editor.
nano names.txt CTRL+O "/home/repl/names.txt" CTRL+X

#How can I record what I just did?
#When you are doing a complex analysis, you will often want to keep a record of the commands you used. 
#You can do this with the tools you have already seen:

#Run history.
#Pipe its output to tail -n 10 (or however many recent steps you want to save).
#Redirect that to a file called something like figure-5.history.
#This is better than writing things down in a lab notebook because it is guaranteed not to miss any steps. 
#It also illustrates the central idea of the shell: 
#simple tools that produce and consume lines of text can be combined in 
#a wide variety of ways to solve a broad range of problems.

#Copy the files seasonal/spring.csv and seasonal/summer.csv to your home directory.
cp seasonal/s* ~

#Use grep with the -h flag (to stop it from printing filenames) and -v Tooth (to select lines 
#that don't match the header line) to select the data records from spring.csv and summer.csv 
#in that order and redirect the output to temp.csv.
grep -h -v Tooth spring.csv summer.csv > temp.csv

#Pipe history into tail -n 3 and redirect the output to steps.txt to save the last three commands in a file. 
#(You need to save three instead of just two because the history command itself will be in the list.)
history | tail -n 3 > steps.txt


#How can I save commands to re-run later?
#You have been using the shell interactively so far. But since the commands you type in are just text, 
#you can store them in files for the shell to run over and over again. 
#To start exploring this powerful capability, put the following command in a file called headers.sh:

#head -n 1 seasonal/*.csv
#This command selects the first row from each of the CSV files in the seasonal directory. 
#Once you have created this file, you can run it by typing:

#Use nano dates.sh to create a file called dates.sh that contains this command:
#cut -d , -f 1 seasonal/*.csv
#to extract the first column from all of the CSV files in seasonal.
nano dates.sh
#Use bash to run the file dates.sh
bash dates.sh

#How can I re-use pipes?
#A file full of shell commands is called a *shell script, or sometimes just a "script" for short. 
#Scripts don't have to have names ending in .sh, 
#but this lesson will use that convention to help you keep track of which files are scripts.

#Scripts can also contain pipes. For example, if all-dates.sh contains this line:

#cut -d , -f 1 seasonal/*.csv | grep -v Date | sort | uniq
#then:

#bash all-dates.sh > dates.out
#will extract the unique dates from the seasonal data files and save them in dates.out.

#A file teeth.sh in your home directory has been prepared for you, but contains some blanks. 
#Use Nano to edit the file and replace the two ____ placeholders with seasonal/*.csv and -c so 
#that this script prints a count of the number of times each tooth name appears in the CSV files in the seasonal directory.
nano teeth.sh
#Use bash to run teeth.sh and > to redirect its output to teeth.out.
bash teeth.sh
#Run cat teeth.out to inspect your results.
bash teeth.sh > teeth.out

#How can I pass filenames to scripts?
#A script that processes specific files is useful as a record of what you did, 
#but one that allows you to process any files you want is more useful. 
#To support this, you can use the special expression $@ (dollar sign immediately followed by at-sign) 
#to mean "all of the command-line parameters given to the script".

#For example, if unique-lines.sh contains sort $@ | uniq, when you run:

#bash unique-lines.sh seasonal/summer.csv
#the shell replaces $@ with seasonal/summer.csv and processes one file. If you run this:

#bash unique-lines.sh seasonal/summer.csv seasonal/autumn.csv
#it processes two data files, and so on.
bash count-records.sh seasonal/*.csv > num-records.out

#How can I process a single argument?
#As well as $@, the shell lets you use $1, $2, and so on to refer to specific command-line parameters. 
#You can use this to write commands that feel simpler or more natural than the shell's. For example, 
#you can create a script called column.sh that selects a single column from a CSV file 
#when the user provides the filename as the first parameter and the column as the second:

#cut -d , -f $2 $1
#and then run it using:

#bash column.sh seasonal/autumn.csv 1
#Notice how the script uses the two parameters in reverse order.

#The script get-field.sh is supposed to take a filename, the number of the row to select, 
#the number of the column to select, and print just that field from a CSV file. For example:

#bash get-field.sh seasonal/summer.csv 4 2
#should select the second field from line 4 of seasonal/summer.csv. Which of 
#the following commands should be put in get-field.sh to do that?
head -n $2 $1 | tail -n 1 | cut -d , -f $3

#How can one shell script do many things?
#Our shells scripts so far have had a single command or pipe, but a script can contain many lines of commands. 
#For example, you can create one that tells you how many records are in the shortest and longest of your data files,
#i.e., the range of your datasets' lengths.

#Note that in Nano, "copy and paste" is achieved by navigating to the line you want to copy, 
#pressing CTRL + K to cut the line, then CTRL + U twice to paste two copies of it.

#As a reminder, to save what you have written in Nano, type Ctrl + O to write the file out, 
#then Enter to confirm the filename, then Ctrl + X to exit the editor.

#Use Nano to edit the script range.sh and replace the two ____ placeholders with $@ and -v so that 
#it lists the names and number of lines in all of the files given on the command line 
#without showing the total number of lines in all files. (Do not try to subtract the column header lines from the files.)
nano range.sh
wc -l $@ | grep -v total

#Use Nano again to add sort -n and head -n 1 in that order to the pipeline in range.sh 
#to display the name and line count of the shortest file given to it.
wc -l $@ | grep -v total | sort -n | head -n 1

#Again using Nano, add a second line to range.sh to print the name and record count of the longest file in the directory 
#as well as the shortest. This line should be a duplicate of the one you have already written, 
#but with sort -n -r rather than sort -n.
wc -l $@ | grep -v total | sort -n -r | head -n 1

#Run the script on the files in the seasonal directory using seasonal/*.csv
#to match all of the files and redirect the output using > to a file called range.out in your home directory.
bash range.sh seasonal/*.csv > range.out

#How can I write loops in a shell script?
#Shell scripts can also contain loops. You can write them using semi-colons, 
#or split them across lines without semi-colons to make them more readable:

# Print the first and last data records of each file.
#for filename in $@
#do
#    head -n 2 $filename | tail -n 1
#    tail -n 1 $filename
#done
#(You don't have to indent the commands inside the loop, but doing so makes things clearer.)

#The first line of this script is a comment to tell readers what the script does. 
#Comments start with the # character and run to the end of the line. Your future self will 
#thank you for adding brief explanations like the one shown here to every script you write.

#As a reminder, to save what you have written in Nano, type Ctrl + O to write the file out, 
#then Enter to confirm the filename, then Ctrl + X to exit the editor.

#Fill in the placeholders in the script date-range.sh with $filename (twice), 
#head, and tail so that it prints the first and last date from one or more files.
for filename in $@
do
  cut -d , -f 1 $filename | grep -v Date | sort | head -n 1
  cut -d , -f 1 $filename | grep -v Date | sort | tail -n 1
done

#Run date-range.sh on all four of the seasonal data files using seasonal/*.csv to match their names.
bash date-range.sh seasonal/*.csv

#Run date-range.sh on all four of the seasonal data files using seasonal/*.csv to match their names, 
#and pipe its output to sort to see that your scripts can be used just like Unix's built-in commands.
bash date-range.sh seasonal/. | sort

#What happens when I don't provide filenames?
#A common mistake in shell scripts (and interactive commands) is to put filenames in the wrong place. If you type:

#tail -n 3
#then since tail hasn't been given any filenames, it waits to read input from your keyboard. This means that if you type:

#head -n 5 | tail -n 3 somefile.txt
#then tail goes ahead and prints the last three lines of somefile.txt, 
#but head waits forever for keyboard input, since it wasn't given a filename and there isn't 
#anything ahead of it in the pipeline.

#Suppose you do accidentally type:

#head -n 5 | tail -n 3 somefile.txt
#What should you do next?
#Use Ctrl + C to stop the running head program.

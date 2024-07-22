#Script_Name : script.py
#Description : Data Manipulation with Pandas
#Author : Sofiane Boumelit
#Date : June 30, 2024

#The big ideas
'''
Which 3 software engineering concepts included in this course can help Data Scientists save time, 
collaborate, and write better code?
'''

#Possible Answers
'''
-Big Data,Machine Learning & Algorithms ()
-Modualarity,Documentation,& Automated Testing (X)
-R,Python,& SQL ()
-Google,StackOverflow,& Luck()
'''

#Python modularity in the wild
'''
In the slides, we covered 3 ways that you can write modular code with Python: 
packages, classes, and methods. For reference, you can see the example code we reviewed below.

# Import the pandas PACKAGE
import pandas as pd

# Create some example data
data = {'x': [1, 2, 3, 4], 
        'y': [20.1, 62.5, 34.8, 42.7]}

# Create a dataframe CLASS object
df = pd.DataFrame(data)

# Use the plot METHOD
df.plot('x', 'y')
In this exercise, you'll utilize a class & a method from the popular package numpy.
'''

# import the numpy package
import numpy as np
# create an array class object
arr = np.array([8, 6, 7, 5, 3, 0, 9])
# use the sort method
arr.sort()
# print the sorted array
print(arr)

#Installing package with pip
'''
Which of the below commands could you run in your shell to install the package numpy with pip?
'''

#Possible Answers
'''
-pip install numpy(X)
-pip INSTALL numpy
-install numpy pip
-pip --upgarde numpy
'''

#Levraging documetation
'''
When writing code for Data Science, it's inevitable that you'll need to install and use someone else's code. 
You'll quickly learn that using someone else's code is much more pleasant when they use good 
software engineering practices. In particular, good documentation makes the right way to call a function obvious. 
In this exercise you'll use python's help() method to view a function's documentation 
so you can determine how to correctly call a new method.

The list words has been loaded in your session.
'''

# load the Counter function into our environment
from collections import Counter
# View the documentation for Counter.most_common
help(Counter.most_common)
# use Counter to find the top 5 most common words
top_5_words = Counter(words).most_common(5)
# display the top 5 most common words
print(top_5_words)

#Using pycodestyle
'''
We saw earlier that pycodestyle can be run from the command line to check a file for PEP 8 compliance. 
Sometimes it's useful to run this kind of check from a Python script.
In this exercise, you'll use pycodestyle's StyleGuide class to check multiple files for PEP 8 compliance. 
Both files accomplish the same task, but they differ greatly in formatting and readability. 
You can view the contents of the files by following their links below.
'''

# Import needed package
import pycodestyle
# Create a StyleGuide instance
style_checker = pycodestyle.StyleGuide()
# Run PEP 8 check on multiple files
result = style_checker.check_files(["nay_pep8.py", "yay_pep8.py"])
# Print result of PEP 8 style check
print(result.messages)

#Conforming to PEP8
'''
As we've covered, there are tools available to check if your code conforms to the PEP 8 guidelines. 
One possible way to stay compliant is to use an IDE that warns you when you accidentally stray from the style guide. 
Another way to check code is to use the pycodestyle package.
The results below show the output of running pycodestyle check against the code shown in your editor. 
The leading number in each line shows how many occurrences there were of that particular violation.

my_script.py:2:2:  E225 missing whitespace around operator
my_script.py:2:7:  E231 missing whitespace after ','
my_script.py:2:9:  E231 missing whitespace after ','
my_script.py:5:7:  E201 whitespace after '('
my_script.py:5:11: E202 whitespace before ')'
'''

# Assign data to x
x=[8, 3, 4]
# Print the data
print(x)

#PEP8 in documentation
'''
So far we've focused on how PEP 8 affects functional pieces of code. 
There are also rules to help make comments and documentation more readable. 
In this exercise, you'll be fixing various types of comments to be PEP 8 compliant.

The result of a pycodestyle style check on the code can be seen below.

my_script.py:2:15: E261 at least two spaces before inline comment
my_script.py:5:16: E262 inline comment should start with '# '
my_script.py:11:1: E265 block comment should start with '# '
my_script.py:13:2: E114 indentation is not a multiple of four (comment)
my_script.py:13:2: E116 unexpected indentation (comment)
'''

def print_phrase(phrase, polite=True, shout=False):
    if polite:  # It's generally polite to say please
        phrase = 'Please ' + phrase

    if shout:  # All caps looks like a written shout
        phrase = phrase.upper() + '!!'

    print(phrase)
# Politely ask for help
print_phrase('help me', polite=True)
# Shout about a discovery
print_phrase('eureka', shout=True)

#Minimal package requirements
'''
What are the minimal requirements to make an import-able python package?
'''

#Possible Answers
'''
-A directory __init__.(X)
-A monthly stipend from a reseach grant.()
-A directory with modular,documented,tested code.()
-A directory with a blank file named __init__.py()
'''

#Naming packages
'''
We covered the PEP 8 guidelines for naming packages. In this exercise, 
you'll use that knowledge to identify a package following the requirements.
For additional reference, you can view the PEP 8 section on package naming here
'''

# Import the package with a name that follows PEP 8
import text_analyzer

#Recognizing packages
'''
The structure of your directory tree is printed below. 
You'll be working in the file my_script.py that you can see in the tree.

recognizing_packages
├── MY_PACKAGE
│   └── __init__.py
├── package
│   └── __init__.py
├── package_py
│   └── __init__
│       └── __init__.py
├── py_package
│   └── __init__.py
├── pyackage
│   └── init.py
└── my_script.py
'''
# Import local packages
import package
import py_package

# View the help for each package
help(package)
help(py_package)

#Adding functionality to your package
'''
Thanks to your work before, you already have a skeleton for your python package. 
In this exercise, you will work to define the functions needed for a text analysis of word usage.

In the file counter_utils.py, you will write 2 functions to be a part of your package: plot_counter and sum_counters.
The structure of your package can be seen in the tree below.
For the coding portions of this exercise, you will be working in the file counter_utils.py.

text_analyzer
├── __init__.py
└── counter_utils.py
'''

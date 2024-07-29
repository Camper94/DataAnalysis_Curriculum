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
# Import needed functionality
from collections import Counter
def plot_counter(counter, n_most_common=5):
  # Subset the n_most_common items from the input counter
  top_items = counter.most_common(n_most_common)
  # Plot `top_items`
  plot_counter_most_common(top_items)
# Import needed functionality
from collections import Counter
def sum_counters(counters):
  # Sum the inputted counters
  return sum(counters, Counter())

'''
Question
You just wrote two functions for your package in the file counter_utils.py named plot_counter & sum_counters. 
Which of the following lines would correctly import these functions in __init__.py using relative import syntax?

Possible answers

from counter_utils import plot_counter, sum_counters()
from .counter_utils import plot_counter, sum_counters(X)
from . import plot_counter, sum_counters()
from .counter_utils import plot_counter & sum_counters()
'''

#Using your package's new functionality
'''
You've now created some great functionality for text analysis to your package. 
In this exercise, you'll leverage your package to analyze some tweets written by DataCamp & DataCamp users.

The object word_counts is loaded into your environment. 
It contains a list of Counter objects that contain word counts from a sample of DataCamp tweets.

The structure you've created can be seen in the tree below. You'll be working in my_script.py.

working_dir
├── text_analyzer
│    ├── __init__.py
│    ├── counter_utils.py
└── my_script.py
'''

# Import local package
import text_analyzer as ta
# Sum word_counts using sum_counters from text_analyzer
word_count_totals = ta.sum_counters(word_counts)
# Plot word_count_totals using plot_counter from text_analyzer
ta.plot_counter(word_count_totals)

#Writing requirements.txt
'''
We covered how having a requirements.txt file can help your package be more portable by allowing your users to easily 
recreate its intended environment. In this exercise, you will be writing the contents of a 
requirements file to a python variable.
Note, in practice, the code you write in this exercise would 
be written to it's own txt file instead of a variable in your python session.
'''

requirements = """
matplotlib>=3.0.0
numpy==1.15.4
pandas<=0.22.0
pycodestyle
"""

#Installing package requirements
'''
You've now written a requirements.txt file to recreate your package's environment using a pip install command. 
Given that you are running a shell session in the work_dir structure shown below, 
what command would properly recreate the my_package environment from requirements.txt?

work_dir/
├── my_package
│&nbsp;&nbsp; ├── __init__.py
│&nbsp;&nbsp; └── utils.py
├── requirements.txt
└── setup.py

Possible Answers
Select one answer

-pip install requirements.txt()
-pip install -r requirements()
-pip install -r setup.py()
-pip install -r requirements.txt(X)
'''

#Creating setup.py
'''
In order to make your package installable by pip you need to create a setup.py file. 
In this exercise you will create this file for the text_analyzer package you've been building.
'''

# Import needed function from setuptools
from setuptools import setup
# Create proper setup to be used by pip
setup(name='text_analyzer',
      version='0.0.1',
      description='Perform and visualize a text anaylsis.',
      author='Sofiane Boumelit',
      packages=['text_analyzer'])

#Listing requirements in setup.py
'''
We created a setup.py file earlier, 
but we forgot to list our dependency on matplotlib in the install_requires argument. 
In this exercise you will practice listing your version specific dependencies by correcting the setup.py 
you previously wrote for your text_analyzer package.
'''

# Create proper setup to be used by pip
setup(name='text_analyzer',
      version='0.0.1',
      description='Perform and visualize a text anaylsis.',
      author='Sofiane Boumelit',
      packages=['text_analyzer'],
      install_requires=['matplotlib>=3.0.0'])

#Writing a class for your package
'''
We've covered how classes can be written in Python. 
In this exercise, you'll be creating the beginnings of a Document class that will be a 
foundation for text analysis in your package. 
Once the class is written you will modify your package's __init__.py file to make it easily accessible by your users.

Below is the structure of where you'll be working.

working_dir
├── text_analyzer
│    ├── __init__.py
│    ├── counter_utils.py
│    ├── document.py
└── my_script.py
'''
# Define Document class
class Document:
    """A class for text analysis    
    :param text: string of text to be analyzed
    :ivar text: string of text to be analyzed; set by `text` parameter
    """
    # Method to create a new instance of MyClass
    def __init__(self, text):
        # Store text parameter to the text attribute
        self.text = text

#Using your package's class
'''
You just wrote the beginnings of a Document class that you'll build upon to perform text analysis. 
In this exercise, you'll test out its current functionality of storing text.
Below is the document tree that you've built up so far when developing your package. 
You'll be working in my_script.py.

working_dir
├── text_analyzer
│    ├── __init__.py
│    ├── counter_utils.py
│    ├── document.py
└── my_script.py
'''

# Import custom text_analyzer package
import text_analyzer
# Create an instance of Document with datacamp_tweet
my_document = text_analyzer.Document(text=datacamp_tweet)
# Print the text attribute of the Document instance
print(my_document.text)

#Writing a non-public method
'''
In the lesson, we covered how to add functionality to classes using non-public methods. 
By defining methods as non-public you're signifying to the user that the method is only to be used inside the package.
In this exercise, you will define a non-public method that will be leveraged by your class to count words.
'''
class Document:
  def __init__(self, text):
    self.text = text
    # pre tokenize the document with non-public tokenize method
    self.tokens = self._tokenize()
    # pre tokenize the document with non-public count_words
    self.word_counts = self._count_words()
  def _tokenize(self):
    return tokenize(self.text)
  # non-public method to tally document's word counts with Counter
  def _count_words(self):
    return Counter(self.tokens)


#Using your class's functionality
'''
You've now added additional functionality to your Document class's __init__ method that automatically 
processes text for your users. 
In this exercise, you'll act as one of those users to see the benefits of your hard work.
The Document class (copied below) has been loaded into your environment (complete with your new updates).

class Document:
  def __init__(self, text):
    self.text = text
    # pre tokenize the document with non-public tokenize method
    self.tokens = self._tokenize()
    # pre tokenize the document with non-public count_words
    self.word_counts = self._count_words()

  def _tokenize(self):
    return tokenize(self.text)

  # non-public method to tally document's word counts with Counter
  def _count_words(self):
    return Counter(self.tokens)
'''

# create a new document instance from datacamp_tweets
datacamp_doc = Document(text=datacamp_tweets)
# print the first 5 tokens from datacamp_doc
print(datacamp_doc.tokens[:5])
# print the top 5 most used words in datacamp_doc
print(datacamp_doc.word_counts.most_common(5))

#Using inheritance to create a class
'''
You've previously written a Document class for text analysis, but your NLP project will now have a 
focus on Social Media data. Your general Document class might be useful later so 
it's best not destroy it while your focus shifts to tweets.
Instead of copy-pasting the already written functionality, 
you will use the principles of 'DRY' and inheritance to quickly create your new SocialMedia class.
'''
# Define a SocialMedia class that is a child of the `Document class`
class SocialMedia(Document):
    def __init__(self, text):
        Document.__init__(self, text)

#Adding functionality to a child class
'''
You've just written a SocialMedia class that inherits functionality from Document. 
As of now, the SocialMedia class doesn't have any functionality different from Document. 
In this exercise, you will build features into SocialMedia to specialize it for use with Social Media data.
For reference, the definition of Document can be seen below.

class Document:
    # Initialize a new Document instance
    def __init__(self, text):
        self.text = text
        # Pre tokenize the document with non-public tokenize method
        self.tokens = self._tokenize()
        # Pre tokenize the document with non-public count_words
        self.word_counts = self._count_words()

    def _tokenize(self):
        return tokenize(self.text)

    # Non-public method to tally document's word counts
    def _count_words(self):
        # Use collections.Counter to count the document's tokens
        return Counter(self.tokens)
'''
# Define a SocialMedia class that is a child of the `Document class`
class SocialMedia(Document):
    def __init__(self, text):
        Document.__init__(self,text)
        self.hashtag_counts = self._count_hashtags()
        self.mention_counts = self._count_mentions()
    def _count_hashtags(self):
        # Filter attribute so only words starting with '#' remain
        return filter_word_counts(self.word_counts, first_char='#')          
    def _count_mentions(self):
        # Filter attribute so only words starting with '@' remain
        return filter_word_counts(self.word_counts, first_char='@')

#Using your child class
'''
Thanks to the power of inheritance you were able to create a feature-rich, 
SocialMedia class based on its parent, Document. Let's see some of these features in action.

Below is the full definition of SocialMedia for reference. 
Additionally, SocialMedia has been added to __init__.py for ease of use.

class SocialMedia(Document):
    def __init__(self, text):
        Document.__init__(self, text)
        self.hashtag_counts = self._count_hashtags()
        self.mention_counts = self._count_mentions()

    def _count_hashtags(self):
        # Filter attribute so only words starting with '#' remain
        return filter_word_counts(self.word_counts, first_char='#')      

    def _count_mentions(self):
        # Filter attribute so only words starting with '@' remain
        return filter_word_counts(self.word_counts, first_char='@')
'''

# Import custom text_analyzer package
import text_analyzer
# Create a SocialMedia instance with datacamp_tweets
dc_tweets = text_analyzer.SocialMedia(text=datacamp_tweets)
# Print the top five most most mentioned users
print(dc_tweets._count_mentions().most_common(5))
# Plot the most used hashtags
text_analyzer.plot_counter(dc_tweets._count_hashtags())

#Exploring with dir and  help
'''
A new method has been added to the Document class. 
The method is a convenience wrapper around the plot_counter() function you wrote in an earlier exercise. 
In this exercise, you'll use dir() and help() to identify how to utilize the new method.
'''

# Import needed package
import text_analyzer
# Create instance of document
my_doc = text_analyzer.Document(datacamp_tweets)
# Run help on my_doc's plot method
help(my_doc.plot_counts)
# Plot the word_counts of my_doc
my_doc.plot_counts(attribute='word_counts',n_most_common = 5)

#Creating a grandchild class
'''
In this exercise you will be using inheritance to create a Tweet class from your SocialMedia class. 
This new grandchild class of Document will be able to tackle Twitter specific details such as retweets.
'''


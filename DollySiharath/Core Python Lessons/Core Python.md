* Python Setup
    * Modules and pip
In Python, Modules are simply files with the “. py” extension containing Python code that can be imported inside another Python Program.  Pip – Pip is a package manager for Python. It allows you to install packages/modules.   By default, PIP is already installed in Python 3x. 


* Comments
"""
This is a multi-line comment with docstrings.

Regular Python comments using a hash (#)
For example:
#This is a comment
print("Hello, World!")

"""




* Variables and Data Types
  Variables are containers for storing data values.

* strings = Text type str
* numbers = Numeric Types:	int, float, complex    
* Input from users = The input() function allows user input.



* Basic Data Structures
    * Lists = Lists are used to store multiple items in a single variable.


    * Tuples = Tuples are used to store multiple items in a single variable. A tuple is a collection which is ordered and unchangeable. Tuples are written with round brackets.

    * Sets = Sets are used to store multiple items in a single variable. A set is a collection which is unordered, unchangeable*, and unindexed.

" SETs cannot have value of duplicate. It must be unique."
" It uses {}"
" The order can changed with each execution"
"print(Courses_01.difference(Courses_02)) - Science and English not listed in Courses_02"
"print(Courses_01.difference(Courses_02)) - Math and Physics are listed in Courses_01 and Courses_02"
"print(Courses_01.union(Courses_02))- will print both sets but not duplicate value "
Courses_01 = {"Math", "Science", "English", "Physics"}
Courses_02 = {"Math", "Data Science", "Spanish", "Physics"}
print(Courses_01.difference(Courses_02))
print(Courses_01.intersection(Courses_02))
print(Courses_01.union(Courses_02))


* Dictionaries = DICTIONARIES is a collection of objects, values or items of different types stored in key-value pair format.  These multiple key-value pairs created are enclosed within the curly braces{}, and each
key is separated form its value by the colon : 


Functions and Other structure
 * Pointers =  passing by value and by reference.
 * Comprehensions =  a short and concise way to construct new sequences (such as lists, set, dictionary etc.) 


Control Flow
* For Loop = A for loop is used for iterating over a sequence (that is either a list, a tuple, a dictionary, a set, or a string).


* While Loop = With the while loop we can execute a set of statements as long as a condition is true.




* Exception Handling 
An exception in Python is an incident that happens while executing a program that causes the regular course of the program's commands to be disrupted.

the complete list of Python in-built exceptions.
Sr.No.	Name of the Exception	Description of the Exception
1	Exception	All exceptions of Python have a base class.
2	StopIteration	If the next() method returns null for an iterator, this exception is raised.
3	SystemExit =	The sys.exit() procedure raises this value.
4	StandardError =	Excluding the StopIteration and SystemExit, this is the base class for all Python built-in exceptions.
5	ArithmeticError	= All mathematical computation errors belong to this base class.
6	OverflowError = 	This exception is raised when a computation surpasses the numeric data type's maximum limit.
7	FloatingPointError = If a floating-point operation fails, this exception is raised.
8	ZeroDivisionError = For all numeric data types, its value is raised whenever a number is attempted to be divided by zero.
9	AssertionError = If the Assert statement fails, this exception is raised.
10	AttributeError = 	This exception is raised if a variable reference or assigning a value fails.
11	EOFError =	When the endpoint of the file is approached, and the interpreter didn't get any input value by raw_input() or input() functions, this exception is raised.
12	ImportError = 	This exception is raised if using the import keyword to import a module fails.
13	KeyboardInterrupt = If the user interrupts the execution of a program, generally by hitting Ctrl+C, this exception is raised.
14	LookupError =	LookupErrorBase is the base class for all search errors.
15	IndexError = This exception is raised when the index attempted to be accessed is not found.
16	KeyError = 	When the given key is not found in the dictionary to be found in, this exception is raised.
17	NameError = 	This exception is raised when a variable isn't located in either local or global namespace.
18	UnboundLocalError =	This exception is raised when we try to access a local variable inside a function, and the variable has not been assigned any value.
19	EnvironmentError =	All exceptions that arise beyond the Python environment have this base class.


 * File I/O
Python io module allows us to manage the file-related input and output operations. There are three main types of I/O: text I/O, binary I/O and raw I/O.

How do you use input and output files in Python?
Input-Output and Files in Python (Python Open, Read and Write to File)
#1) Open a File.
#2) Reading Data from the File.
#3) Writing Data to File.
#4) Close a File.
#5) Create & Delete a File.


character	purpose
r	Opens a file for reading only. (default)
w	Opens a file for writing only, 
    deleting earlier contents
a	Opens a file for appending.
t	opens file in text format (default)
b	Opens a file in binary format.
+	Opens a file for simultaneous reading and writing.
x	opens file for exclusive creation.

Syntax:

file = open(name, mode) 

file object = open(<file-name>, <access-mode>, <buffering>)     

example:
 # open it in ‘w’ mode.

 import os
f=open("python.txt","w")
f.write("Hello")
f.write("World")
f.close()

 import os
f=open("python.txt","w")
f.writelines(lines)
f.close()

import os
f=open("c:/diff/python/test.txt","w")
f.writelines(lines)
f.close()


# create a new file to write.
import os
f=open("c:/diff/python/test02.txt","x")
f.write("Hello World")
f.close()


# Del a file.
import os
f=remove("c:/diff/python/test02.txt")


#  check if file exist for del. file.
import os
if os.path.exists("c:/diff/python/test02.txt"):
    os.remove("test02.txt")
else:
     print("file not found")    


 # open it in ‘r’ mode.
 # the print(f.read()) - telling python to read the entire file.
 import os
f=open("c:/diff/python/test.txt","r")
print(f.read())
f.close()


# read the fist 10 char. of the first line in the file.
 import os
f=open("c:/diff/python/test.txt","r")
print(f.read(10))
f.close()


# read line by line / one line at a time in the file.
 import os
f=open("c:/diff/python/test.txt","r")
print(f.readline())
f.close()

# read the first 3 char.in a line. 
 import os
f=open("c:/diff/python/test.txt","r")
print(f.readline(3))
f.close()
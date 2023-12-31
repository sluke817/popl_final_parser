# popl_final_parser

### Group Members: 
Luke Schaefer, Landon Vowels, Nick Kanatzar, Cameron Day, Teddy Kucaba, Josh Robinson

### Language:
Python

### Project Description:
This is a parser for the Python language. The driver program included (file_driver.py) 
checks input Python files with the parser to see if the code in the input file is of valid Python syntax.
Supported features include parsing of arithmetic and assignment operators, if/elif/else, while, and for structures,
conditional statements, nested structures, and comments.

### Requirements:
This parser requires installation of ANTLR v4. Follow the instructions to install ANTLR here:
https://github.com/antlr/antlr4/blob/master/doc/getting-started.md

As mentioned in these instructions, Python 3 is also necessary for ANTLR and for this parser.

### How to Use:
After installing ANTLR, run the following command to build the parser from the grammar file:
```
antlr4 PyParser.g4 -Dlanguage=Python3
```
To run the parser on a Python file, execute
```
python3 file_driver.py [input_filename].py
```
For example,
```
python3 file_driver.py project_deliverable_3_testcase.py
```
This will output a text version of the parse tree followed by either “passed!” if the input was valid Python syntax, or “failed” if the input was invalid. Remember that this parser only covers the aforementioned features—it does not support every possible Python statement.

To see the parse trees, please execute: 
```
antlr4-parse PyParser.g4 prog <filename> -gui 
```
For example,
```
antlr4-parse PyParser.g4 prog project_deliverable_3_testcase.py -gui
```

### Demo Video:
https://drive.google.com/file/d/1p7XBrEI4LIl2jimomeJwkqnD_apwXy2h/view?usp=drive_link

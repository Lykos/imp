IMP
===
IMP is a very basic imperative language that we use in our formal methods course at our university. It contains loops, procedure calls, integer variables, conditionals, comparison, boolean formulas and some more basic features, but nothing really advanced, not even Output, Arrays or a non integer data type.

Content of this project
================
This project contains a parser in the lib/parser directory which parses an IMP program and builds up an abstract syntax tree consisting of the classes in `lib/ast`. Then, an Interpreter which is located in lib/interpreter can interpret this AST or a compiler located in `lib/compiler` can compile it to C or Ruby. The directory `bin/` contains the scripts to execute the compilers or interpreters. To ensure a certain reliability, I wrote some tests in `test/`. However, this only covers the parser and the interpreter yet.

Features
======
To be written. What is not supported can be looked up in TODO.markdown

Usage of this project
===============
I do not assume that it will ever be used, but it contains an interpreter that supports most language features, a Ruby compiler that supports some of them and a C Compiler which doesn't even support really big numbers, so compiling to C probably destroys Turing completeness. It also has an IMP compiler which basically just prints out a nicely formatted IMP program, I just implemented that to find bugs in the AST more easily.

Usage of the compilers
----------------------
The scripts to start the compilers are found in the `bin/` directory, the compilers read from the standard input or a file given as a command line argument and output the compiled version into the standard output, or if an output file is given with the -o option, to that file.

Usage of the interpreter
------------------------
If no arguments are given, the interpreter reads an IMP file from the standard input and interprets it. If arguments are given, the first argument is interpreted as a file name and all others as pairs of variables and values. The given variables will be set to the given initial values. After the execution, the interpreter will output the variable names and the values of all variables used in the program.

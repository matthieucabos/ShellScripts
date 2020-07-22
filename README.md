# ShellScripts
Shell Scripts Collection

*Author* CABOS Matthieu

# Description

This repertory contains Utilitary Shell scripts

compile.sh
----------

Script usage

This script has been developped to automate the compilation process.
It treats c, c++ and fortran source files. Compilation can be ruled with two modes :
	* ) The chain mode realize a chain compilation mode : Each source file is 
compiled independantly from each other
	* ) The modular mode realize a modular compilation using one main source file 
and the dependency modules and functions as source files.

This script take 2 types of arguments : the first one determine the mode between 
0 (chain) and 1 (modular)
The others parameters are the source files to compile.
The source file must be .c, .cpp or .f90 files, others extensions files WILL 
NOT BE TREATED.

You have to use the correct syntaxe specifying the mode for each exxecution :

./compile.sh <mode> <source file 1> <source file 2> ... <source file n>
  
 Help is avaible using the --help option

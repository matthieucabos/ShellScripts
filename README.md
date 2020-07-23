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
	* The chain mode realize a chain compilation mode : Each source file is compiled independantly from each other
	* The modular mode realize a modular compilation using one main source file and the dependency modules and functions as source files.
	* The MPI Compilation mode allows to compile c/c++ and fortran file using MPI librairies

This script take 2 types of arguments : the first one determine the mode between 
0 (chain),  1 (modular) and 2 (MPI)
The others parameters are the source files to compile.
The source file must be .c, .cpp or .f90 files, others extensions files WILL 
NOT BE TREATED.

You have to use the correct syntaxe specifying the mode for each exxecution :

./compile.sh <mode> <source file 1> <source file 2> ... <source file n>
  
 Help is avaible using the --help option
 
 transfert_ssh.sh
 ----------------
 
 Script Usage
 
 Please to use the script with the correct number of arguments :
 
**./transfert.sh mode filename user IP**

Where :

* mode is the way to transfert between :
	* 0 mean upload file to the ssh root directory
	* 1 mean download file since the ssh root directory
* filename is the exact file name to transfert
* user is your standard user name on the ssh plateform
* IP is the adress of the ssh server.

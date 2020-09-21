# ShellScripts
Shell Scripts Collection

*Author* CABOS Matthieu

*Date*   26/08/2020

*Organization* INRAE-CNRS

# Description
-------------

This repertory contains Utilitary Shell scripts

# compile.sh
------------

Script usage

This script has been developped to automate the compilation process.
It treat c, c++ and fortran source files. Compilation can be ruled with four modes :

	1 ) The chain mode realize a chain compilation mode : Each source file is 
compiled independantly from each other
	2 ) The modular mode realize a modular compilation using one main source file 
and the dependency modules and functions as source files.
	3 ) The Mpi compilation mode allow parallel compilation using Open Mpi
	4 ) The Openmp compilation mode allow parallel compilation using Open MP
	5 ) The Librairies Linking Mode allow modular compilation using Unix Librairies

This mode must be specified as argument.

The script take 2 types of arguments : the first one determine the mode between 
1 (chain),  2 (modular), 3 (mpi compilation), 4 (openmp compilation) and 5 (Librairies linking mode)
The others parameters are the source files to compile.
The source file must be .c, .cpp or fortran files. 
Others extensions files WILL NOT BE TREATED.

You have to use the correct syntaxe specifying the mode for each execution :

./compile.sh <mode> <source file 1> <source file 2> ... <source file n>

In case of modular compilation, please to keep this parameter structure :

./compile.sh <mode> <Main source file> <Module source file 1> <Module source file 2> ...

Options
-------

-l :

In case of additionnal features like Object, Static or Dynamix Librairies use the -l option with
Librairies as following arguments (MUST be specified as the last parameters) :

./compile.sh <mode> <source file 1> <source file 2> ... <source file n> <-l> <lib_file1.so> <lib_file2.so>... 

-L : 

In case of additionnal features like Librairies using an option like math.h
Librairie's option(s) as following arguments (MUST be specified as the last parameters) :

example

./compile.sh <mode> <source file 1> <source file 2> ... <source file n> <-L> <-lm>

-o : 

If specified you should give the executable the name you want as following argument !

./compile.sh <mode> <src_file> -o <executable name>

-d :

If the source file(s) are not in the current directory, the -d option should specified the directory to 
treat (-d /my_project_to_compile_directory/ as example)

./compile.sh <mode> <src_file> -d <src_file_repertory_relative_way>
	
 Help is avaible using the --help or -h option
 
 # cpu_count.sh
 --------------
 
 Script Usage.
 
 Please to use this script with the correct number of arguments:
 
 **./cpu_count.sh user ip**
 
 This script give us the following information : the number of avaible Cpu on the distant ssh machine.
 
 # get_lib_list.sh
 -----------------
 
 Script Usage.
 
 
Please to use this script with the correct arguments.
This script analyse the results of a failed compilation and determine the name(s) of the missing librairie(s).

exemple:

**./get_lib_list.sh `gcc my_source_file.c`**

# sudo-upgrade-all.sh
---------------------

Script Usage.

Called without arguments like that : **./sudo-upgrade-all.sh**

This script is used to upgrade all the present binaries librairies on a Unix system.
Please to use **if and only if** the Unnix system use the *apt* command (see also sudo apt command in Linux Manual.

 # transfert_ssh.sh
 ------------------
 
 Script Usage
 
 Please to use the script with the correct number of arguments :
 
**./transfert.sh mode user source_folder destination_folder filename/folder_name IP**

Where :

* mode is the way to transfert between :
	* 0 mean upload file to the ssh root directory
	* 1 mean download file since the ssh root directory
	* 2 mean upload folder to the ssh specified destination folder
	* 3 mean download folder since the ssh specified source folder
* user is your standard user name on the ssh plateform
* source folder is the name of the source repertory
* destination folder is the name of the destination repertory
* ip is the adress of the ssh server
* filename is the exact files name to transfert or the folder name to transfert

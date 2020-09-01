# ShellScripts
Shell Scripts Collection

*Author* CABOS Matthieu

*Date*   26/08/2020

*Organization* INRAE-CNRS

# Description

This repertory contains Utilitary Shell scripts

compile.sh
----------

Script usage

This script has been developped to automate the compilation process.

It treats c, c++ and fortran source files. Compilation can be ruled with three modes :
* The chain mode realize a chain compilation mode.
Each source file is compiled independantly from each other.
* The modular mode realize a modular compilation.
It use one main source file and the dependency modules and functions as source files.
* The MPI Compilation mode allows to compile c/c++ and fortran file using MPI librairies.
* The Openmp compilation mode allow parallel compilation using Open MP
* The Librairiies Linking Mode allow modular compilation using Unix Librairies

The script take 2 types of arguments : the first one determine the mode between 
0 (chain),  1 (modular), 2 (mpi compilation), 3 (openmp compilation) and 4 (Librairies linking mode)
The others parameters are the source files to compile.
The source file must be .c, .cpp or fortran files. 
Others extensions files WILL NOT BE TREATED.

You have to use the correct syntaxe specifying the mode for each execution :

**./compile.sh mode source_file_1 source_file_2 ... source_file_n**
 
 In case of modular compilation, please to keep this parameter structure :

**./compile.sh mode Main_source_file Module_source_file_1 Module_source_file_2 ... Module_source_file_n**
	
 Help is avaible using the --help or -h option
 
 transfert_ssh.sh
 ----------------
 
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

#!/bin/bash

# Author : CABOS Matthieu
# Date : 17/07/2020

if [ $# -eq 0 ]                                  # Describing the Script manipulation (Number and Type of arguments)
then
echo "#####################################################################################"
echo ""
echo "Wrong parameters number. Usage : ./compile.sh <mode> <file.c/cpp> <file.c/cpp> ..."
echo "Use --help option to get help"
echo ""
echo "#####################################################################################"
echo ""
echo "Where mode define the script profile : "
echo ""
echo "#####################################################################################"
echo ""
echo "mode = 0 => A Chain Compilation Profile using INDEPENDANTS C/C++ files."
echo "Using the syntaxe ./compile.sh 0 <file1.c/cpp> <file2.c/cpp> ..."
echo ""
echo "#####################################################################################"
echo ""
echo "mode = 1 => A Modulare Compilation Profile." 
echo "Using the syntaxe ./compile.sh 1 <main.c/cpp> <modular_part1.c/cpp> <modular_part2.c/cpp> ..." 
echo ""
exit
fi

function help(){
	printf "
#################################################################################

Script usage

This script has been developped to automate the compilation process.
It treat c, c++ and fortran source files. Compilation can be ruled with two modes :
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

#################################################################################
	"
}

if [ "$1" = "--help" ]
	then
		help
		exit
fi

mode=$1

parameters=""
name=" "

if [ $mode -eq 0 ]                                # Executing script profile in Chain Compilation mode
	then
		for i in $@
			do
				if [ "$i" != "0" ]                # Rebuilding the file name parameters list
					then 
						parameters=$parameters" "$i
						
				fi
			done
			for i in $parameters                  # Executing the compilation for each file as parameter
				do
					e=${i#*.}                     # Getting the file extension
					if [ $e = "c" ]
						then
						name=`basename $i '.c'`   # Getting the .exe filename
						gcc $i -o $name -fopenmp  # Compiling the code file as parameter
					elif [ "$e" = "cpp" ]
						then
						name=`basename $i '.cpp'` # Getting the .exe filename
						g++ $i -o $name -fopenmp  # Compiling the code file as parameter
					elif [ "$e" = "f90" ]
						then
						name=`basename $i '.f90'` # Getting the .exe filename
						gfortran -o $name $i -fopenmp
					fi
				done
elif [ $mode -eq 1 ]                              # Executing script profile in Modular Compilation mode
	then
		for i in $@
			do
				if [ "$i" != "1" ]                # Rebuilding the file name parameters list
					then
						parameters=$parameters" "$i
				fi
			done
			for i in $parameters
				do
					e=${i#*.}                     # Getting the file extension
					if [ $e = "c" ]
						then
						name=`basename $i '.c'`   # Getting the .exe filename
					elif [ "$e" = "cpp" ]
						then
						name=`basename $i '.cpp'` # Getting the .exe filename
					fi
				done

				if [ $e = "c" ]
					then
						gcc $parameters -o $name -fopenmp  # Compiling the Modular file as parameters
				elif [ $e = "cpp" ]
					then
						g++ $parameters -o $name -fopenmp  # Compiling the Modular file as parameters
				elif [ $e = "f90" ]
					then
						for i in $parameters
							do
								name=`basename $i '.f90'`
								gfortran -o $name $i -fopenmp
							done
				fi
fi
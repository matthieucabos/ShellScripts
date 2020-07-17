#!/bin/bash

# Author : CABOS Matthieu
# Date : 17/07/2020

if [ $# -eq 0 ]                                  # Describing the Script manipulation (Number and Type of arguments)
then
echo "#####################################################################################"
echo ""
echo "Wrong parameters number. Usage : ./compile.sh <mode> <file.c/cpp> <file.c/cpp> ..."
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


mode=$1

parameters=""

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
						gcc $i -o $name           # Compiling the code file as parameter
					elif [ "$e" = "cpp" ]
						then
						name=`basename $i '.cpp'` # Getting the .exe filename
						g++ $i -o $name           # Compiling the code file as parameter
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
						gcc $parameters -o $name  # Compiling the Modular file as parameters
				elif [ $e = "cpp" ]
					then
						g++ $parameters -o $name  # Compiling the Modular file as parameters
				fi
fi


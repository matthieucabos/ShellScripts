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
echo "Using the syntaxe ./compile.sh 0 <file1.c/cpp/f90> <file2.c/cpp/f90> ..."
echo ""
echo "#####################################################################################"
echo ""
echo "mode = 1 => A Modulare Compilation Profile." 
echo "Using the syntaxe ./compile.sh 1 <main.c/cpp/f90> <modular_part1.c/cpp/f90>"
echo " <modular_part2.c/cpp/f90> ..." 
echo ""
echo "#####################################################################################"
echo ""
echo "mode = 2 => A MPI Compilation Profile." 
echo "Using the syntaxe ./compile.sh 2 <file1.c/cpp/f90> <file2.c/cpp/f90> ..." 
echo ""
echo "#####################################################################################"
echo ""
echo "mode = 3 => An openmp Compilation Profile." 
echo "Using the syntaxe ./compile.sh 3 <file1.c/cpp/f90> <file2.c/cpp/f90> ..." 
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
	* ) The Mpi compilation mode allow parallel compilation using Open Mpi
	* ) The Openmp compilation mode allow parallel compilation using Open MP


This script take 2 types of arguments : the first one determine the mode between 
0 (chain),  1 (modular), 2 (mpi compilation), 3 (openmp compilation)
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
						gcc $i -o $name           # Compiling the code file as parameter
					elif [ "$e" = "cpp" ]
						then
						name=`basename $i '.cpp'` # Getting the .exe filename
						g++ $i -o $name           # Compiling the code file as parameter
					elif [ "$e" = "f90" -o "$e" = "f77" -o "$e" = "f95" -o "$e" = "FOR" ]
						then
							e=".""$e"
							name=`basename $i $e` # Getting the .exe filename
							if [ "$e" = ".f77" -o "$e" = ".FOR"  ]
								then	
									if [ "$e" = ".f77" ]
										then		
											e=`basename $i '.f77'`	
									elif [ "$e" = ".FOR" ]
										then 
											e=`basename $i '.FOR'`	
									fi
									e="$e"".f"		
									mv $i $e									
									gfortran $e -o $name
							else
									gfortran -o $name $i
							fi
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
					break
				elif [ "$e" = "cpp" ]
					then
					name=`basename $i '.cpp'` # Getting the .exe filename
					break
				fi
			done
		if [ $e = "c" ]
			then
				gcc $parameters -o $name   # Compiling the Modular file as parameters
		elif [ $e = "cpp" ]
			then
				g++ $parameters -o $name   # Compiling the Modular file as parameters
		elif [ "$e" = "f90" -o "$e" = "f77" -o "$e" = "f95" -o "$e" = "FOR" ]
			then
				for i in $parameters
					do
					e=${i#*.}
					e=".""$e"
					name=`basename $i $e`
					if [ "$e" = ".f77" -o "$e" = ".FOR"  ]
						then	
							if [ "$e" = ".f77" ]
								then		
									e=`basename $i '.f77'`	
							elif [ "$e" = ".FOR" ]
								then 
									e=`basename $i '.FOR'`	
							fi
							e="$e"".f"		
							mv $i $e									
							gfortran $e -o $name
					else
							gfortran -o $name $i
					fi
				done
		fi
elif [ $mode -eq 2 ]
	then
		for i in $@
			do
				if [ "$i" != "2" ]
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
						mpicc -o $name $i         # Compiling the code file as parameter
					elif [ "$e" = "cpp" ]
						then
						name=`basename $i '.cpp'` # Getting the .exe filename
						mpicxx -o $name $i        # Compiling the code file as parameter
					elif [ "$e" = "f90" -o "$e" = "f77" -o "$e" = "f95" -o "$e" = "FOR" ]
						then
						e=".""$e"
						name=`basename $i $e` # Getting the .exe filename
						if [ "$e" = ".f77" -o "$e" = ".FOR"  ]
							then	
								if [ "$e" = ".f77" ]
									then		
										e=`basename $i '.f77'`	
								elif [ "$e" = ".FOR" ]
									then 
										e=`basename $i '.FOR'`	
								fi
								e="$e"".f"	
								mv $i $e
								mpifort -o $name $e
						else
								mpifort -o $name $i
						fi
					fi
				done
elif [ $mode -eq 3 ]
	then
		for i in $@
			do
				if [ "$i" != "3" ]                # Rebuilding the file name parameters list
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
						break
					elif [ "$e" = "cpp" ]
						then
						name=`basename $i '.cpp'` # Getting the .exe filename
						break
					fi
				done

				if [ $e = "c" ]
					then
						gcc $parameters -o $name -fopenmp  # Compiling the Modular file as parameters
				elif [ $e = "cpp" ]
					then
						g++ $parameters -o $name -fopenmp  # Compiling the Modular file as parameters
				elif [ $e = "f90" -o $e = "f77" -o $e = "f95" -o "$e" = "FOR" ]
					then
						for i in $parameters
							do
								e=${i#*.}
								e=".""$e"
								name=`basename $i $e`
								if [ "$e" = ".f77" -o "$e" = ".FOR"  ]
									then	
										if [ "$e" = ".f77" ]
											then		
												e=`basename $i '.f77'`	
										elif [ "$e" = ".FOR" ]
											then 
												e=`basename $i '.FOR'`	
										fi
										e="$e"".f"		
										mv $i $e			
										gfortran $e -o $name -fopenmp
								else
										gfortran -o $name $i -fopenmp
								fi
							done
				fi
fi
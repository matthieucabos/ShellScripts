#!/bin/bash

# Author : CABOS Matthieu
# Date : 27/08/2020

if [ $# -eq 0 ]                                                                                                                               # Describing the Script manipulation (Number and Type of arguments)
then
echo "#############################################################################################"
echo ""
echo "Wrong parameters number. Usage : ./compile.sh <mode> <file.c/cpp> <file.c/cpp> ..."
echo "Use --help option to get help"
echo ""
echo "#############################################################################################"
echo ""
echo "Where mode define the script profile : "
echo ""
echo "#############################################################################################"
echo ""
echo "mode = 0 => A Chain Compilation Profile using INDEPENDANTS C/C++ files."
echo "Using the syntaxe ./compile.sh 0 <file1.c/cpp/f90> <file2.c/cpp/f90> ..."
echo ""
echo "#############################################################################################"
echo ""
echo "mode = 1 => A Modulare Compilation Profile." 
echo "Using the syntaxe ./compile.sh 1 <main.c/cpp/f90> <modular_part1.c/cpp/f90>"
echo " <modular_part2.c/cpp/f90> ..." 
echo ""
echo "#############################################################################################"
echo ""
echo "mode = 2 => A MPI Compilation Profile." 
echo "Using the syntaxe ./compile.sh 2 <file1.c/cpp/f90> <file2.c/cpp/f90> ..." 
echo "The MPI profile allow modular compilation preserving the syntax described above"
echo ""
echo "#############################################################################################"
echo ""
echo "mode = 3 => An openmp Compilation Profile." 
echo "Using the syntaxe ./compile.sh 3 <file1.c/cpp/f90> <file2.c/cpp/f90> ..." 
echo "The Openmp profile allow modular compilation preserving the syntax described above"
echo ""
echo "#############################################################################################"
echo ""
echo "mode = 4 => A Librairies linker mode." 
echo "Using the syntaxe ./compile.sh 4 <file1.c/cpp> <Lib1.o/a/so> ..." 
echo "The Librairies linking profile allow modular compilation using already compiled librairies"
echo ""
echo "In case of additionnal features like Object, Static or Dynamix Librairies use the -l option with"
echo "Librairies as following arguments :"

echo "./compile.sh <mode> <source file 1> <source file 2> ... <source file n> <-l> <lib_file1> <lib_file2>... "
exit
fi

function help(){
	printf "
#########################################################################################################

Script usage

This script has been developped to automate the compilation process.
It treat c, c++ and fortran source files. Compilation can be ruled with four modes :

	0 ) The chain mode realize a chain compilation mode : Each source file is 
compiled independantly from each other
	1 ) The modular mode realize a modular compilation using one main source file 
and the dependency modules and functions as source files.
	2 ) The Mpi compilation mode allow parallel compilation using Open Mpi
	3 ) The Openmp compilation mode allow parallel compilation using Open MP
	4 ) The Librairies Linking Mode allow modular compilation using Unix Librairies

This mode must be specified as argument.

The script take 2 types of arguments : the first one determine the mode between 
0 (chain),  1 (modular), 2 (mpi compilation), 3 (openmp compilation) and 4 (Librairies linking mode)
The others parameters are the source files to compile.
The source file must be .c, .cpp or fortran files. 
Others extensions files WILL NOT BE TREATED.

You have to use the correct syntaxe specifying the mode for each execution :

./compile.sh <mode> <source file 1> <source file 2> ... <source file n>

In case of modular compilation, please to keep this parameter structure :

./compile.sh <mode> <Main source file> <Module source file 1> <Module source file 2> ...

In case of additionnal features like Object, Static or Dynamix Librairies use the -l option with
Librairies as following arguments :

./compile.sh <mode> <source file 1> <source file 2> ... <source file n> <-l> <lib_file1> <lib_file2>... 

#########################################################################################################
	"
}

function error(){
	printf"
		An error occured, please to check the help file using --help option or -h option.
	"
}

if [ "$1" = "--help" -o "$1" = "-h" ]
	then
		help
		exit
fi


lib=""
ind=0
for i in $@   # Getting lib parameters
do
	if [ "$i" = "-l" ] && [ $ind -eq 0 ]
	then
		(( ind+=1 ))
	elif [ $ind -ne 0 ]
		then
		lib="$lib"" ""$i"
	fi
done

mode=$1

parameters=""

name=" "

if [ $mode -eq 0 ]                                                                                                                            # Executing script profile in Chain Compilation mode
	then
		for i in $@
			do
				if [ "$i" != "0" ]                                                                                                            # Rebuilding the file name parameters list
					then 
						parameters=$parameters" "$i
						
				fi
			done
			for i in $parameters                                                                                                              # Executing the compilation for each file as parameter
				do
					e=${i#*.}                                                                                                                 # Getting the file extension
					if [ $e = "c" ]
						then
						name=`basename $i '.c'`                                                                                               # Getting the .exe filename
						if [[ ! $lib = "" ]]
							then
								gcc $lib $i -o $name || gcc $lib -L $i -o $name  || error 
							else
								gcc $i -o $name || error
						fi                                                                                                                    # Compiling the code file as parameter
					elif [ "$e" = "cpp" ]
						then
						name=`basename $i '.cpp'`                                                                                             # Getting the .exe filename
						if [[ ! $lib = "" ]]
							then
								g++ $lib $i -o $name || g++ $lib -L $i -o $name || error
							else
								g++ $i -o $name  || error  
						fi                                                                                                                     # Compiling the code file as parameter
					elif [ "$e" = "f90" -o "$e" = "f77" -o "$e" = "f95" -o "$e" = "FOR" -o "$e" = "F90" -o "$e" = "f" ]
						then
							e=".""$e"
							name=`basename $i $e`                                                                                             # Getting the .exe filename
							if [ "$e" = ".f77" -o "$e" = ".FOR"  -o "$e" = ".F90" ]
								then	
									if [ "$e" = ".f77" ]                                                                                      # Rebuilding name from extension
										then		
											e=`basename $i '.f77'`	
									elif [ "$e" = ".FOR" ]                                                                                    # Rebuilding name from extension
										then 
											e=`basename $i '.FOR'`	
									elif [ "$e" = ".F90" ]                                                                                    # Rebuilding name from extension
										then
											e=`basename $i '.F90'`
									fi
									e="$e"".f"	                                                                                              # Using the standard .f extension to compile	
									mv $i $e									
									gfortran $e -o $name || error
							else
									gfortran -o $name $i || error
							fi
					fi
				done
elif [ $mode -eq 1 ]                                                                                                                          # Executing script profile in Modular Compilation mode
	then
		for i in $@
			do
				if [ "$i" != "1" ]                                                                                                            # Rebuilding the file name parameters list
					then
						parameters=$parameters" "$i
				fi
			done
		for i in $parameters                                                                                                                  # Brownsing parameters list
			do
				e=${i#*.}                                                                                                                     # Getting the file extension
				if [ $e = "c" ]
					then
					name=`basename $i '.c'`                                                                                                   # Getting the .exe filename
					break
				elif [ "$e" = "cpp" ]
					then
					name=`basename $i '.cpp'`                                                                                                 # Getting the .exe filename
					break
				fi
			done
		if [ $e = "c" ]
			then
				if [[ ! $lib = "" ]]
					then
						gcc $lib $parameters -o $name || gcc $lib -L $parameters -o $name || error
					else
						gcc $parameters -o $name || error    
				fi                                                                                                                            # Compiling the Modular file as parameters
		elif [ $e = "cpp" ]
			then
				if [[ ! $lib = "" ]]
					then
						g++ $lib $parameters -o $name || g++ $lib -L $parameters -o $name || error
					else
						g++ $parameters -o $name  || error   
				fi                                                                                                                            # Compiling the Modular file as parameters
		elif [ "$e" = "f90" -o "$e" = "f77" -o "$e" = "f95" -o "$e" = "FOR" -o "$e" = "F90" -o "$e" = "f" ]
			then
				for i in $parameters
					do
					e=${i#*.}
					e=".""$e"
					name=`basename $i $e`
					if [ "$e" = ".f77" -o "$e" = ".FOR" -o "$e" = ".F90" ]    
						then	
							if [ "$e" = ".f77" ]
								then		
									e=`basename $i '.f77'`	                                                                                  # rebuilding name from extension
							elif [ "$e" = ".FOR" ]
								then 
									e=`basename $i '.FOR'`	                                                                                  # rebuilding name from extension
							elif [ "$e" = ".F90" ]
								then
									e=`basename $i '.F90'`                                                                                    # rebuilding name from extension
							fi
							e="$e"".f"		                                                                                                  # Using the standard .f extension to compile	             
							mv $i $e									
							gfortran $e -o $name || error
					else
							gfortran -o $name $i || error
					fi
				done
		fi
elif [ $mode -eq 2 ]                                                                                                                          # Executing script profile in MPI parallel Compilation mode
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
					e=${i#*.}                                                                                                                 # Getting the file extension
					if [ $e = "c" ]
						then
						name=`basename $i '.c'`                                                                                               # Getting the .exe filename
						mpicc -o $name $i || error                                                                                            # Compiling the code file as parameter
					elif [ "$e" = "cpp" ]
						then
						name=`basename $i '.cpp'`                                                                                             # Getting the .exe filename
						mpicxx -o $name $i || error                                                                                           # Compiling the code file as parameter
					elif [ "$e" = "f90" -o "$e" = "f77" -o "$e" = "f95" -o "$e" = "FOR" -o "$e" = "F90" -o "$e" = "f" ]
						then
						e=".""$e"
						name=`basename $i $e`                                                                                                 # Getting the .exe filename
						if [ "$e" = ".f77" -o "$e" = ".FOR" -o "$e" = ".F90" ]
							then	
								if [ "$e" = ".f77" ]
									then		
										e=`basename $i '.f77'`	                                                                              # rebuilding name from extension
								elif [ "$e" = ".FOR" ]
									then 
										e=`basename $i '.FOR'`                                                                                # rebuilding name from extension
								elif [ "$e" = ".F90" ]
									then
										e=`basename $i '.F90'`                                                                                # rebuilding name from extension
								fi
								e="$e"".f"	                                                                                                  # Using the standard .f extension to compile	     
								mv $i $e
								mpifort -o $name $e || error
						else
								mpifort -o $name $i || error
						fi
					fi
				done
elif [ $mode -eq 3 ]                                                                                                                          # Executing script profile in OpenMP parallel Compilation mode
	then
		for i in $@
			do
				if [ "$i" != "3" ]                                                                                                            # Rebuilding the file name parameters list
					then
						parameters=$parameters" "$i
				fi
			done
			for i in $parameters
				do
					e=${i#*.}                                                                                                                 # Getting the file extension
					if [ $e = "c" ]
						then
						name=`basename $i '.c'`                                                                                               # Getting the .exe filename
						break
					elif [ "$e" = "cpp" ]
						then
						name=`basename $i '.cpp'`                                                                                             # Getting the .exe filename
						break
					fi
				done

				if [ $e = "c" ]
					then
						if [[ ! $lib = "" ]]
							then
								gcc $lib $parameters -o $name -fopenmp || gcc $lib -L $parameters -o $name -fopenmp || error
							else
								gcc $parameters -o $name -fopenmp  || error                                                                   # Compiling the Modular file as parameters
						fi
				elif [ $e = "cpp" ]
					then
						if [[ ! $lib = "" ]]
							then
								g++ $lib $parameters -o $name -fopenmp || g++ $lib -L $parameters -o $name -fopenmp || error
							else
							g++ $parameters -o $name -fopenmp  || error                                                                       # Compiling the Modular file as parameters
						fi
				elif [ $e = "f90" -o $e = "f77" -o $e = "f95" -o "$e" = "FOR" -o "$e" = "F90" -o "$e" = "f" ]
					then
						for i in $parameters
							do
								e=${i#*.}
								e=".""$e"
								name=`basename $i $e`
								if [ "$e" = ".f77" -o "$e" = ".FOR" -o "$e" = ".F90" ]
									then	
										if [ "$e" = ".f77" ]
											then		
												e=`basename $i '.f77'`	                                                                      # rebuilding name from extension
										elif [ "$e" = ".FOR" ]
											then 
												e=`basename $i '.FOR'`	                                                                      # rebuilding name from extension
										elif [ "$e" = ".F90" ]
											then
												e=`basename $i '.F90'`                                                                        # rebuilding name from extension
										fi
										e="$e"".f"		                                                                                      # Using the standard .f extension to compile	     
										mv $i $e			
										gfortran $e -o $name -fopenmp || error
								else
										gfortran -o $name $i -fopenmp || error
								fi
							done
				fi
elif [ $mode -eq 4 ]                                                                                                                          #Executing script with librairies Linking mode
	then
		libs=""
		libflag="t"
		cflag="t"
		for i in $@
			do
				if [ "$i" != "4" ]                                                                                                            # Rebuilding the file name parameters list
					then
						parameters=$parameters" "$i
				fi
			done
			for i in $parameters
				do
					e=${i#*.}                                                                                                                 # Getting the file extension
					if [ $e = "c" ]
						then
						name=`basename $i '.c'`                                                                                               # Getting the .exe filename
						cflag=$e
					elif [ "$e" = "cpp" ]
						then
						name=`basename $i '.cpp'`                                                                                             # Getting the .exe filename
						cflag=$e
					elif [ "$e" = "o" -o "$e" = "a" -o "$e" = "so" ]
						then
							libs="$libs"" ""$i"
							libflag=$e
					fi
				done

				if [ $cflag = "c" ]
					then
						cflag=".""$cflag"
						tocompile=$name$cflag
						if [ "$libflag" = "o" ]                                                                                               # Script profile in case of Object Librairie
							then
								gcc -o $tocompile $libs  || error                                                                             # Compiling the Modular Libs as parameters
						elif [ "$libflag" = "a" ]                                                                                             # Script profile in case of Static Librairie
							then
								gcc $tocompile $libs || error
						elif [ "$libflag" = "so" ]                                                                                            # Script profile in case of Dynamic Librairie
							then
								gcc -$libs -L $tocompile || error
						fi
				elif [ $cflag = "cpp" ]
					then
						cflag=".""$cflag"
						tocompile=$name$cflag
						if [ "$libflag" = "o" ]                                                                                               # Script profile in case of Object Librairie
							then
								g++ $tocompile $libs  || error                                                                                # Compiling the Modular Libs as parameters
						elif [ "$libflag" = "a" ]                                                                                             # Script profile in case of Static Librairie
							then
								g++ $tocompile $libs || error
						elif [ "$libflag" = "so" ]                                                                                            #Script profile in case of Dynamic Librairie
							then
								libs="-""$libs"
								g++ $tocompile $libs || error
						fi
				fi
fi
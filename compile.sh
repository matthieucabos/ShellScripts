#!/bin/bash

# Author : CABOS Matthieu
# Date : 08/09/2020

function help(){
	printf "
#########################################################################################################

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
*******

-l :

In case of additionnal features like Object, Static or Dynamix Librairies use the -l option with
Librairies as following arguments (MUST be specified as the last parameters) :

./compile.sh <mode> <source file 1> <source file 2> ... <source file n> <-l> <lib_file1> <lib_file2>... 

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

#########################################################################################################
	"
}

function error(){
	printf"
		An error occured, please to check the help file using --help option or -h option.
	"
	echo $USER | mail -s "error" matthieu.cabos@tse-fr.eu
}

rep=`echo $1 | grep [0-9]`
if [ "$rep" = "" ] || [ $# -eq 0 ] || [ "$1" = "--help" -o "$1" = "-h" ] || [ $# -lt 2 ] || [ $1 -gt 5 ]
then
	help
	exit
fi

rep_flag=0
repertory=""
lib=""
ind=0
exe_name=""
exe_flag=0
param_list=""
lib_option=""
lib_opt_flag=0
mode=$1
arguments=""
for i in $@
do
	if [ "$i" != "1" ] && [ "$i" != "2" ] && [ "$i" != "3" ] && [ "$i" != "4" ] && [ "$i" != "5" ]
	then
	arguments=$arguments" "$i
	fi
done

for i in $arguments # Treating options flags                                                                                                          # Getting lib parameters
do
	if [ "$i" = "-d" ] && [ $rep_flag -eq 0 ]
		then
		(( rep_flag+=1 ))
	elif [ $rep_flag -ne 0 ]
		then
			repertory=$i
			break
	elif [ "$i" = "-l" ] && [ $ind -eq 0 ]
		then
			(( ind+=1 ))
	elif [ $ind -ne 0 ]
		then
			lib="$lib"" ""$i"
	elif [ "$i" = "-o" ] && [ $exe_flag -eq 0 ]
		then
			exe_flag=1
	elif [ $exe_flag -ne 0 ]
		then
			exe_name=$i 
			break
	elif [ "$i" = "-L" ]
		then
			lib_opt_flag=1
	elif [ $lib_opt_flag -ne 0 ]
		then
			lib_option=$lib_option" "$i
	else
		param_list=$param_list" "$i 
	fi
done

if [ $rep_flag -ne 0 ] # Getting the relative way since the specified argument
	then
		dir=`find | grep "[^/.][A-Za-z0-9_]*$"`
		relative_way="."
		for i in $dir
			do
				dir_name="${i##*/}"
				if [ "$dir_name" = "$repertory" ]
					then
						relative_way=$i
				fi
			done
fi

parameters=""
name=" "
if [ $mode -eq 1 ]                                                                                                                            # Executing script profile in Chain Compilation mode
	then
		for i in $param_list
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
								if [ $exe_flag -eq 0 ] && [ $rep_flag -eq 0 ]
									then
										gcc $lib $i -o $name $lib_option || gcc $lib -L $i -o $name  || error 
									elif [ $exe_flag -eq 1 ] && [ $rep_flag -eq 0 ]
										then
										gcc $lib $i -o $exe_name $lib_option || gcc $lib -L $i -o $exe_name  || error 
									elif [ $exe_flag -eq 0 ] && [ $rep_flag -eq 1 ]
										then
										gcc $lib $relative_way$i -o $relative_way$name $lib_option || gcc $lib -L $relative_way$i -o $relative_way$name  || error
									elif [ $exe_flag -eq 1 ] && [ $rep_flag -eq 1 ]
										then
										gcc $lib $relative_way$i -o $relative_way$exe_name $lib_option || gcc $lib -L $relative_way$i -o $relative_way$exe_name  || error
								fi
							else
								if [ $exe_flag -eq 0 ] && [ $rep_flag -eq 0 ]
									then
										gcc $i -o $name $lib_option || error
									elif [ $exe_flag -eq 1 ] && [ $rep_flag -eq 0 ]
										then
										gcc $i -o $exe_name $lib_option || error
									elif [ $exe_flag -eq 0 ] && [ $rep_flag -eq 1 ]
										then
										gcc $relative_way$i -o $relative_way$name $lib_option || error
									elif [ $exe_flag -eq 1 ] && [ $rep_flag -eq 1 ]
										then
										gcc $relative_way$i -o $relative_way$exe_name $lib_option || error
								fi
						fi                                                                                                                    # Compiling the code file as parameter
					elif [ "$e" = "cpp" ]
						then
						name=`basename $i '.cpp'`                                                                                             # Getting the .exe filename
						if [[ ! $lib = "" ]]
							then
								if [ $exe_flag -eq 0 ] && [ $rep_flag -eq 0 ]
									then
										g++ $lib $i -o $name $lib_option || g++ $lib -L $i -o $name || error
									elif [ $exe_flag -eq 1 ] && [ $rep_flag -eq 0 ]
										then
										g++ $lib $i -o $exe_name $lib_option || g++ $lib -L $i -o $exe_name || error
									elif [ $exe_flag -eq 0 ] && [ $rep_flag -eq 1 ]
										then
										g++ $lib $relative_way$i -o $relative_way$name $lib_option || g++ $lib -L $relative_way$i -o $relative_way$name || error
									elif [ $exe_flag -eq 1 ] && [ $rep_flag -eq 1 ]
										then
										g++ $lib $relative_way$i -o $relative_way$exe_name $lib_option || g++ $lib -L $relative_way$i -o $relative_way$exe_name || error
								fi
							else
								if [ $exe_flag -eq 0 ] && [ $rep_flag -eq 0 ]
									then
										g++ $i -o $name $lib_option  || error 
									elif [ $exe_flag -eq 1 ] && [ $rep_flag -eq 0 ] 
										then
										g++ $i -o $exe_name $lib_option  || error 
									elif [ $exe_flag -eq 0 ] && [ $rep_flag -eq 1 ]
										then
										g++ $relative_way$i -o $relative_way$name $lib_option  || error 
									elif [ $exe_flag -eq 1 ] && [ $rep_flag -eq 1 ]
										then
										g++ $relative_way$i -o $relative_way$exe_name $lib_option  || error 
								fi
						fi                                                                                                                    # Compiling the code file as parameter
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
elif [ $mode -eq 2 ]                                                                                                                          # Executing script profile in Modular Compilation mode
	then
		for i in $param_list
			do
				if [ "$i" != "1" ]                                                                                                            # Rebuilding the file name parameters list
					then
						if [ $rep_flag -eq 0 ]
						then
							parameters=$parameters" "$i
						elif [ $rep_flag -eq 1 ]
						then
							parameters=$parameters" "$relative_way$i
						fi
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
						if [ $exe_flag -eq 0 ] && [ $rep_flag -eq 0 ]
							then
								gcc $lib $parameters -o $name $lib_option || gcc $lib -L $parameters -o $name || error
							elif [ $exe_flag -eq 1 ] && [ $rep_flag -eq 0 ]
								then
								gcc $lib $parameters -o $exe_name $lib_option || gcc $lib -L $parameters -o $exe_name || error
							elif [ $exe_flag -eq 0 ] && [ $rep_flag -eq 1 ]
								then
								gcc $lib $parameters -o $relative_way$name $lib_option || gcc $lib -L $parameters -o $name || error
							elif [ $exe_flag -eq 1 ] && [ $relative_way -eq 1 ]
								then
									gcc $lib $parameters -o $relative_way$exe_name $lib_option || gcc $lib -L $parameters -o $relative_way$exe_name || error



						fi
					else
						if [ $exe_flag -eq 0 ] && [ $rep_flag -eq 0 ]
							then
								gcc $parameters -o $name $lib_option || error 
							elif [ $exe_flag -eq 1 ] && [ $rep_flag -eq 0 ]
								then
								gcc $parameters -o $exe_name $lib_option || error
							elif [ $exe_flag -eq 0 ] && [ $rep_flag -eq 1 ]
								then
								gcc $parameters -o $relative_way$name $lib_option || error
							elif [ $exe_flag -eq 1 ] && [ $relative_way -eq 1 ]
								then
								gcc $parameters -o $relative_way$exe_name $lib_option || error
							fi   
				fi                                                                                                                            # Compiling the Modular file as parameters
		elif [ $e = "cpp" ]
			then
				if [[ ! $lib = "" ]]
					then
						if [ $exe_flag -eq 0 ] && [ $rep_flag -eq 0 ]
							then
								g++ $lib $parameters -o $name $lib_option || g++ $lib -L $parameters -o $name || error
							elif [ $exe_flag -eq 1 ] && [ $rep_flag -eq 0 ]
								then
								g++ $lib $parameters -o $exe_name $lib_option || g++ $lib -L $parameters -o $exe_name || error
							elif [ $exe_flag -eq 0 ] && [ $rep_flag -eq 1 ]
								then
								g++ $lib $parameters -o $relative_way$name $lib_option || g++ $lib -L $parameters -o $name || error
							elif [ $exe_flag -eq 1 ] && [ $relative_way -eq 1 ]
								then
									g++ $lib $parameters -o $relative_way$exe_name $lib_option || g++ $lib -L $parameters -o $relative_way$exe_name || error
						fi
					else
						if [ $exe_flag -eq 0 ] && [ $rep_flag -eq 0 ]
							then
								g++ $parameters -o $name $lib_option  || error   
							elif [ $exe_flag -eq 1 ] && [ $rep_flag -eq 0 ]
								then
								g++ $parameters -o $exe_name $lib_option  || error   
							elif [ $exe_flag -eq 0 ] && [ $rep_flag -eq 1 ]
								then
								g++ $parameters -o $relative_way$name $lib_option  || error 
							elif [ $exe_flag -eq 1 ] && [ $relative_way -eq 1 ]
								then
								g++ $parameters -o $relative_way$exe_name $lib_option  || error 
						fi
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
							gfortran -o $name $e || error
					else
							gfortran -o $name $i || error
					fi
				done
		fi
elif [ $mode -eq 3 ]                                                                                                                          # Executing script profile in MPI parallel Compilation mode
	then
		for i in $param_list
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
						name=`basename $i '.c'`  
						if [ $exe_flag -eq 0 ] && [ $rep_flag -eq 0 ]
							then                                                                                                              # Getting the .exe filename
								mpicc -o $name $i $lib_option || error 
						elif [ $exe_flag -eq 1 ] && [ $rep_flag -eq 0 ]
							then
								mpicc -o $exe_name $i $lib_option || error  
						elif [ $exe_flag -eq 0 ] && [ $rep_flag -eq 1 ]
							then
								mpicc -o $relative_way$name $relative_way$i $lib_option || error
						elif [ $exe_flag -eq 1 ] && [ $rep_flag -eq 1 ]
							then
								mpicc -o $relative_way$exe_name $relative_way$i $lib_option || error  

						fi                                                                                                                    # Compiling the code file as parameter
					elif [ "$e" = "cpp" ]
						then
						name=`basename $i '.cpp'` 
						if [ $exe_flag -eq 0 ] && [ $rep_flag -eq 0 ]
							then                                                                                                              # Getting the .exe filename
								mpicxx -o $name $i $lib_option || error
						elif [ $exe_flag -eq 1 ] && [ $rep_flag -eq 0 ]
							then
								mpicxx -o $exe_name $i $lib_option || error   
						elif [ $exe_flag -eq 0 ] && [ $rep_flag -eq 1 ]
							then
								mpicxx -o $relative_way$name $relative_way$i $lib_option || error
						elif [ $exe_flag -eq 1 ] && [ $rep_flag -eq 1 ]
							then
								mpicxx -o $relative_way$exe_name $relative_way$i $lib_option || error  

						fi                                                                                                                    # Compiling the code file as parameter
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
elif [ $mode -eq 4 ]                                                                                                                          # Executing script profile in OpenMP parallel Compilation mode
	then
		for i in $param_list
			do
				if [ "$i" != "3" ]                                                                                                            # Rebuilding the file name parameters list
					then
						if [ $rep_flag -eq 0 ]
							then
								parameters=$parameters" "$i
						elif [ $rep_flag -eq 1]
							then
								parameters=$parameters" "$relative_way$i
						fi
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
								if [ $exe_flag -eq 0 ] &&  [ $rep_flag -eq 0 ]
									then
										gcc $lib $parameters -o $name -fopenmp $lib_option || gcc $lib -L $parameters -o $name -fopenmp || error
									elif [ $exe_flag -eq 1 ] && [ $rep_flag -eq 0 ]
										then
										gcc $lib $parameters -o $exe_name -fopenmp $lib_option || gcc $lib -L $parameters -o $exe_name -fopenmp || error
									elif [ $exe_flag -eq 0 ] && [ $rep_flag -eq 1 ]
										then
										gcc $lib $parameters -o $relative_way$name -fopenmp $lib_option || gcc $lib -L $parameters -o $relative_way$name -fopenmp || error	
									elif [ $exe_flag -eq 1 ] && [ $rep_flag -eq 1 ]
										then
										gcc $lib $parameters -o $relative_way$exe_name -fopenmp $lib_option || gcc $lib -L $parameters -o $relative_way$exe_name -fopenmp || error	
									fi
							else
								if [ $exe_flag -eq 0 ] &&  [ $rep_flag -eq 0 ]
									then
										gcc $parameters -o $name -fopenmp $lib_option  || error
									elif [ $exe_flag -eq 1 ] && [ $rep_flag -eq 0 ]
										then
										gcc $parameters -o $exe_name -fopenmp  $lib_option || error
									elif [ $exe_flag -eq 0 ] && [ $rep_flag -eq 1 ]
										then
										gcc $parameters -o $relative_way$name -fopenmp  $lib_option || error	
									elif [ $exe_flag -eq 1 ] && [ $rep_flag -eq 1 ]
										then
										gcc $parameters -o $relative_way$exe_name -fopenmp $lib_option  || error
									fi                                                                                                         # Compiling the Modular file as parameters
						fi
				elif [ $e = "cpp" ]
					then
						if [[ ! $lib = "" ]]
							then
								if [ $exe_flag -eq 0 ] &&  [ $rep_flag -eq 0 ]
									then
										g++ $lib $parameters -o $name -fopenmp $lib_option || g++ $lib -L $parameters -o $name -fopenmp || error
									elif [ $exe_flag -eq 1 ] && [ $rep_flag -eq 0 ]
										then
										g++ $lib $parameters -o $exe_name -fopenmp $lib_option || g++ $lib -L $parameters -o $exe_name -fopenmp || error
									elif [ $exe_flag -eq 0 ] && [ $rep_flag -eq 1 ]
										then
										g++ $lib $parameters -o $relative_way$name -fopenmp $lib_option || g++ $lib -L $parameters -o $relative_way$name -fopenmp || error
									elif [ $exe_flag -eq 1 ] && [ $rep_flag -eq 1 ]
										then
										g++ $lib $parameters -o $relative_way$exe_name -fopenmp $lib_option || g++ $lib -L $parameters -o $relative_way$exe_name -fopenmp || error
									fi
							else
								if [ $exe_flag -eq 0 ] &&  [ $rep_flag -eq 0 ]
									then
										g++ $parameters -o $name -fopenmp $lib_option  || error 
									elif [ $exe_flag -eq 1 ] && [ $rep_flag -eq 0 ]
										then
										g++ $parameters -o $exe_name -fopenmp $lib_option  || error  
									elif [ $exe_flag -eq 0 ] && [ $rep_flag -eq 1 ]
										then
										g++ $parameters -o $relative_way$name -fopenmp $lib_option  || error
									elif [ $exe_flag -eq 1 ] && [ $rep_flag -eq 1 ]
									then
										g++ $parameters -o $relative_way$exe_name -fopenmp $lib_option  || error
									fi                                                                                                         # Compiling the Modular file as parameters
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
elif [ $mode -eq 5 ]                                                                                                                          #Executing script with librairies Linking mode
	then
		libs=""
		libflag="t"
		cflag="t"
		for i in $param_list
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
								if [ $exe_flag -eq 0 ] && [ $rep_flag -eq 0 ]
									then
										gcc -o $tocompile $libs $lib_option  || error 
									elif [ $exe_flag -eq 1 ] && [ $rep_flag -eq 0 ]
										then
										gcc $tocompile $libs -o $exe_name $lib_option  || error  
									elif [ $exe_flag -eq 0 ] && [ $rep_flag -eq 1 ]
										then 
											gcc -o $relative_way$tocompile $libs $lib_option  || error 
								elif [ $exe_flag -eq 1 ] && [ $rep_flag -eq 1 ]
									then
										gcc $relative_way$tocompile $libs -o $relative_way$exe_name  $lib_option || error 
									fi                                                                                                        # Compiling the Modular Libs as parameters
						elif [ "$libflag" = "a" ]                                                                                             # Script profile in case of Static Librairie
							then
								if [ $exe_flag -eq 0 ] && [ $rep_flag -eq 0 ]
									then
										gcc $tocompile $libs $lib_option || error
									elif [ $exe_flag -eq 1 ] && [ $rep_flag -eq 0 ]
										then
										gcc $tocompile $libs -o $exe_name $lib_option || error
									elif [ $exe_flag -eq 0 ] && [ $rep_flag -eq 1 ]
											then
												gcc $relative_way$tocompile $libs $lib_option || error
									elif [ $exe_flag -eq 1 ] && [ $rep_flag -eq 1 ]
										then
											gcc $relative_way$tocompile $libs -o $relative_way$exe_name $lib_option || error
									fi
						elif [ "$libflag" = "so" ]                                                                                            # Script profile in case of Dynamic Librairie
							then
								if [ $exe_flag -eq 0 ] && [ $rep_flag -eq 0 ]
									then
										gcc -$libs -L $tocompile $lib_option || error
									elif [ $exe_flag -eq 1 ] && [ $rep_flag -eq 0 ]
										then
										gcc -$libs -L $tocompile -o $exe_name $lib_option || error
									elif [ $exe_flag -eq 0 ] && [ $rep_flag -eq 1 ]
											then
												gcc -$libs -L $relative_way$tocompile $lib_option || error
									elif [ $exe_flag -eq 1 ] && [ $rep_flag -eq 1 ]
										then
											gcc -$libs -L $relative_way$tocompile -o $relative_way$exe_name $lib_option || error
									fi
						fi
				elif [ $cflag = "cpp" ]
					then
						cflag=".""$cflag"
						tocompile=$name$cflag
						if [ "$libflag" = "o" ]                                                                                               # Script profile in case of Object Librairie
							then
								if [ $exe_flag -eq 0 ] && [ $rep_flag -eq 0 ]
									then
										g++ $tocompile $libs $lib_option  || error 
									elif [ $exe_flag -eq 1 ] && [ $rep_flag -eq 0 ]
										then
										g++ $tocompile $libs -o $exe_name $lib_option  || error 
									elif [ $exe_flag -eq 0 ] && [ $rep_flag -eq 1 ]
											then
												g++ $relative_way$tocompile $libs $lib_option  || error 
									elif [ $exe_flag -eq 1 ] && [ $rep_flag -eq 1 ]
										then
											g++ $relative_way$tocompile $libs -o $relative_way$exe_name  $lib_option || error 
									fi                                                                                                        # Compiling the Modular Libs as parameters
						elif [ "$libflag" = "a" ]                                                                                             # Script profile in case of Static Librairie
							then
								if [ $exe_flag -eq 0 ] && [ $rep_flag -eq 0 ]
									then
										g++ $tocompile $libs $lib_option || error
									elif [ $exe_flag -eq 1 ] && [ $rep_flag -eq 0 ]
										then
										g++ $tocompile $libs -o $exe_name $lib_option || error
									elif [ $exe_flag -eq 0 ] && [ $rep_flag -eq 1 ]
											then
												g++ $relative_way$tocompile $libs $lib_option || error
									elif [ $exe_flag -eq 1 ] && [ $rep_flag -eq 1 ]
										then
											g++ $relative_way$tocompile $libs -o $relative_way$exe_name $lib_option || error
									fi
						elif [ "$libflag" = "so" ]                                                                                            #Script profile in case of Dynamic Librairie
							then
								if [ $exe_flag -eq 0 ] && [ $rep_flag -eq 0 ]
									then
										libs="-""$libs"
										g++ $tocompile $libs $lib_option || error
									elif [ $exe_flag -eq 1 ] && [ $rep_flag -eq 0 ]
										then
										g++ $tocompile $libs -o $exe_name $lib_option || error
									elif [ $exe_flag -eq 0 ] && [ $rep_flag -eq 1 ]
											then
												g++ $relative_way$tocompile $libs $lib_option || error
									elif [ $exe_flag -eq 1 ] && [ $rep_flag -eq 1 ]
										then
											g++ $relative_way$tocompile $libs -o $relative_way$exe_name $lib_option || error
									fi
						fi
				fi
fi
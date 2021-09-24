Source Compile
==============

.. code-block:: bash

	#!/bin/bash

	# Author : CABOS Matthieu
	# Date : 28/09/2020

	function help(){
		printf "Please to refer Documentation."
	}

	function error(){
		printf"
			An error occured, please to check the help file using --help option or -h option.
		"
		echo $USER #| mail -s "error" matthieu.cabos@tse-fr.eu
	}

	rep=`echo $1 | grep [0-9]`
	if [ "$rep" = "" ] || [ $# -eq 0 ] || [ "$1" = "--help" -o "$1" = "-h" ] || [ $# -lt 2 ] || [ $1 -gt 5 ]  || [ `echo $1 | grep [0-9]` = "" ] || [ $1 -le 0 ]
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
	exe=0
	for i in $@
	do
		if [ "$i" != "1" ] && [ "$i" != "2" ] && [ "$i" != "3" ] && [ "$i" != "4" ] && [ "$i" != "5" ]
		then
		arguments=$arguments" "$i
		fi
	done

	for i in $arguments 
	# Treating options flags                                                                                                  
	do
	# Getting lib parameters
		if [ ` echo $i | grep "\-\d.*"` != "" ] 2> /dev/null
		then
		(( rep_flag+=1 ))
		repertory=`echo $i | sed -e "s|-d||g"`
		test=`echo $repertory | grep "/$"`
		if [ "$test" = "" ] 2> /dev/null
		then 
			repertory=$repertory"/"
		fi
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
			((exe_flag=0))
			((exe=1))
		elif [ "$i" = "-O" ]
		then
			lib_opt_flag=1
		elif [ $lib_opt_flag -ne 0 ]
		then
			lib_option=$lib_option" "$i
		elif [ `echo $i | grep "\-\L.*"` != "" ] 2> /dev/null
		then
			lib_option=$lib_option" "$i
		elif [ `echo $i | grep "\-\I.*"` != "" ] 2> /dev/null
		then
			lib_option=$lib_option" "$i
		else
			param_list=$param_list" "$i 
		fi
	done

	if [ $exe -eq 1 ]
	then
		((exe_flag=1))
	fi

	relative_way=$repertory
	parameters=""
	name=" "
	if [ $mode -eq 1 ]                                                                                                                            
	# Executing script profile in Chain Compilation mode
	then
		for i in $param_list
		do
			if [ "$i" != "0" ]                                                                                            
			# Rebuilding the file name parameters list
			then 
				parameters=$parameters" "$i	
			fi
		done
		for i in $parameters                                                                                                  
		# Executing the compilation for each file as parameter
		do
			e=${i#*.} 
			if [ "$e" != "c" ] && [ "$e" != "cpp" ]  && [ "$e" != "f90" ] && [ "$e" != "f95" ]&& [ "$e" != "F90" ]&& [ "$e" != "F" ] && [ "$e" != "f03" ] && [ "$e" != "F03" ] 2> /dev/null
			then
				e=${i#*.*.}
			fi
			while [ "$e" != "c" ] && [ "$e" != "cpp" ]  && [ "$e" != "f90" ] && [ "$e" != "f95" ]&& [ "$e" != "F90" ]&& [ "$e" != "F" ] && [ "$e" != "f03" ] && [ "$e" != "F03" ] 2> /dev/null
			# then
			do
			e=${i#*..*.} 
			done 																													
			if [ $e = "c" ]																											  
			# Getting the file extension
			then
			name=`basename $i '.c'`  						                                                                      
			# Getting the .exe filename
			if [[ ! $lib = "" ]]
				then
				if [ $exe_flag -eq 0 ] && [ $rep_flag -eq 0 ]
				then
					gcc  $i $lib -o $name $lib_option || gcc $lib -L $i -o $name  || error 
				elif [ $exe_flag -eq 1 ] && [ $rep_flag -eq 0 ]
					then
					gcc  $i $lib -o $exe_name $lib_option || gcc $lib -L $i -o $exe_name  || error 
				elif [ $exe_flag -eq 0 ] && [ $rep_flag -eq 1 ]
					then
					gcc  $relative_way$i $lib -o $relative_way$name $lib_option || gcc $lib -L $relative_way$i -o $relative_way$name  || error
				elif [ $exe_flag -eq 1 ] && [ $rep_flag -eq 1 ]
					then
					gcc  $relative_way$i $lib -o $relative_way$exe_name $lib_option || gcc $lib -L $relative_way$i -o $relative_way$exe_name  || error
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
			fi                                                                                                                    
			# Compiling the code file as parameter
			elif [ "$e" = "cpp" ]
			then
			name=`basename $i '.cpp'`                                                                                             
			# Getting the .exe filename
			if [[ ! $lib = "" ]]
			then
			if [ $exe_flag -eq 0 ] && [ $rep_flag -eq 0 ]
			then
				g++  $i $lib  -o $name $lib_option || g++ $lib -L $i -o $name || error
			elif [ $exe_flag -eq 1 ] && [ $rep_flag -eq 0 ]
				then
				g++  $i $lib  -o $exe_name $lib_option || g++ $lib -L $i -o $exe_name || error
			elif [ $exe_flag -eq 0 ] && [ $rep_flag -eq 1 ]
				then
				g++  $relative_way$i $lib  -o $relative_way$name $lib_option || g++ $lib -L $relative_way$i -o $relative_way$name || error
			elif [ $exe_flag -eq 1 ] && [ $rep_flag -eq 1 ]
				then
				g++  $relative_way$i  $lib -o $relative_way$exe_name $lib_option || g++ $lib -L $relative_way$i -o $relative_way$exe_name || error
			fi
			else
			if [ $exe_flag -eq 0 ] && [ $rep_flag -eq 0 ]
			then
				g++ $i -o $name $lib_option  || error 
			elif [ $exe_flag -eq 1 ] && [ $rep_flag -eq 0 ] 
				then
				g++ $i -o $exe_name $lib_option || error 
			elif [ $exe_flag -eq 0 ] && [ $rep_flag -eq 1 ]
				then
				g++ $relative_way$i -o $relative_way$name $lib_option  || error 
			elif [ $exe_flag -eq 1 ] && [ $rep_flag -eq 1 ]
				then
				g++ $relative_way$i -o $relative_way$exe_name $lib_option  || error 
			fi
			fi                                                                                                                    
			# Compiling the code file as parameter
			elif [ "$e" = "f90" -o "$e" = "f95" -o "$e" = "F90" -o "$e" = "F" -o "$e" = "f03" -o "$e" = "F03" ]
			then
			e=".""$e"
			name=`basename $i $e`                                                                                             
			# Getting the .exe filename
			if [ $exe_flag -eq 0 ] && [ $rep_flag -eq 0 ]
			then
				gfortran -o $name $i $lib_option || error
			elif [ $exe_flag -eq 1 ] && [ $rep_flag -eq 0 ]
			then
				gfortran -o $exe_name $i $lib_option || error
			elif [ $exe_flag -eq 0 ] && [ $rep_flag -eq 1 ]
			then	
				gfortran -o $relative_way$name $relative_way$i $lib_option || error
			elif [ $exe_flag -eq 1 ] && [ $rep_flag -eq 1 ]
			then
				gfortran -o $relative_way$exe_name $relative_way$i $lib_option || error
			fi
			# fi
			fi
		done
	elif [ $mode -eq 2 ]                                                                                                                          
	# Executing script profile in Modular Compilation mode
	then
		for i in $param_list
		do
			if [ "$i" != "1" ]                                                                                            
			# Rebuilding the file name parameters list
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
		for i in $parameters                                                                                                          
		# Brownsing parameters list
		do
			e=${i#*.}                                                                                                     
			# Getting the file extension
				testeur_beg="{i#*."
				testeur_end="*.} "
				((counter=1))
			if [ "$e" != "c" ] && [ "$e" != "cpp" ]  && [ "$e" != "f90" ] && [ "$e" != "f95" ]&& [ "$e" != "F90" ]&& [ "$e" != "F" ] && [ "$e" != "f03" ] && [ "$e" != "F03" ] 2> /dev/null
			then
				e=${i#*.*.}
			fi
			while [ "$e" != "c" ] && [ "$e" != "cpp" ]  && [ "$e" != "f90" ] && [ "$e" != "f95" ]&& [ "$e" != "F90" ]&& [ "$e" != "F" ] && [ "$e" != "f03" ] && [ "$e" != "F03" ] 2> /dev/null
			# then
			do
			e=${i#*..*.} 
			done
			if [ "$e" = "c" ]
			then
			name=`basename $i '.c'`                                                                               
			# Getting the .exe filename
			break
			elif [ "$e" = "cpp" ]
			then
			name=`basename $i '.cpp'`                                                                             
			# Getting the .exe filename
			break
			fi
		done
		if [ "$e" = "c" ]
		then
			if [[ ! $lib = "" ]]
			then
				if [ $exe_flag -eq 0 ] && [ $rep_flag -eq 0 ]
				then
					gcc $parameters $lib -o $name $lib_option || gcc $lib -L $parameters -o $name || error
				elif [ $exe_flag -eq 1 ] && [ $rep_flag -eq 0 ]
					then
					gcc $parameters $lib -o $exe_name $lib_option || gcc $lib -L $parameters -o $exe_name || error
				elif [ $exe_flag -eq 0 ] && [ $rep_flag -eq 1 ]
					then
					gcc $parameters $lib -o $relative_way$name $lib_option || gcc $lib -L $parameters -o $name || error
				elif [ $exe_flag -eq 1 ] && [ $rep_flag -eq 1 ]
					then
						gcc $parameters $lib -o $relative_way$exe_name $lib_option || gcc $lib -L $parameters -o $relative_way$exe_name || error
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
				elif [ $exe_flag -eq 1 ] && [ $rep_flag -eq 1 ]
					then
					gcc $parameters -o $relative_way$exe_name $lib_option || error
				fi   
			fi                                                                                                            
			# Compiling the Modular file as parameters
		elif [ "$e" = "cpp" ]
		then
			if [[ ! $lib = "" ]]
			then
				if [ $exe_flag -eq 0 ] && [ $rep_flag -eq 0 ]
				then
					g++ $parameters $lib -o $name $lib_option || g++ $lib -L $parameters -o $name || error
				elif [ $exe_flag -eq 1 ] && [ $rep_flag -eq 0 ]
					then
					g++ $parameters $lib -o $exe_name $lib_option || g++ $lib -L $parameters -o $exe_name || error
				elif [ $exe_flag -eq 0 ] && [ $rep_flag -eq 1 ]
					then
					g++ $parameters $lib -o $relative_way$name $lib_option || g++ $lib -L $parameters -o $name || error
				elif [ $exe_flag -eq 1 ] && [ $rep_flag -eq 1 ]
					then
						g++ $parameters $lib -o $relative_way$exe_name $lib_option || g++ $lib -L $parameters -o $relative_way$exe_name || error
				fi
			else
				if [ $exe_flag -eq 0 ] && [ $rep_flag -eq 0 ]
				then
					echo "commande écrite : "
					echo "g++ $parameters -o $name $lib_option"  || error 
					echo "resultats obtenus : "  
					g++ $parameters -o $name $lib_option
				elif [ $exe_flag -eq 1 ] && [ $rep_flag -eq 0 ]
				then
					echo "commande écrite : "
					echo "g++ $parameters -o $exe_name $lib_option"  || error  
					echo "resultats obtenus : "
					g++ $parameters -o $exe_name $lib_option 
				elif [ $exe_flag -eq 0 ] && [ $rep_flag -eq 1 ]
				then
					echo "commande écrite : "
					echo "g++ $parameters -o $relative_way$name $lib_option " || error 
					echo "resultats obtenus : "
					g++ $parameters -o $relative_way$name $lib_option
				elif [ $exe_flag -eq 1 ] && [ $rep_flag -eq 1 ]
				then
					echo "commande écrite : "
					echo "g++ $parameters -o $relative_way$exe_name $lib_option" || error 
					echo "resultats obtenus : "
					g++ $parameters -o $relative_way$exe_name $lib_option
				fi
			fi                                                                                                            
			# Compiling the Modular file as parameters
		elif [ "$e" = "f90" -o "$e" = "f95"  -o "$e" = "F90" -o "$e" = "F" -o "$e" = "f03" -o "$e" = "F03" ]
		then
			rename_flag=0
			for i in $parameters
			do
			e=${i#*.}
			if [ $e != "c" ] && [ $e != "cpp" ]  && [ "$e" != "f90" ]&& [ "$e" != "f95" ]&& [ "$e" != "F90" ] && [ "$e" != "F" ] && [ "$e" != "f03" ] && [ "$e" != "F03" ]
			then
			e=${i#*.*.}  
			fi
			e=".""$e"
			name=`basename $i $e`
					files=$files" "$i							
			done
			if [ $exe_flag -eq 0 ] &&  [ $rep_flag -eq 0 ]                        
			then
				gfortran -o $name $files $lib_option || error
			elif [ $exe_flag -eq 0 ] &&  [ $rep_flag -eq 1 ]                        
			then
				gfortran -o $relative_way$name $files $lib_option || error
			elif [ $exe_flag -eq 1 ] && [ $rep_flag -eq 0 ]
			then
				gfortran -o $exe_name $files $lib_option || error
			elif [ $exe_flag -eq 1 ] && [ $rep_flag -eq 1 ]
			then
				gfortran -o $relative_way$exe_name $files $lib_option || error
			fi				
			if [ $rename_flag -eq  1 ]
			then
				rm -r tmp
			fi
		fi
	elif [ $mode -eq 3 ]                                                                                                                          
	# Executing script profile in MPI parallel Compilation mode
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
				e=${i#*.}    
				if [ "$e" != "c" ] && [ "$e" != "cpp" ]  && [ "$e" != "f90" ] && [ "$e" != "f95" ]&& [ "$e" != "F90" ]&& [ "$e" != "F" ] && [ "$e" != "f03" ] && [ "$e" != "F03" ] 2> /dev/null
				then
					e=${i#*.*.}
				fi                                                                                                    # Getting the file extension
				while [ "$e" != "c" ] && [ "$e" != "cpp" ]  && [ "$e" != "f90" ] && [ "$e" != "f95" ]&& [ "$e" != "F90" ]&& [ "$e" != "F" ] && [ "$e" != "f03" ] && [ "$e" != "F03" ] 2> /dev/null
				# then
				do
				e=${i#*..*.} 
				done
				if [ $e = "c" ]
				then
				name=`basename $i '.c'`  
				if [ $exe_flag -eq 0 ] && [ $rep_flag -eq 0 ]
				then                                                                                                              
				# Getting the .exe filename
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

				fi                                                                                                                    
				# Compiling the code file as parameter
				elif [ "$e" = "cpp" ]
				then
				name=`basename $i '.cpp'` 
				if [ $exe_flag -eq 0 ] && [ $rep_flag -eq 0 ]
				then                                                                                                              
				# Getting the .exe filename
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
				fi                                                                                                                    
				# Compiling the code file as parameter
				elif [ "$e" = "f90" -o "$e" = "f95" -o "$e" = "F90" -o "$e" = "F" -o "$e" = "f03" -o "$e" = "F03" ]
				then
				e=".""$e"
				name=`basename $i $e`                                                                                                 
				# Getting the .exe filename
					if [ $exe_flag -eq 0 ] && [ $rep_flag -eq 0 ]
					then
						mpifort -o $name $i $lib_option || error
					elif [ $exe_flag -eq 1 ] && [ $rep_flag -eq 0 ]
					then
						mpifort -o $exe_name $i $lib_option || error
					elif [ $exe_flag -eq 0 ] && [ $rep_flag -eq 1 ]
					then	
						mpifort -o $relative_way$name $relative_way$i $lib_option || error
					elif [ $exe_flag -eq 1 ] && [ $rep_flag -eq 1 ]
					then
						mpifort -o $relative_way$exe_name $relative_way$i $lib_option || error
					fi
				# fi
				fi
			done
	elif [ $mode -eq 4 ]                                                                                                                          
	# Executing script profile in OpenMP parallel Compilation mode
	then
		for i in $param_list
		do
			if [ "$i" != "3" ]                                                                                            
			# Rebuilding the file name parameters list
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
		for i in $parameters
		do
			e=${i#*.}   
			if [ "$e" != "c" ] && [ "$e" != "cpp" ]  && [ "$e" != "f90" ] && [ "$e" != "f95" ]&& [ "$e" != "F90" ]&& [ "$e" != "F" ] && [ "$e" != "f03" ] && [ "$e" != "F03" ] 2> /dev/null
			then
				e=${i#*.*.}
			fi                                                                                                    
			# Getting the file extension
			while [ "$e" != "c" ] && [ "$e" != "cpp" ]  && [ "$e" != "f90" ] && [ "$e" != "f95" ]&& [ "$e" != "F90" ]&& [ "$e" != "F" ] && [ "$e" != "f03" ] && [ "$e" != "F03" ] 2> /dev/null
			# then
			do
			e=${i#*..*.} 
			done
			if [ $e = "c" ]
			then
			name=`basename $i '.c'`                                                                                               
			# Getting the .exe filename
			break
			elif [ "$e" = "cpp" ]
			then
			name=`basename $i '.cpp'`                                                                                             
			# Getting the .exe filename
			break
			fi
		done
		if [ $e = "c" ]
		then
			if [[ ! $lib = "" ]]
			then
				if [ $exe_flag -eq 0 ] &&  [ $rep_flag -eq 0 ]
				then
					gcc $parameters $lib -o $name -fopenmp $lib_option || gcc $lib -L $parameters -o $name -fopenmp || error
				elif [ $exe_flag -eq 1 ] && [ $rep_flag -eq 0 ]
					then
					gcc $parameters $lib -o $exe_name -fopenmp $lib_option || gcc $lib -L $parameters -o $exe_name -fopenmp || error
				elif [ $exe_flag -eq 0 ] && [ $rep_flag -eq 1 ]
					then
					gcc $parameters $lib -o $relative_way$name -fopenmp $lib_option || gcc $lib -L $parameters -o $relative_way$name -fopenmp || error	
				elif [ $exe_flag -eq 1 ] && [ $rep_flag -eq 1 ]
					then
					gcc $parameters $lib -o $relative_way$exe_name -fopenmp $lib_option || gcc $lib -L $parameters -o $relative_way$exe_name -fopenmp || error	
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
				fi                                                                                                        
			fi
		# Compiling the Modular file as parameters
		elif [ $e = "cpp" ]
		then
			if [[ ! $lib = "" ]]
			then
				if [ $exe_flag -eq 0 ] &&  [ $rep_flag -eq 0 ]
				then
					g++ $parameters $lib -o $name -fopenmp $lib_option || g++ $lib -L $parameters -o $name -fopenmp || error
				elif [ $exe_flag -eq 1 ] && [ $rep_flag -eq 0 ]
					then
					g++ $parameters $lib -o $exe_name -fopenmp $lib_option || g++ $lib -L $parameters -o $exe_name -fopenmp || error
				elif [ $exe_flag -eq 0 ] && [ $rep_flag -eq 1 ]
					then
					g++ $parameters $lib -o $relative_way$name -fopenmp $lib_option || g++ $lib -L $parameters -o $relative_way$name -fopenmp || error
				elif [ $exe_flag -eq 1 ] && [ $rep_flag -eq 1 ]
					then
					g++ $parameters $lib -o $relative_way$exe_name -fopenmp $lib_option || g++ $lib -L $parameters -o $relative_way$exe_name -fopenmp || error
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
					fi                                                                                                        
			fi
		# Compiling the Modular file as parameters
		elif [ "$e" = "f90" -o "$e" = "f95" -o "$e" = "F90" -o "$e" = "F" -o "$e" = "f03" -o "$e" = "F03" ]
		then
			for i in $parameters
			do
				e=${i#*.}
				if [ "$e" != "f90" ] && [ "$e" != "f95" ] && [ "$e" != "F90" ] && [ "$e" != "F" ] && [ "$e" != "f03" ] && [ "$e" != "F03" ]
				then
					e=${i#*.*.}
				fi
				e=".""$e"
				name=`basename $i $e`
				if [ $exe_flag -eq 0 ] && [ $rep_flag -eq 0 ]
				then
					gfortran -o $name $i $lib_option -fopenmp || error
				elif [ $exe_flag -eq 1 ] && [ $rep_flag -eq 0 ]
				then
					gfortran -o $exe_name $i $lib_option -fopenmp  || error
				elif [ $exe_flag -eq 0 ] && [ $rep_flag -eq 1 ]
				then	
					gfortran -o $relative_way$name $i $lib_option  -fopenmp || error
				elif [ $exe_flag -eq 1 ] && [ $rep_flag -eq 1 ]
				then
					gfortran -o $relative_way$exe_name $i $lib_option  -fopenmp || error
				fi
			done
	fi
	elif [ $mode -eq 5 ]                                                                                                                          
	#Executing script with librairies Linking mode
	then
		libs=""
		libflag="t"
		cflag="t"
		for i in $param_list
		do
			if [ "$i" != "4" ]                                                                                            
			# Rebuilding the file name parameters list
			then
				parameters=$parameters" "$i
			fi
		done
		for i in $parameters
		do
			e=${i#*.}                                                                                             
			# Getting the file extension
			if [ $e != "c" ] && [ $e != "cpp" ] && [ "$e" != "f90" ] && [ "$e" != "f95" ] && [ "$e" != "F90" ] && [ "$e" != "F" ] && [ "$e" != "f03" ] && [ "$e" != "F03" ]
			then
				e=${i#*.*.}  
			fi 
			if [ $e = "c" ]
			then
				name=`basename $i '.c'`                                                                                               
			# Getting the .exe filename
			cflag=$e
			elif [ "$e" = "cpp" ]
			then
				name=`basename $i '.cpp'`                                                                                             
			# Getting the .exe filename
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
			if [ "$libflag" = "o" ]                                                                                               
			# Script profile in case of Object Librairie
			then
				if [ $exe_flag -eq 0 ] && [ $rep_flag -eq 0 ]
				then
					gcc -o $tocompile $libs $lib_option  || error 
				elif [ $exe_flag -eq 1 ] && [ $rep_flag -eq 0 ]
					then
					gcc $tocompile $libs -o $exe_name $lib_option  || error  
				elif [ $exe_flag -eq 0 ] && [ $rep_flag -eq 1 ]
					then 
						gcc $relative_way$tocompile $libs $lib_option  || error 
				elif [ $exe_flag -eq 1 ] && [ $rep_flag -eq 1 ]
				then
					gcc $relative_way$tocompile $libs -o $relative_way$exe_name  $lib_option || error 
				fi                                                                                                        
			# Compiling the Modular Libs as parameters
			elif [ "$libflag" = "a" ]                                                                                             
			# Script profile in case of Static Librairie
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
			elif [ "$libflag" = "so" ]                                                                                            
			# Script profile in case of Dynamic Librairie
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
			if [ "$libflag" = "o" ]                                                                                               
			# Script profile in case of Object Librairie
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
				fi                                                                                                        
				# Compiling the Modular Libs as parameters
			elif [ "$libflag" = "a" ]                                                                                             
			# Script profile in case of Static Librairie
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
			elif [ "$libflag" = "so" ]                                                                                            
			#Script profile in case of Dynamic Librairie
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

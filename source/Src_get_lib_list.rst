Source Get_lib_list
===================

.. code-block:: bash

	#!/bin/bash

	# Author : CABOS Matthieu
	# Date : 31/08/2020

	lib_flag=0
	lib=""
	for i in $@                        
	# Coursing arguments list
	do
		if [ $lib_flag -eq 1 ]     
		# Getting lib name if founded
		then
			lib="$lib"" ""$i"
			((lib_flag=0))
		fi
		if [ "$i" = "#include" ]
		then
			((lib_flag=1))
		else
			((lib_flag=0))
		fi
	done
	for libp in $lib 
	do
		ind=0
		for i in $(seq 1 ${#libp})
		do 
			lettre=$(echo $libp | cut -c$i)
			if [ ! $ind -eq 0 ]
			then
				name_lib="$name_lib""$lettre"
			fi
			((ind=$ind+1))
		done
		name_lib=`basename $name_lib '.h>'`
		# name_lib="$name_lib"" "
		name_lib_final="$name_lib_final"" ""$name_lib"
		name_lib=""
	done
	for i in $name_lib_final
	do
		test=""
		test=`vcpkg search $i | grep "[0-9]"`
		if [ "$test" = "" ]
		then
			echo "###########################################################################################"
			echo "The librairy ""$i"" is not disponible on the Unix Server, please to install it manually."
			echo "###########################################################################################"
		else
			install_name="$install_name"" ""$i"
		fi
	done
	for i in $install_name
	do
		vcpkg install $i
	done
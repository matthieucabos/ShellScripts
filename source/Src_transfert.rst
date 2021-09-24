Source Transfert
================

.. code-block:: bash

	#!/bin/bash
	# Author : CABOS Matthieu
	# Date : 23/07/2020

	function usage(){
		echo"Please to refer Documentation."
	}

	param=$*
	ind=1
	files=""
	index=0
	home_flag_src=0
	home_flag_dst=0
	IP=0
	if [ $# -eq 0 ] || [ $# -ne 6 ] || [ $1 -gt 4 ] || [ $1 -le 0 ]
	then
		usage
		exit
	fi

	if [ "$1" = "--help" ]
	then
		usage
		exit
	fi

	for i in $param
	do
		if [ $ind -eq 1 ]
		then
			mode=$i
		elif [ $ind -eq 2 ]
		then
			user=$i 
		elif [ $ind -eq 3 ]
		then
			if [ $i = ~ ]
			then
				home_flag_src=1
			fi
			source=$i
		elif [ $ind -eq 4 ]
		then
			if [ $i = ~ ]
			then
				home_flag_dst=1
			fi
			dest=$i
		elif [ $ind -eq 5 ]
		then
			files="$i"
		else
			IP="$i"
		fi
		ind=$((ind+1))
	done


	source_way=$source
	dest_way=$dest


	# Xchange source and dest when Mode
	if [ $mode -eq 1 -o $mode -eq 3 ] 
	then
		if [ $home_flag_src -eq 1 ]
		then
			source_way="/home/$USER"
		fi
		if [ $home_flag_dst -eq 1 ]
		then
			dest_way="/users/$user"
		fi
	else
		if [ $home_flag_src -eq 1 ]
		then
			source_way="/users/$user"
		fi
		if [ $home_flag_dst -eq 1 ]
		then
			dest_way="/home/$USER"
		fi
	fi

	source_way=$source_way"/"
	dest_way=$dest_way"/"

	if [ $mode -eq 1 ]
	then
		if [ `echo $dest_way | grep "home/" ` != "" ] 2> /dev/null
		then
			dest_way=`echo $dest_way | sed -e "s|/home/$USER|/users/$user|g"`
		fi
		scp $source_way$files $user@$IP:$dest_way
	elif [ $mode -eq 2 ]
	then
		if [ `echo $source_way | grep "home/"` != "" ] 2> /dev/null
		then
			source_way=`echo $source_way | sed -e "s|/home/$USER/|/users/$user/|g"`
		fi
		scp $user@$IP:$source_way$files $dest_way
	elif [ $mode -eq 3 ]
	then
		if [ `echo $dest_way | grep "home/"` != "" ] 2> /dev/null
		then
			dest_way=`echo $dest_way | sed -e "s|/home/$USER|/users/$user|g"`
		fi
		scp -r $source_way$files $user@$IP:$dest_way
	elif [ $mode -eq 4 ]
	then
		if [ `echo $source_way | grep "home/"` != "" ] 2> /dev/null
		then
			source_way=`echo $source_way | sed -e "s|/home/$USER/|/users/$user/|g"`
		fi
		scp -r $user@$IP:$source_way$files $dest_way
	fi
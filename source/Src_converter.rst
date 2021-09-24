Source Converter
================

.. code-block:: bash

	#!/bin/bash

	# Author : CABOS Matthieu
	# Date : 23/09/2021

	function usage(){
		echo " 
		Please to refer Documentation.
	"
	}

	if [ $# -eq 0 ] 
	then
		usage
		exit
	fi

	ind=1
	param=$*
	mode=0
	size=0

	for i in $param
	do
		if [ $ind -eq 1 ]
		then
			if [ "$(echo $i | grep "^[ [:digit:] ]*$")" ]
			then
				Resolution=$i 
			elif [ $i == "clean" ]
				then
				mode=1
				break
			fi
		elif [ $ind -eq 3 ]
		then
			size=$i
		fi
		ind=$((ind+1))
	done

	path="./"
	Folders=`find $2 -type d`

	for f in $Folders
	do
		liste=`ls $f`
		if [ $mode -eq 0 ]
		then
			for item in $liste
			do
				echo $f"/"$item
				if [ -f $f"/"$item ]
				then
					convert $f"/"$item -resize $size -density $Resolution $f"/resized"$item
				fi
			done
		else
			find . -type f -name 'resized*.jpg' -delete
		fi
		liste=""
		path="./"
	done
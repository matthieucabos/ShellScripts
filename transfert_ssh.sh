#!/bin/bash
# Author : CABOS Matthieu
# Date : 26/08/2020

function usage(){
	printf"
Please to use the script with the correct number of arguments :
./transfert.sh <mode> <user> <source folder> <destination folder> <filename/foldername>

Where :
* mode is the way to transfert between
	0 mean upload file to the ssh specified destination folder
	1 mean download file since the ssh specified source folder
	2 mean upload folder to the ssh specified destination folder
	3 mean download folder since the ssh specified source folder
* user is your standard user name on the ssh plateform
* source folder is the name of the source repertory
* destination foolder is the name of the destination repertory
* ip is the adress of the ssh server
* filename is the exact files name to transfert or the folder name to transfert
	"
}

param=$*
ind=1
files=""
for i in $param                                       # getting the parameters into variables
	do
		if [ $ind -eq 1 ]
		then
			mode=$i
		elif [ $ind -eq 2 ]
			then
				user=$i 
		elif [ $ind -eq 3 ]
			then
				source=$i
		elif [ $ind -eq 4 ]
			then
				dest=$i 
		elif [ $ind -eq 5 ]
			then
				ip=$i
		else
			files="$files"" $i"
		fi
		ind=$((ind+1))
	done
index=0


if [ $# -eq 0 ]                                       # Help procedure
	then
		usage
		exit
fi

if [ "$1" = "--help" ]                                # Help procedure
	then
		usage
		exit
fi


if [ $mode -eq 1 -o $mode -eq 3 ]                     # Xchange source and dest when Download Mode is on
	then
		tmp=$source
		source=$dest
		dest=$tmp
fi

source_way="."
dir=`find | grep "[^/.][A-Za-z0-9_]*$"`               # Getting the source repertory absolute way
for i in $dir
	do
		name="${i##*/}"
		if [ "$name" = "$source" ]
			then
				source_way=$i
		fi
	done

dir=`ssh $user@$ip 'find'`                            # Getting the Folders Architecture

dest_way="."
for i in $dir
	do
		name="${i##*/}"
		if [ "$name" = "$dest" ]
			then
				dest_way=$i
		fi
	done

if [ $mode -eq 0 ]                                    # Single File Transfert File Protocol
	then
		scp $files $user@$ip:$dest_way 
elif [ $mode -eq 1 ]
	then
		scp $user@$ip:./$files $source_way
elif [ $mode -eq 2 ]                                  # Folder Transfert Protocol
	then
		scp -r $files $user@$ip:$dest_way
elif [ $mode -eq 3 ]
	then
		scp -r $user@$ip:./$files $source_way
fi
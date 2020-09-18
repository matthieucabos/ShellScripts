#!/bin/bash
# Author : CABOS Matthieu
# Date : 23/07/2020

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
* source folder is the name of the source repertory (in your LOCAL computer)
* destination foolder is the name of the destination repertory (in your DISTANT computer)
* ip is the adress of the ssh server
* filename is the exact files name to transfert or the folder name to transfert
	"
}

param=$*
ind=1
files=""
index=0
ip=$6

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
				if [ ! "$i" = "~" ] && [ ! "$i" = "." ]
				then
					source=$i
				elif [ "$i" = "~" ]
				then
					source="/root/"
				elif [ "$i" = "." ]
				then
					source="./"
				fi
		elif [ $ind -eq 4 ]
			then
				if [ ! "$i" = "~" ] && [ ! "$i" = "." ]
				then
					dest=$i 
				elif [ "$i" = "~" ]
				then
					dest="/root/"
				elif [ "$i" = "." ]
				then
					dest="./"
				fi
		elif [ "$i" != "$ip" ]
			then
			files="$i"
		fi
		ind=$((ind+1))
	done


if [ $# -eq 0 ] || [ $# -ne 6 ] || [ $1 -gt 5 ]
	then
		usage
		exit
fi

if [ "$1" = "--help" ]
	then
		usage
		exit
fi

# Xchange source and dest when Mode
if [ $mode -eq 1 -o $mode -eq 3 ]
	then
		tmp=$source
		source=$dest
		dest=$tmp
fi

source_way=$source
dest_way=$dest

# source_way="."
# dir=`find | grep "[^/.][A-Za-z0-9_]*$"`   # Getting the source repertory absolute way
# for i in $dir
# 	do
# 		name="${i##*/}"
# 		if [ "$name" = "$source" ]
# 			then
# 				source_way=$i
# 		fi
# 	done

# dir=`ssh $user@194.57.114.202 'find'`      # Getting the Folders Architecture

# dest_way="."
# for i in $dir
# 	do
# 		name="${i##*/}"
# 		if [ "$name" = "$dest" ]
# 			then
# 				dest_way=$i
# 		fi
# 	done
files="$source_way"$files
if [ $mode -eq 0 ]
	then
		scp $files $user@$ip:$dest_way 
elif [ $mode -eq 1 ]
	then
		scp $user@$ip:$files $dest_way
elif [ $mode -eq 2 ]
	then
		scp -r $files $user@$ip:$dest_way
elif [ $mode -eq 3 ]
	then
		scp -r $user@$ip:$files $dest_way
fi
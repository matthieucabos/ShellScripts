#!/bin/bash
# Author : CABOS Matthieu
# Date : 23/07/2020

function usage(){
	printf"
Please to use the script with the correct number of arguments :
./transfert.sh <mode> <user> <source folder> <destination folder> <ip> <filename 1> <filename 2> ... <filename n>

Where :
* mode is the way to transfert between
	0 mean upload file to the ssh root directory
	1 mean download file since the ssh root directory
* user is your standard user name on the ssh plateform
* source folder is the name of the source repertory
* destination foolder is the name of the destination repertory
* ip is the adress of the ssh server
* filename is the exact files name to transfert
	"
}

param=$*
ind=1
files=""
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


if [ $# -eq 0 ]
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
if [ $mode -eq 1 ]
	then
		tmp=$source
		source=$dest
		dest=$tmp
fi

dir=`find | grep "[^/.][A-Za-z0-9_]*$"`   # Getting the source repertory absolute way
for i in $dir
	do
		name="${i##*/}"
		if [ "$name" = "$source" ]
			then
				source_way=$i
		fi
	done

dir=`ssh $user@$ip 'find'`      # Getting the Folders Architecture

for i in $dir
	do
		name="${i##*/}"
		if [ "$name" = "$dest" ]
			then
				dest_way=$i
		fi
	done

for i in $files
	do
		if [ $mode -eq 0 ]
			then
				file="$file"" ""$source_way""/""$i"
		elif [ $mode -eq 1 ]
			then
				file="$file"" ""$dest_way""/""$i"
		fi
	done

if [ $mode -eq 0 ]
	then
		# file="$source_way""/""$i"
		scp $file $user@$ip:$dest_way 
elif [ $mode -eq 1 ]
	then
		for i in $file
			do
				scp $user@$ip:./$i $source_way
			done
fi
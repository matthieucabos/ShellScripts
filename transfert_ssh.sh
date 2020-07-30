#!/bin/bash
# Author : CABOS Matthieu
# Date : 23/07/2020

function usage(){
	printf"
Please to use the script with the correct number of arguments :
./transfert.sh <mode> <filename> <user> <source folder> <destination folder> <ip>

Where :
* mode is the way to transfert between
	0 mean upload file to the ssh root directory
	1 mean download file since the ssh root directory
* filename is the exact file name to transfert
* user is your standard user name on the ssh plateform
* local folder is the source repertory
* destination folder is the destination repertory
* ip is the ssh adress to connect
	"
}

mode=$1
file=$2
user=$3
source=$4
dest=$5
IP=$6
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

dir=`ssh $user@$IP 'find'`      # Getting the Folders Architecture

for i in $dir
	do
		name="${i##*/}"
		if [ "$name" = "$dest" ]
			then
				dest_way=$i
		fi
	done


if [ $mode -eq 0 ]
	then
		file="$source_way""/""$file"
		echo $file
		scp $file $user@$IP:$dest_way
elif [ $mode -eq 1 ]
	then
		file="$dest_way""/""$file"
		scp $user@$IP:./$file $source_way
fi

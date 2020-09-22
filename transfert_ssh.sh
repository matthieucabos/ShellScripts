#!/bin/bash
# Author : CABOS Matthieu
# Date : 23/07/2020

function usage(){
	echo"
Please to use the script with the correct number of arguments :
./transfert.sh <mode> <user> <source folder> <destination folder> <filename/foldername> <ip>

Where :
* mode is the way to transfert between
	1 mean upload file to the ssh specified destination folder
	2 mean download file since the ssh specified source folder
	3 mean upload folder to the ssh specified destination folder
	4 mean download folder since the ssh specified source folder
* user is your standard user name on the ssh plateform
* Local folder is the name of the source repertory (in your LOCAL computer)
* Distant folder is the name of the destination repertory (in your DISTANT computer)
* filename is the exact files name to transfert or the folder name to transfert
* IP is the ip adress of the ssh passerel"
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
		elif [ $ind -eq 6 ]
			then
				IP=$i
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

source_way=$source_way"/"
dest_way=$dest_way"/"
echo $source_way
echo $dest_way

if [ $mode -eq 1 ]
	then
		scp $source_way $files $user@$IP:$dest_way
elif [ $mode -eq 2 ]
	then
		scp $user@$IP:$source_way$files $dest_way
elif [ $mode -eq 3 ]
	then
		scp -r $source_way$files $user@$IP:$dest_way
elif [ $mode -eq 4 ]
	then
		scp -r $user@$IP:$source_way$files $dest_way
fi
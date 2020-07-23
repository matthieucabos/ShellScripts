#!/bin/bash
# Author : CABOS Matthieu
# Date : 23/07/2020

function usage(){
	printf"
Please to use the script with the correct number of arguments :
./transfert.sh <mode> <filename> <user> <IP>

Where :
* mode is the way to transfert between
	0 mean upload file to the ssh root directory
	1 mean download file since the ssh root directory
* filename is the exact file name to transfert
* user is your standard user name on the ssh plateform
* IP is the adress of the ssh server.
	"
}

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

mode=$1
file=$2
user=$3
IP=$4

if [ $mode -eq 0 ]              # Executing script as uploader
	then
		scp $file $user@$IP:    # File transfert
elif [ $mode -eq 1 ]            # Executing script as downloader
	then
		scp $user@$IP:./$file . # File transfert
fi
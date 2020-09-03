#!/bin/bash

# Author : CABOS Matthieu
# Date : 03/09/2020

function usage(){
	printf"
Usage : ./cpu_count <user name> <ip adress>
"
}

function error(){
	printf"
An error has occured, please to report at matthieu.cabos@tse-fr.eu.
	"
}

if [ $# -ne 2 ]
then
	usage
	exit
fi

id_user=$1
ip_user=$2

rezz=`ssh $id_user@$ip_user 'cat /proc/cpuinfo | tail -26 | head -1 | cut -d ":" -f2'` || error
((rezz+=1))
echo "Le nombre de processeurs accessibles est :""$rezz"
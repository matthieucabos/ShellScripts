#!/bin/bash

# Author : CABOS Matthieu
# Date : 08/10/2021

Ip_switch=$1

snmpwalk -v 1 -c comaccess $Ip_switch:161 1.3.6.1.2.1.2.2.1.2 | grep "TenGigabitEthernet" > tmp
nb_lines=`wc -l tmp | cut -d " " -f1` 
count=1
res=''
echo "Les prises Gigabit Ethernet 10Gb du Cisco $Ip_switch sont : "
while [ $count -le $nb_lines ]
do
	test=`cat tmp | head -$count | tail -1 | grep -Po '\K[0-9]/[0-9]/[0-9]*'`
	echo $test
	count=$(( count + 1 ))
done
rm tmp
#!/bin/bash

# Author : CABOS Matthieu
# Date : 31/08/2020

lib_flag=0
lib=""
for i in $@
do
	if [ $lib_flag -eq 1 ]
	then
		lib=$i
		break
	fi
	if [ "$i" = "#include" ]
	then
		((lib_flag=1))
	fi
done

ind=0
for i in $(seq 1 ${#lib})
do 
	lettre=$(echo $lib | cut -c$i)
	if [ ! $ind -eq 0 ]
	then
		name_lib="$name_lib""$lettre"
	fi
	((ind=$ind+1))
done
name_lib=`basename $name_lib '.h>'`   
vcpkg search $name_lib
vcpkg install $name_lib
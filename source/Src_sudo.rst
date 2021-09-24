Source Sudo-upgrade-all
=======================

.. code-block:: bash

	#!/bin/bash

	# Author : CABOS Matthieu
	# Date : 31/08/2020

	rez=`apt list --upgradable`
	for i in $rez
	do
		libname=`echo $i | grep "/" `
		if [ ! "$libname" = "" ]
		then
			lib=`echo $i | cut -d "/" -f1`
			lib_final="$lib_final"" ""$lib"
			libname=""
		fi 
	done
	for i in $lib_final
	do
	apt upgrade $i
	done
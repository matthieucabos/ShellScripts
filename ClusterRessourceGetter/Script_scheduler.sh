#!/bin/bash

# Author : CABOS Matthieu
# Date : 08/09/2020

step_time=$1

while :
do
	python ClusterRessourceGetter.py || python3 ClusterRessourceGetter.py
	sleep $step_time
done
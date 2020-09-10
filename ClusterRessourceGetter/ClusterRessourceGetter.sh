#!/bin/bash

# Author : CABOS Matthieu
# Date : 09/09/2020

avaible_mem=`sinfo -o "%all" | tail -12 | cut -d "|" -f5`
total_mem=`sinfo -o "%all" | tail -12 | cut -d "|" -f10`
node_id=`sinfo -o "%all" | tail -12 | cut -d "|" -f11`
cpu_allocated=`sinfo -o "%all" | tail -12 | cut -d "|" -f23`
cpu_usage=`sinfo -o "%all" | tail -12 | cut -d "|" -f33`
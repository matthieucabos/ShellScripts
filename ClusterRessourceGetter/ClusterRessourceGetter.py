import os
import re

# Author : CABOS Matthieu
# Date : 10/09/2020

# Utility functions
def node_index(node):
	# Get node index as integer
	exp=re.compile('cn[0-9]*')
	_node=exp.match(node)
	return (int(_node[0][2:])-1)

def print_line(info,node,nb_nodes):
	# String Pattern Output Format
	return "FREE_MEMORY,NODE="+str(node)+" Value="+str(info[0])+" "+str(int(os.popen('date +%s').read())*1000000000)+"\n"+"CPU_ALLOC,NODE="+str(node)+" Value="+str(info[2])+" "+str(int(os.popen('date +%s').read())*1000000000)+"\n"+"CPU_USE,NODE="+str(node)+" Value="+str(info[3])+" "+str(int(os.popen('date +%s').read())*1000000000)+"\n"+"CPU_FREE,NODE="+str(node)+" Value="+str(info[4]-info[2])+" "+str(int(os.popen('date +%s').read())*1000000000)+"\n"

nodes=6

# getting raw values from sinfo-Cluster Getters
os.system('nodes='+str(nodes*2))

avaible_mem=os.popen('nodes='+str(nodes*2)+'; sinfo -o "%all" | tail -$nodes | cut -d "|" -f5')
total_mem=os.popen('nodes='+str(nodes*2)+'; sinfo -o "%all" | tail -$nodes | cut -d "|" -f10')
node_id=os.popen('nodes='+str(nodes*2)+'; sinfo -o "%all" | tail -$nodes | cut -d "|" -f11')
cpu_allocated=os.popen('nodes='+str(nodes*2)+'; sinfo -o "%all" | tail -$nodes | cut -d "|" -f23')
cpu_usage=os.popen('nodes='+str(nodes*2)+'; sinfo -o "%all" | tail -$nodes | cut -d "|" -f33')
total_cpu=os.popen('nodes='+str(nodes*2)+'; sinfo -o "%all" | tail -12 | cut -d "|" -f3')

# Initializing vars
av_mem=[]
tot_mem=[]
n_id=[]
cpu_al=[]
cpu_u=[]
node_list=[[0,0,0,0]]*6
tmp_mem=0
tmp_tot=0
tmp_cpused=0
tmp_cpu=0
tmp_tot_cpu=0
to_print=""
cpu_a=[]
tmp=0
tot_cpus=[]

# Formating values into Python interpreted types
for i in avaible_mem.readlines():
	av_mem.append(int(i))
for i in total_mem.readlines():
	tot_mem.append(int(i))
for i in node_id.readlines():
	n_id.append(str(i))
for i in cpu_allocated.readlines():
	cpu_al.append(i)
for i in cpu_usage.readlines():
	cpu_u.append(float(i))
for i in total_cpu.readlines():
	tot_cpus.append(int(i))

# Getting number of allocated CPUs
for i in cpu_al:
	for j in i:
		if (j!='/'):
			tmp*=10
			tmp+=int(j)
		else:
			break
	cpu_a.append(tmp)
	tmp=0
del cpu_al

# Formating values into list of list
for i in range(len(n_id)):
	tmp_mem=node_list[node_index(n_id[i])][0]
	tmp_tot=node_list[node_index(n_id[i])][1]
	tmp_cpused=node_list[node_index(n_id[i])][2]
	tmp_cpu=node_list[node_index(n_id[i])][3]
	tmp_tot_cpu=tot_cpus[i]
	tmp_mem=av_mem[i]
	tmp_tot=tot_mem[i]
	tmp_cpused=cpu_a[i]
	tmp_cpu=cpu_u[i]
	node_list[node_index(n_id[i])]=[tmp_mem,tmp_tot,tmp_cpused,tmp_cpu,tmp_tot_cpu]

# Formatting the standard output
for i in range(len(node_list)):
	to_print+=print_line(node_list[i],i+1,len(node_list))
print(to_print)
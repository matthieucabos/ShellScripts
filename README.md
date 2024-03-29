![](https://spinati.com/wp-content/uploads/2015/03/logo-cnrs.png)

# ShellScripts

Shell Scripts Collection

**Author** *CABOS Matthieu*

**Date**  *2020/2021*

**Organization** *INRAE-CNRS*

______________________________________________________________________________________________________

This repertory contains Utilitary Shell scripts.

The associated Documentation can be founded @ https://shell-scripts.readthedocs.io/en/latest/

The pdf Dcumentation file is contained in the repository.


******************************************************

## ClusterRessourceGetter

The ClusterRessourceGetter script has been writed on a CentOS administrated Cluster.

It allow to get raw values from the cluster using commands **sinfo** of the Slurm Administartion Language.

The informations stored are :
* **Memory Use** : The Random Access Memory in use
* **Total Memory** : The Total Random Access Memory Amount
* **Node ID** : The Node Identifier
* **Allocated CPU** : The Allocated part on the CPU
* **Usage CPU** : The CPU in Use
* **Total CPU** : The Total CPU Amount
	
Each of these informations are analysed and stored into differents fields to adapt them for a Graphical Representation. 

The Cluster Ressource Getter script is ruled by a scheduler called **Script_scheduler.sh** to use with the following syntax :

```bash
./Script_scheduler <Step Time>
```

Where **Step Time** is the step time between each sampled values (in seconds).

******************************************************

## compile.sh

### Script usage

This script has been developped to automate the compilation process.
It treat c, c++ and fortran source files. Compilation can be ruled with five modes :

* **1** : The **chain mode** realize a chain compilation mode : Each source file is 
compiled independantly from each other
* **2** : The **modular mode** realize a modular compilation using one main source file 
and the dependency modules and functions as source files.
* **3** : The **Mpi compilation mode** allow parallel compilation using Open Mpi
* **4** : The **Openmp compilation mode** allow parallel compilation using Open MP
* **5** : The **Librairies Linking Mode** allow modular compilation using Unix Librairies

This mode must be specified as argument.

The script take 2 types of arguments : 
* The first one determine the mode between 
	* **1** : *chain* 
	* **2** : *modular*
	* **3** : *mpi compilation*
	* **4** : *openmp compilation*
	* **5** : *Librairies linking mode*
	
* The others parameters are the source files to compile.

The source file must be .c, .cpp or fortran files. 

Others extensions files **WILL NOT BE TREATED**.

You have to use the correct syntaxe specifying the mode for each execution :

```bash
./compile.sh <mode> < source file 1> < source file 2> ... < source file n>
```
In case of modular compilation, please to keep this parameter structure :

```bash
./compile.sh <mode> <Main source file> <Module source file 1> <Module source file 2> ... <Module source file n>
```
### Options

* **-O** : 

In case of additionnal features like Librairies using an option like math.h or compilater directive
options as -lpthread, etc
It will act as enlarged compilater options directive.
Option(s) as following arguments (MUST be specified as the last parameters) :

```bash
./compile.sh mode < source file 1> < source file 2> ... < source file n> -O -lm ...
```

* **-l** :

In case of additionnal features like Object, Static or Dynamix Librairies use the -l option with
Librairies as following arguments (MUST be specified as the last parameters) :

```bash
./compile.sh <mode> < source file 1> < source file 2> ... < source file n> -l <lib_file1.so> <lib_file2.so> ... 
```

* **-L** : 

In case of additionnal features like Librairies using an option like math.h
Librairie's option(s) as following arguments (MUST be specified as the last parameters) :

```bash
./compile.sh <mode> < source file 1> < source file 2> ... < source file n> -L -lm
```

* **-o** : 

If specified you should give the executable the name you want as following argument :

```bash
./compile.sh <mode> < source file> -o <executable name>
```

* **-d** :

If the source file(s) are not in the current directory, the -d option should specified the directory to 
treat (-d /my_project_to_compile_directory/ as example)

```bash
./compile.sh <mode> < source file> -d < source file repertory relative way>
```

 Help is avaible using the **--help** or **-h** option
 
 ### Option priority order :
 
 ```bash
 -o < -d < -l < -L < -O
```
******************************************************

	
## converter.sh

This script is a Multiformats Pictures Converter wich allow to resize and change DPI for multilevel directories workspace.

### Script Usage

Please to use this script with the correct parameters :

 ```bash
./Converter.sh  <Resolution DPI>  <Folder>  <size>
```
Where :
* **Resolution** is a value between 72 and 500 DPI
* **Folder** is the name of the folder containing pictures
* **size** is the picture length in pixel. Must have form "800x600".

to convert all pictures with the specified DPI and size from given folder a root.

or 

 ```bash
./Converter.sh clean
```

to clean the workspace

This script act recursively and will resize all the pictures contained into sub-trees.

******************************************************

## cpu_count.sh

### Script Usage

Please to use this script with the correct number of arguments:

 ```bash
./cpu_count.sh <user> <ip>
```
This script give us the following information : the number of avaible Cpu on the distant ssh machine.

******************************************************

## get_lib_list.sh

### Script Usage


Please to use this script with the correct arguments.
This script analyse the results of a failed compilation and determine the name(s) of the missing librairie(s).

exemple:

 ```bash
./get_lib_list.sh `gcc < source file.c>`
```
******************************************************

## sudo-upgrade-all.sh

### Script Usage

Called without arguments like that : 

 ```bash
./sudo-upgrade-all.sh
```
This script is used to upgrade all the present binaries librairies on a Unix system.
Please to use **if and only if** the Unnix system use the *apt* command (see also sudo apt command in Linux Manual.

******************************************************

 ## transfert_ssh.sh
 
 ### Script Usage
 
 Please to use the script with the correct number of arguments :
 
```bash
./transfert.sh <mode> <user> < source folder> < destination folder> <filename or folder name> <IP>
```
Where :
* **mode** is the way to transfert between :
	* **1** mean upload file to the ssh root directory
	* **2** mean download file since the ssh root directory
	* **3** mean upload folder to the ssh specified destination folder
	* **4** mean download folder since the ssh specified source folder
* **user** is your standard user name on the ssh plateform
* **source_folder** is the name of the source repertory
* **destination folder** is the name of the destination repertory
* **filename** is the exact files name to transfert or the folder name to transfert
* **ip** is the adress of the ssh server

*****************************************************

## Support

For any Support request, lease to mail @ matthieu.cabos@tse-fr.eu

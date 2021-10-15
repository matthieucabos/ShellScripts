# compile.sh

**Author** : *CABOS Matthieu*

**Date** : *2020*

**Organisation** : *INRAE-CNRS*

************************************************************

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

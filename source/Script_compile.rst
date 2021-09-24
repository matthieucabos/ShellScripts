Script usage Compile
====================

| This script has been developped to automate the compilation process.
| It treat c, c++ and fortran source files. Compilation can be ruled with four modes :

	* The **chain mode** realize a chain compilation mode : Each source file is compiled independantly from each other
	* The **modular mode** realize a modular compilation using one main source file and the dependency modules and functions as source files.
	* The **Mpi compilation** mode allow parallel compilation using Open Mpi
	* The **Openmp compilation mode** allow parallel compilation using Open MP
	* The **Librairies Linking Mode** allow modular compilation using Unix Librairies

| This mode must be specified as argument.
| The script take 2 types of arguments : the first one determine the mode between 

	* **1** (chain)
	* **2** (modular)
	* **3** (mpi compilation)
	* **4** (openmp compilation)
	* **5** (Librairies linking mode)

| The others parameters are the source files to compile.
| The source file must be **.c**, **.cpp** or **fortran** files. 
| Others extensions files **WILL NOT BE TREATED**.

| You have to use the correct syntaxe specifying the mode for each execution :

*./compile.sh* **mode** **source file 1** **source file 2** ... **source file n**

| In case of modular compilation, please to keep this parameter structure :

*./compile.sh* **mode** **Main source file** **Module source file 1** **Module source file 2** ...

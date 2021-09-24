Options Compile
===============

* **-O** : In case of additionnal features like Librairies using an option like math.h or compilater directive options as -lpthread, etc... It will act as enlarged compilater options directive. Option(s) as following arguments (**MUST be specified as the last parameters**) : *./compile.sh* **mode** **source file 1** **source file 2** ... **source file n** **-O** **-lm** ...
* **-o** : If specified you should give the executable the name you want as following argument : *./compile.sh* **mode** **src_file** **-o** **executable name**
* **-d** : If the source file(s) are not in the current directory, the -d option should specified the directory to treat (-d /my_project_to_compile_directory/ as example) *./compile.sh* **mode** **src_file** **-d** **src_file_repertory_relative_path**
* **-I** : In case of additional libs, you may define the path of access header files using the syntax -I./path_to_include/ : *./compile.sh* **mode** **src_file** **-I** **/path_to_include/**
* **-L** : In case of additional libs, you may define the path of access lib files using the syntax -L./path_to_lib : *./compile.sh* **mode** **src_file** **-L/path_to_lib/**
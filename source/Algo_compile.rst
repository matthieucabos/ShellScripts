Algorithm Compile
=================

| This script has been wrote to automate the compilation process. It gather gcc, g++ and fortran for each version of them.
| It has been thinked as a multiplexer defining the differents branchs of the switch.
| Each branch correspond to a specific way to act (with options, wit a given name, etc).
| To understand it, I will explain the differents steps of the algorithm.
| The first switch is ruled by the mode parameter defining the compilation directives as chain, modular, mpi, openmp and lib associations compilation.
| Each af these branchs will be splitted into differents sections ruled by a main loop coursing parameters list :

	* We **read extension** and define differents flags used to get the correct path
	* For each extension we **split again the algorithm** using a switch for new falgs as :

		* **exe_flag** : It determine if the exe filename is specified or not
		* **rep_flag** : It determines if the repertory name is specified or not

	* Once the path determined by the differents flags, we **automate the compilation process** calling the right method, for example : 

		* *gcc* **$parameters** **$lib** **-o** **$name** **$lib_option** *||* *gcc* **$lib** **-L** **$parameters** **-o** **$name** *|| error* will give a compilation via variables substitution. The *||* allow to test the first command, goes to the second if failed and finally call the error method to get a print. The differents used variables in this example are :

			* **parameters** : is the source(s) file(s) to compile
			* **lib** : is the specified Librairie to link
			* **name** : is the specified Filename of the executable
			* **lib_option** : is the differents added librairies option 

Once the correct execute-path have been founded, the correct compilation call is applied.
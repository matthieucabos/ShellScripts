Algorithm get_lib_list
======================

| This algorithm has been wrote to manage Librairies missing notifications when compiling with gcc.
| 
| In a first step, I'm coursing arguments list (wich is the results of a failes compilation).
| In case of Librairie name founded, I update the lib variable and the Lib Flag to True.
| In a second step, for each founded librairies, I get the exact name of the librairy via the **basename** command.
| On the final loop, I try, for each librairy (from the exact name) to install it via the **vcpkg** command, if founded on server, It will install it, else it will give you the missing Librairies name.
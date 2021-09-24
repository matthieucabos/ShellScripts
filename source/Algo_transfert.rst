Algorithm Transfert
===================

This script has been thinked to manage ssh Files transfert from the existing ip & User id.
In fact, the command **scp** will be used from differents switches branchs :

	* **File upload** : Permit to upload a file to the specified ssh platform
	* **File download** : Permit to download a file to the specified ssh platform
	* **Folder upload** : Permit to upload a folder to the specified ssh platform
	* **Folder download** : Permit to download a folder to the specified ssh platform

These branchs are ruled by the parameter mode.

In the first step, we get variables informations since parameters values.
Once done, we update from infos, the differents flags and the defaults paths.
These updated fields will be used in the last part of the algorithm :
	
	* **Updating the path**
	* **Using the scp command** with the correct arguments to automate tranfert.

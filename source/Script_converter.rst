Script usage Converter
======================

Please to use this script with the correct parameters :

*./ResConverter.sh* **Resolution_DPI** **Folder** **size**

to convert all pictures with the specified DPI and size from given folder a root.

or 

*./ResConverter.sh* **clean**

to clean the workspace

Where :

	* **Resolution** is a value between 72 and 500 DPI
	* **Folder** is the name of the folder containing pictures
	* **size** is the picture length in pixel. Must have form "800x600".

This script act recursively and will resize all the pictures contained into sub-tree

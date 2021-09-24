Algorithm Converter
===================

| This script hase been wrote to treat large amount of picture data. It must be use as a resizer.
| It is ruled by parameters :

	* **Resolution** : Define the DPI resolution of the picture
	* **Folder** : Determine the root folder to treat
	* **size** : Determine the Picture size, must have form axb where a & b are integers (ex : 800x600)

| In a first step we get essentials informations since command parameters such as Resolution, size, etc.
| The mode is determine by the keyword *'clean'*, if not specified the algorithm resize all the pictures found in the folder and associated sub-tree, else it will remove all the resized pictures.
| To treat them, we get in the liste variable the list of sub-folders paths.
| We brownse each folders in a loop and convert each picture file to the specified size and resolution.
	
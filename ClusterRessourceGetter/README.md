## ClusterRessourceGetter

**Author** : *CABOS Matthieu*

**Date** : *2020*

**Organisation** : *INRAE-CNRS*

************************************************************

### Script usage

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

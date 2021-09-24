Algorithm Sudo-upgrade-all
==========================

I get the application list of the system from the *rez=`apt list --upgradable`* command.
Once done, I brownse the returned list to get the exact extensions and librairies name as list also.
In the final loop, I upgrade each extension from thier name and the *apt upgrade $i* command.
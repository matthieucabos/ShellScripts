#! /bin/sh
if [ $# -gt 2 ]
	then
	echo "Le nombre de paramètres est incorrect">&2;
	exit 1
fi

if [ ! -d "$1" -o ! -r "$1" -o  ! -x "$1" ]
	then
	echo "Le repertoire n'est pas valide">&2;
	exit 2
fi

echo "">finalAffich;

#la version pourrait etre amelioré en integrant les variables de type "11" "12" etc par des variables incrementales de boucle pour le traitement des gros repertoires.
#j'ai réalisé un script à capacité "limité" pour s'assurer de la finalité de l'algorithme.



ls -R $1|grep [A-Z]>tmp; 

#La boucle de traitement commence la
           
ls $1|grep "1">>finalAffich;
cat tmp|grep "^[A-Z]\_[A-Z]*1">tmp2;
cat tmp|grep "^[A-Z][A-Z]\_[A-Z]*1">tmp3;

x=`cat tmp2|grep "11"`;
cat tmp2|grep "11">>finalAffich;
cat tmp3|grep "$x">>finalAffich;

x=`cat tmp2|grep "12"`;
cat tmp2|grep "12">>finalAffich;
cat tmp3|grep "$x">>finalAffich;

x=`cat tmp2|grep "13"`;
cat tmp2|grep "13">>finalAffich;
cat tmp3|grep "$x">>finalAffich;

x=`cat tmp2|grep "14"`;
cat tmp2|grep "14">>finalAffich;
cat tmp3|grep "$x">>finalAffich;

#et finit la

ls $1|grep "2">>finalAffich;
cat tmp|grep "^[A-Z]\_[A-Z]*2">tmp2;
cat tmp|grep "^[A-Z][A-Z]\_[A-Z]*2">tmp3; 

x=`cat tmp2|grep "21"`;
cat tmp2|grep "21">>finalAffich;
cat tmp3|grep "$x">>finalAffich;

x=`cat tmp2|grep "22"`;
cat tmp2|grep "22">>finalAffich;
cat tmp3|grep "$x">>finalAffich;

x=`cat tmp2|grep "23"`;
cat tmp2|grep "23">>finalAffich;
cat tmp3|grep "$x">>finalAffich;

#fin de la deuxieme boucle
 
ls $1|grep "3">>finalAffich;
cat tmp|grep "^[A-Z]\_[A-Z]*3">tmp2;
cat tmp|grep "^[A-Z][A-Z]\_[A-Z]*3">tmp3;  

x=`cat tmp2|grep "31"`;
cat tmp2|grep "31">>finalAffich;
cat tmp3|grep "$x">>finalAffich;

x=`cat tmp2|grep "32"`;
cat tmp2|grep "32">>finalAffich;
cat tmp3|grep "$x">>finalAffich;

x=`cat tmp2|grep "33"`;
cat tmp2|grep "33">>finalAffich;
cat tmp3|grep "$x">>finalAffich;

#fin de la troisieme
 
ls $1|grep "4">>finalAffich;
cat tmp|grep "^[A-Z]\_[A-Z]*4">tmp2;
cat tmp|grep "^[A-Z][A-Z]\_[A-Z]*4">tmp3;  

x=`cat tmp2|grep "41"`;
cat tmp2|grep "41">>finalAffich;
cat tmp3|grep "$x">>finalAffich;

x=`cat tmp2|grep "42"`;
cat tmp2|grep "42">>finalAffich;
cat tmp3|grep "$x">>finalAffich;

x=`cat tmp2|grep "43"`;
cat tmp2|grep "43">>finalAffich;
cat tmp3|grep "$x">>finalAffich;

#fin de la quatrieme
#etc

echo $1;
sed -e 's/^[A-Z]\_/| +-/g' finalAffich|sed -e 's/^[A-Z][A-Z]\_/| | +-/g'|sed -e 's/^[A-Z]/+-F/g';


rm tmp;
rm tmp2;
rm tmp3;
rm finalAffich;
exit 0
		


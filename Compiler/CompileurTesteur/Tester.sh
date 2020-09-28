#!/bin/bash

# Author : CABOS Matthieu
# Date : 28/09/2020

function keypress(){
	echo "######################################################################"
	echo "press enter to continue"
	read -n 1
}
exe_name="exe_name"
mode=$1

if [ $mode -eq 1 ]
then
	files=`ls | grep ".*\.cpp$"`
elif [ $mode -eq 2 ]
then
	files=`ls | grep ".*\.c$"`
elif [ $mode -eq 3 ]
then
	files=`ls | grep ".*\.[fF]"`
fi
echo "Les fichiers utilisés pour le test sont répertoriés comme suit : "
for i in $files
do
	echo ""
	echo "  --"$i
done
echo ""
keypress
if [ $mode -eq 1 ]
	then
		echo "test mode 1 sans options"
		./compile.sh 1 main1.cpp
		echo "./compile.sh 1 main1.cpp"
		ls -rlt | grep ".*\.[cfFsh]" -v | cut -d " " -f9 || echo "Compilation Failed"
		keypress
		rm main1
		echo "test mode 1 option -o "
		./compile.sh 1 main1.cpp -o test_mode_1
		echo "./compile.sh 1 main1.cpp -o test_mode_1"
		ls -rlt | grep ".*\.[cfFsh]" -v | cut -d " " -f9 || echo "Compilation Failed"
		keypress
		rm test_mode_1
		echo "test mode 1 option -o -d"
		./compile.sh 1 main1.cpp -o test_mode_1 -d./RepertoireTest/
		echo "./compile.sh 1 main1.cpp -o test_mode_1 -d./RepertoireTest/"
		ls -rlt ./RepertoireTest/ | grep ".*\.[cfFsh]" -v | cut -d " " -f9 || echo "Compilation Failed"
		keypress
		rm ./RepertoireTest/test_mode_1
		echo "test mode 1 option -o -O"
		./compile.sh 1 main1_lm.cpp -o test_mode_1 -O -lm
		echo "./compile.sh 1 main1_lm.cpp -o test_mode_1 -O -lm"
		ls -rlt | grep ".*\.[cfFsh]" -v | cut -d " " -f9 || echo "Compilation Failed"
		keypress
		rm test_mode_1
		echo "test mode 2 sans options"
		./compile.sh 2 main.cpp sum.cpp
		echo "./compile.sh 2 main.cpp sum.cpp"
		ls -rlt | grep ".*\.[cfFsh]" -v | cut -d " " -f9 || echo "Compilation Failed"
		keypress
		rm main
		echo "test mode 2 option -o "
		./compile.sh 2 main.cpp sum.cpp -o test_mode_2
		echo "./compile.sh 2 main.cpp sum.cpp -o test_mode_2"
		ls -rlt | grep ".*\.[cfFsh]" -v | cut -d " " -f9 || echo "Compilation Failed"
		keypress
		rm test_mode_2
		echo "test mode 2 option -o -d"
		./compile.sh 2 main.cpp sum.cpp -o test_mode_2 -d./RepertoireTest/
		echo "./compile.sh 2 main.cpp sum.cpp -o test_mode_2 -d./RepertoireTest/"
		ls -rlt ./RepertoireTest/ | grep ".*\.[cfFsh]" -v | cut -d " " -f9 || echo "Compilation Failed"
		keypress
		rm ./RepertoireTest/test_mode_2
		echo "test mode 2 option -o -O"
		./compile.sh 2 main_lm.cpp sum.cpp -o test_mode_2 -O -lm
		echo "./compile.sh 2 main_lm.cpp sum.cpp -o test_mode_2 -O -lm"
		ls -rlt | grep ".*\.[cfFsh]" -v | cut -d " " -f9 || echo "Compilation Failed"
		keypress
		rm test_mode_2
		echo "test mode 3 sans options"
		./compile.sh 3 Test_Mpi.cpp
		echo "./compile.sh 3 Test_Mpi.cpp"
		ls -rlt | grep ".*\.[cfFsh]" -v | cut -d " " -f9 || echo "Compilation Failed"
		keypress
		rm Test_Mpi
		echo "test mode 3 option -o "
		./compile.sh 3 Test_Mpi.cpp -o test_mode_3
		echo "./compile.sh 3 Test_Mpi.cpp -o test_mode_3"
		ls -rlt | grep ".*\.[cfFsh]" -v | cut -d " " -f9 || echo "Compilation Failed"
		keypress
		rm test_mode_3
		echo "test mode 3 option -o -d"
		./compile.sh 3 Test_Mpi.cpp -o test_mode_3 -d./RepertoireTest/
		echo "./compile.sh 3 Test_Mpi.cpp -o test_mode_3 -d./RepertoireTest/"
		ls -rlt ./RepertoireTest/ | grep ".*\.[cfFsh]" -v | cut -d " " -f9 || echo "Compilation Failed"
		keypress
		rm ./RepertoireTest/test_mode_3
		echo "test mode 3 option -o -O"
		./compile.sh 3 Test_Mpi_lm.cpp -o test_mode_3 -O -lm
		echo "./compile.sh 3 Test_Mpi_lm.cpp -o test_mode_3 -O -lm"
		ls -rlt | grep ".*\.[cfFsh]" -v | cut -d " " -f9 || echo "Compilation Failed"
		keypress
		rm test_mode_3
		echo "test mode 4 sans options"
		./compile.sh 4 testomp.cpp
		echo "./compile.sh 4 testomp.cpp"
		ls -rlt | grep ".*\.[cfFsh]" -v | cut -d " " -f9 || echo "Compilation Failed"
		keypress
		rm testomp
		echo "test mode 4 option -o "
		./compile.sh 4 testomp.cpp -o test_mode_4
		echo "./compile.sh 4 testomp.cpp -o test_mode_4"
		ls -rlt | grep ".*\.[cfFsh]" -v | cut -d " " -f9 || echo "Compilation Failed"
		keypress
		rm test_mode_4
		echo "test mode 4 option -o -d"
		./compile.sh 4 testomp.cpp -o test_mode_4 -d./RepertoireTest/
		echo "./compile.sh 4 testomp.cpp -o test_mode_4 -d./RepertoireTest/"
		ls -rlt ./RepertoireTest/ | grep ".*\.[cfFsh]" -v | cut -d " " -f9 || echo "Compilation Failed"
		keypress
		rm ./RepertoireTest/test_mode_4
		echo "test mode 4 option -o -O"
		./compile.sh 4 testomp_lm.cpp -o test_mode_4 -O -lm
		echo "./compile.sh 4 testomp_lm.cpp -o test_mode_4 -O -lm"
		ls -rlt | grep ".*\.[cfFsh]" -v | cut -d " " -f9 || echo "Compilation Failed"
		keypress 
		rm test_mode_4

elif [ $mode -eq 2 ]
	then
		echo "test mode 1 sans options"
		./compile.sh 1 main1.c
		echo "./compile.sh 1 main1.c"
		ls -rlt | grep ".*\.[cfFsh]" -v | cut -d " " -f9 || echo "Compilation Failed"
		keypress
		rm main1
		echo "test mode 1 option -o "
		./compile.sh 1 main1.c -o test_mode_1
		echo "./compile.sh 1 main1.c -o test_mode_1"
		ls -rlt | grep ".*\.[cfFsh]" -v | cut -d " " -f9 || echo "Compilation Failed"
		keypress
		rm test_mode_1
		echo "test mode 1 option -o -d"
		./compile.sh 1 main1.c -o test_mode_1 -d./RepertoireTest/
		echo "./compile.sh 1 main1.c -o test_mode_1 -d./RepertoireTest/"
		ls -rlt ./RepertoireTest/ | grep ".*\.[cfFsh]" -v | cut -d " " -f9 || echo "Compilation Failed"
		keypress
		rm ./RepertoireTest/test_mode_1
		echo "test mode 1 option -o -O"
		./compile.sh 1 main1_lm.c -o test_mode_1 -O -lm
		echo "./compile.sh 1 main1_lm.c -o test_mode_1 -O -lm"
		ls -rlt | grep ".*\.[cfFsh]" -v | cut -d " " -f9 || echo "Compilation Failed"
		keypress
		rm test_mode_1
		echo "test mode 2 sans options"
		./compile.sh 2 main.c sum.c
		echo "./compile.sh 2 main.c sum.c"
		ls -rlt | grep ".*\.[cfFsh]" -v | cut -d " " -f9 || echo "Compilation Failed"
		keypress
		rm main
		echo "test mode 2 option -o "
		./compile.sh 2 main.c sum.c -o test_mode_2
		echo "./compile.sh 2 main.c sum.c -o test_mode_2"
		ls -rlt | grep ".*\.[cfFsh]" -v | cut -d " " -f9 || echo "Compilation Failed"
		keypress
		rm test_mode_2
		echo "test mode 2 option -o -d"
		./compile.sh 2 main.c sum.c -o test_mode_2 -d./RepertoireTest/
		echo "./compile.sh 2 main.c sum.c -o test_mode_2 -d./RepertoireTest/"
		ls -rlt ./RepertoireTest/ | grep ".*\.[cfFsh]" -v | cut -d " " -f9 || echo "Compilation Failed"
		keypress
		rm ./RepertoireTest/test_mode_2
		echo "test mode 2 option -o -O"
		./compile.sh 2 main_lm.c sum.c -o test_mode_2 -O -lm
		echo "./compile.sh 2 main_lm.c sum.c -o test_mode_2 -O -lm"
		ls -rlt | grep ".*\.[cfFsh]" -v | cut -d " " -f9 || echo "Compilation Failed"
		keypress
		rm test_mode_2
		echo "test mode 3 sans options"
		./compile.sh 3 Test_Mpi.c
		echo "./compile.sh 3 Test_Mpi.c"
		ls -rlt | grep ".*\.[cfFsh]" -v | cut -d " " -f9 || echo "Compilation Failed"
		keypress
		rm Test_Mpi
		echo "test mode 3 option -o "
		./compile.sh 3 Test_Mpi.c -o test_mode_3
		echo "./compile.sh 3 Test_Mpi.c -o test_mode_3"
		ls -rlt | grep ".*\.[cfFsh]" -v | cut -d " " -f9 || echo "Compilation Failed"
		keypress
		rm test_mode_3
		echo "test mode 3 option -o -d"
		./compile.sh 3 Test_Mpi.c -o test_mode_3 -d./RepertoireTest/
		echo "./compile.sh 3 Test_Mpi.c -o test_mode_3 -d./RepertoireTest/"
		ls -rlt ./RepertoireTest/ | grep ".*\.[cfFsh]" -v | cut -d " " -f9 || echo "Compilation Failed"
		keypress
		rm ./RepertoireTest/test_mode_3
		echo "test mode 3 option -o -O"
		./compile.sh 3 Test_Mpi_lm.c -o test_mode_3 -O -lm
		echo "./compile.sh 3 Test_Mpi_lm.c -o test_mode_3 -O -lm"
		ls -rlt | grep ".*\.[cfFsh]" -v | cut -d " " -f9 || echo "Compilation Failed"
		keypress
		rm test_mode_3
		echo "test mode 4 sans options"
		./compile.sh 4 testomp.c
		echo "./compile.sh 4 testomp.c"
		ls -rlt | grep ".*\.[cfFsh]" -v | cut -d " " -f9 || echo "Compilation Failed"
		keypress
		rm testomp
		echo "test mode 4 option -o "
		./compile.sh 4 testomp.c -o test_mode_4
		echo "./compile.sh 4 testomp.c -o test_mode_4"
		ls -rlt | grep ".*\.[cfFsh]" -v | cut -d " " -f9 || echo "Compilation Failed"
		keypress
		rm test_mode_4
		echo "test mode 4 option -o -d"
		./compile.sh 4 testomp.c -o test_mode_4 -d./RepertoireTest/
		echo "./compile.sh 4 testomp.c -o test_mode_4 -d./RepertoireTest/"
		ls -rlt ./RepertoireTest/ | grep ".*\.[cfFsh]" -v | cut -d " " -f9 || echo "Compilation Failed"
		keypress
		rm ./RepertoireTest/test_mode_4
		echo "test mode 4 option -o -O"
		./compile.sh 4 testomp_lm.c -o test_mode_4 -O -lm
		echo "./compile.sh 4 testomp_lm.c -o test_mode_4 -O -lm"
		ls -rlt | grep ".*\.[cfFsh]" -v | cut -d " " -f9 || echo "Compilation Failed"
		keypress 
		rm test_mode_4

elif [ $mode -eq 3 ]
	then
		echo "test mode 1 sans options"
		./compile.sh 1 hello.f90
		echo "./compile.sh 1 hello.f90"
		ls -rlt | grep ".*\.[cfFsh]" -v | cut -d " " -f9 || echo "Compilation Failed"
		keypress
		rm hello
		echo "test mode 1 option -o "
		./compile.sh 1 hello2.f95 -o test_mode_1
		echo "./compile.sh 1 hello2.f95 -o test_mode_1"
		ls -rlt | grep ".*\.[cfFsh]" -v | cut -d " " -f9 || echo "Compilation Failed"
		keypress
		rm test_mode_1
		echo "test mode 1 option -o -d"     
		./compile.sh 1 hello3.F90 -o test_mode_1 -d./RepertoireTest/
		echo "./compile.sh 1 hello3.F90 -o ./RepertoireTest/test_mode_1 -d./RepertoireTest/"
		ls -rlt ./RepertoireTest/ | grep ".*\.[cfFsh]" -v | cut -d " " -f9 || echo "Compilation Failed"
		keypress
		rm ./RepertoireTest/test_mode_1
		echo "test mode 1 option -o -O"
		./compile.sh 1 hello2.f95 -o test_mode_1 -O -c
		echo "./compile.sh 1 hello2.f95 -o test_mode_1 -O -c"
		ls -rlt | grep ".*\.[cfFsh]" -v | cut -d " " -f9 || echo "Compilation Failed"
		keypress
		rm test_mode_1
		echo "test mode 2 sans options"
		./compile.sh 2 hello4.f03
		echo "./compile.sh 2 hello4.f03"
		ls -rlt | grep ".*\.[cfFsh]" -v | cut -d " " -f9 || echo "Compilation Failed"
		keypress
		rm hello4
		echo "test mode 2 option -o "
		./compile.sh 2 hello.f90 -o test_mode_2
		echo "./compile.sh 2 hello.f90 -o test_mode_2"
		ls -rlt | grep ".*\.[cfFsh]" -v | cut -d " " -f9 || echo "Compilation Failed"
		keypress
		rm test_mode_2
		echo "test mode 2 option -o -d"
		./compile.sh 2 hello4.f03 -o test_mode_2 -d./RepertoireTest/
		echo "./compile.sh 2 hello4.f03 -o ./RepertoireTest/test_mode_2 -d./RepertoireTest/"
		ls -rlt ./RepertoireTest/ | grep ".*\.[cfFsh]" -v | cut -d " " -f9 || echo "Compilation Failed"
		keypress
		rm ./RepertoireTest/test_mode_2
		echo "test mode 2 option -o -O"
		./compile.sh 2 hello3.F90 -o test_mode_2 -O -c
		echo "./compile.sh 2 hello3.F90 -o test_mode_2 -O -c"
		ls -rlt | grep ".*\.[cfFsh]" -v | cut -d " " -f9 || echo "Compilation Failed"
		keypress
		rm test_mode_2
		echo "test mode 3 sans options"
		./compile.sh 3 hello.f90
		echo "./compile.sh 3 hello.f90"
		ls -rlt | grep ".*\.[cfFsh]" -v | cut -d " " -f9 || echo "Compilation Failed"
		keypress
		rm hello
		echo "test mode 3 option -o "
		./compile.sh 3 hello2.f95 -o test_mode_3
		echo "./compile.sh 3 hello2.f95 -o test_mode_3"
		ls -rlt | grep ".*\.[cfFsh]" -v | cut -d " " -f9 || echo "Compilation Failed"
		keypress
		rm test_mode_3
		echo "test mode 3 option -o -d"
		./compile.sh 3 hello3.F90 -o test_mode_3 -d./RepertoireTest/
		echo "./compile.sh 3 hello3.F90 -o test_mode_3 -d./RepertoireTest/"
		ls -rlt ./RepertoireTest/ | grep ".*\.[cfFsh]" -v | cut -d " " -f9 || echo "Compilation Failed"
		keypress
		rm ./RepertoireTest/test_mode_3
		echo "test mode 3 option -o -O"
		./compile.sh 3 hello4.f03 -o test_mode_3 -O -c
		echo "./compile.sh 3 hello4.f03 -o test_mode_3 -O -c"
		ls -rlt | grep ".*\.[cfFsh]" -v | cut -d " " -f9 || echo "Compilation Failed"
		keypress
		rm test_mode_3
		echo "test mode 4 sans options"
		./compile.sh 4 hello.f90
		echo "./compile.sh 4 hello.f90"
		ls -rlt | grep ".*\.[cfFsh]" -v | cut -d " " -f9 || echo "Compilation Failed"
		keypress
		rm hello
		echo "test mode 4 option -o "
		./compile.sh 4 hello2.f95 -o test_mode_4
		echo "./compile.sh 4 hello2.f95 -o test_mode_4"
		ls -rlt | grep ".*\.[cfFsh]" -v | cut -d " " -f9 || echo "Compilation Failed"
		keypress
		rm test_mode_4
		echo "test mode 4 option -o -d"
		./compile.sh 4 hello3.F90 -o test_mode_4 -d./RepertoireTest/
		echo "./compile.sh 4 hello3.F90 -o test_mode_4 -d./RepertoireTest/"
		ls -rlt ./RepertoireTest/ | grep ".*\.[cfFsh]" -v | cut -d " " -f9 || echo "Compilation Failed"
		keypress
		rm ./RepertoireTest/test_mode_4
		echo "test mode 4 option -o -O"
		./compile.sh 4 hello4.f03 -o test_mode_4 -O -c
		echo "./compile.sh 4 hello4.f03 -o test_mode_4 -O -c"
		ls -rlt | grep ".*\.[cfFsh]" -v | cut -d " " -f9 || echo "Compilation Failed"
		keypress 
		rm test_mode_4
fi
exit



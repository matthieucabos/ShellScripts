#include <stdio.h>
#include <stdlib.h>
#include "math.h"

int main(){
	int n=20;
	int sum=0;
	printf("Je suis dans le main \n");
	for(int i=0;i<n;i++)
		sum+=i;
	printf("La somme des 20 premiers entiers est égale à %d \n",sum);
	printf("C'est le test 1\n");
	return 0;
}
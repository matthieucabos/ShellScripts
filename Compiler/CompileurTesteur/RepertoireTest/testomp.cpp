# include <stdio.h>
# include <stdlib.h>
# include "omp.h"

int main(){
	int val=0;
	int res=0;
	printf("Veuillez entrer une valeur entière :");
	scanf("%d",&val);
	#pragma omp for
	for(int i=0;i<val;i++)
		res+=i;
	printf("La somme des %d entiers est égale à %d",val,res);

	return 0;
}
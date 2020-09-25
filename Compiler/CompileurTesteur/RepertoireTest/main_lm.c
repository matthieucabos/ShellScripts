#ifndef SUM_H
#define SUM_H

#include <stdio.h>
#include <stdlib.h>
#include "sum.h"
#include "math.h"

int main(){
	int value=0;
	int res=0;

	printf("Veuillez entrer une valeure entière :\n");
	scanf("%d",&value);
	res=sum(value);
	printf("La somme des entiers jusqu'à %d est égale à %d",value,res);
	return 0;
}

#endif
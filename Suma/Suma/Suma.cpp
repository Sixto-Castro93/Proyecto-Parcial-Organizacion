// Suma.cpp: define el punto de entrada de la aplicación de consola.
//

#include <stdio.h>
#include "stdafx.h"
#include <stdlib.h>
#include <iostream>
#include <math.h>
#include <string.h> 

bool isNumber(char* cadena);
bool validarHex(char* hex);

int main(int argc, char* argv[])
{
	char numero[100];
	printf("Introduzca una cadena: ");
	gets(numero);
	if (validarHex(numero)){
		printf("Si es un numero HEX ");
	}
	else{
		printf("NO es un numero HEX ");
	}
	getchar();
	return 0;
}

bool isNumber(char* cadena)
{
	for (int i = 0; i<strlen(cadena); i++)
	{
		if (!(cadena[i] >= '0' && cadena[i] <= '9')) return false;
	}
	return true;
}

bool validarHex(char* hex){
	for (int i = 0; i<strlen(hex); i++)
	{
		if (!(hex[i] >= '0' && hex[i] <= '9') && !(hex[i] >= 'A' && hex[i] <= 'F') && !(hex[i] >= 'a' && hex[i] <= 'f'))
			return false;
	}
	return true;

}
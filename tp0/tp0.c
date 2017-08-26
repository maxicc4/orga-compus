#include <stdio.h>
#include <string.h>

// gcc -Wall -o tp0 tp0.c
// ./tp0 -i entrada.txt -o salida.txt
int main(int argc, char *argv[])
{
	int narg = 0;
	FILE *output = NULL;
	FILE *input = NULL;
	while ( narg < (argc-1) ) {
		narg++;
		if ( strcmp(argv[narg], "-i") == 0 ) {
			narg++;
			input = fopen(argv[narg], "r");
		} else if ( strcmp(argv[narg], "-o") == 0 ) {
			narg++;
			output = fopen(argv[narg], "a");
		} else {
			printf("No se reconoce la opcion:  %s\n", argv[narg]);
		}
	}
	if (output == NULL) {
		output = stdout;
	}
	if (input == NULL) {
		input = stdin;
	}

	/*
		ACA HAY QUE IR LEYENDO EN UN ARCHIVO Y ESCRIBIENDO EN EL OTRO
	*/
	fprintf(output, "%s", "Prueba\n");
 	
 	fclose (input);
 	fclose (output);

	return 0;
}

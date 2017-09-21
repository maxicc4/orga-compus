#include <stdio.h>
#include <stdbool.h>
#include <getopt.h>
#include <ctype.h>

#include "fileHandler.h"
#include "buff.h"

//Devuelve true si la palabra almacenada en buff es palindromo y false en caso contrario.
bool is_palindrome(char *buff, size_t len) {
	if (len == 0)
		return false;

	for (int i = 0; i < len / 2; ++i) {
		if (tolower(buff[i]) != tolower(buff[len - 1 - i]))
			return false;
	}

	return true;
}

//procesa el archivo input_file palabra por palabra y escribe los resultados en output_file.
int processFile(file_t * input_file, file_t * output_file) {
	buff_t buff;
	int status = init(&buff, BUFFER_INITIAL_SIZE);

	int size = 0;
	while (status == SUCCESS && !at_eof(input_file)) {
		size = read_word(input_file, &buff);
		if (size < 0)
			status = ERROR;
		else if (is_palindrome(get_buff(&buff), size))
			status = write_word(output_file, &buff, size);
	}

	destroy(&buff);
	return status;
}

void show_help_menu() {
	printf("%s", "Usage:\n\t"
			"tp0 -h\n\t"
			"tp0 -V\n\t"
			"tp0 [options]\n"
			"Options:\n\t"
			"-V, --version \tPrint version and quit.\n\t"
			"-h, --help \tPrint this information.\n\t"
			"-i, --input \tLocation of the input file.\n\t"
			"-o, --output \tLocation of the output file.\n"
			"Examples:\n\t"
			"tp0 -i ~/input -o ~/output\n");
}

int main(int argc, char *argv[]) {
  file_t input_file;
  file_t output_file;

  char* input_path = 0;
  char* output_path = 0;

  static struct option longOpts[] = {
  		{"version", 0, NULL, 'V'},
  		{"help", 0, NULL, 'h'},
  		{"input", 1, NULL, 'i'},
  		{"output", 1, NULL, 'o'},
  		{NULL, 0, NULL, 0}
  	};

  	int c;
  	int index = 0;
  	do {
  		c = getopt_long(argc, argv, "hVi:o:", longOpts, &index);

  		switch (c) {
  		case 'V':
  		    printf("%s","Palindrom Finder: v1.0\n");
  		    return SUCCESS;
  		case 'h':
  		    show_help_menu();
  		    return SUCCESS;
  		case 'i':
  			input_path = optarg;
  			break;
  		case 'o':
  			output_path = optarg;
  			break;
  		case '?':
  		    show_help_menu();
  		    return ERROR;
  		default:
  			break;
  		}
  	} while (c != -1);

  	int status = SUCCESS;

	if (status == SUCCESS && input_path && strcmp(input_path, "-") != 0)
		status = openFile(&input_file, input_path, "r");
	else
		input_file.file = stdin;

	if (status == SUCCESS && output_path && strcmp(output_path, "-") != 0)
		status = openFile(&output_file, output_path, "w");
	else
		output_file.file = stdout;

	if (status != ERROR)
		status = processFile(&input_file, &output_file);

	closeFile(&input_file);
	closeFile(&output_file);

	return status;
}

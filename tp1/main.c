#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>
#include <getopt.h>
#include <ctype.h>

#define ERROR -1
#define SUCCESS 0

//procesa el archivo input_file palabra por palabra y escribe los resultados en output_file.
extern int palindromes(int input_file_no, int output_file_no, size_t input_buf_size, size_t output_buf_size);

void show_help_menu() {
	printf("%s", "Usage:\n\t"
			"tp1 -h\n\t"
			"tp1 -V\n\t"
			"tp1 [options]\n"
			"Options:\n\t"
			"-V, --version \tPrint version and quit.\n\t"
			"-h, --help \tPrint this information.\n\t"
			"-i, --input \tLocation of the input file.\n\t"
			"-o, --output \tLocation of the output file.\n\t"
            "-I, --ibuf-bytes\t Byte-count of the input buffer.\n\t"
            "-O, --obuf-bytes\t Byte-count of the output buffer.\n\t"           
			"Examples:\n\t"
			"tp1 -i ~/input -o ~/output\n");
}

int openFile(FILE** file, const char *path, const char *mode) {
	*file = fopen(path, mode);
	if (*file == NULL) {
		perror("Error opening file");
		return ERROR;
	}
	return SUCCESS;
}

int closeFile(FILE* file) {
	if (file == NULL)
		return ERROR;

	if (fclose(file) == ERROR) {
		perror("ERROR closing file");
		return ERROR;
	}
	return SUCCESS;
}

int main(int argc, char *argv[]) {
  char* input_path = 0;
  char* output_path = 0;
  size_t input_buf_size = 1;
  size_t output_buf_size = 1;

  static struct option longOpts[] = {
  		{"version", 0, NULL, 'V'},
  		{"help", 0, NULL, 'h'},
  		{"input", 1, NULL, 'i'},
  		{"output", 1, NULL, 'o'},
        {"ibuf-bytes", 1, NULL, 'I'},
  		{"obuf-bytes", 1, NULL, 'O'},
  		{NULL, 0, NULL, 0}
  	};

  	int c;
  	int index = 0;
  	do {
  		c = getopt_long(argc, argv, "hVi:o:I:O:", longOpts, &index);

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
  		case 'I':
  			input_buf_size = strtoul(optarg, 0, 10);
            if (input_buf_size == 0) {
                fprintf(stderr, "Valor inválido para el parametro ibuf-bytes\n");
                return ERROR;
            }
  			break;
  		case 'O':
  			output_buf_size = strtoul(optarg, 0, 10);
            if (output_buf_size == 0) {
                fprintf(stderr, "Valor inválido para el parametro obuf-bytes\n");
                return ERROR;
            }
  			break;            
  		case '?':
  		    show_help_menu();
  		    return ERROR;
  		default:
  			break;
  		}
  	} while (c != -1);

  	int status = SUCCESS;
    
    FILE* input_file;
    FILE* output_file;

	if (status == SUCCESS && input_path && strcmp(input_path, "-") != 0)
		status = openFile(&input_file, input_path, "r");
	else
		input_file = stdin;

	if (status == SUCCESS && output_path && strcmp(output_path, "-") != 0)
		status = openFile(&output_file, output_path, "w");
	else
		output_file = stdout;

	if (status != ERROR)
		status = palindromes(fileno(input_file), fileno(output_file), input_buf_size, output_buf_size);

	closeFile(input_file);
	closeFile(output_file);

	return status;
}

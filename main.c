#include <stdio.h>
#include <stdbool.h>
#include <string.h>
#include "fileHandler.h"

//is_palindrome
//Devuelve true si la palabra almacenada en buff es palíndromo
//y false en caso contrario.
bool is_palindrome(char *buff) {
  size_t len;
  char firstHalfWord[BUFFER_SIZE / 2];
  char lastHalfWord[BUFFER_SIZE / 2];

  len = strlen(buff);
  if (len <= 1){
    return false;
  }
  for (int i = 0; i < len / 2; ++i) {
    firstHalfWord[i] = buff[i];
  }
  for (int i = 0; i < len / 2; ++i) {
    lastHalfWord[i] = buff[len - 1 - i];
  }
  if (!strncasecmp(&firstHalfWord[0], &lastHalfWord[0], len / 2)) {
    return true;
  }
  return false;
}

//processFile
//procesa el archivo input_file palabra por palabra y escribe
//los resultados en output_file.
//PRE: los archivos estan inicializados
int processFile(file_t * input_file, file_t * output_file){
  bool done = false;
  int s;
  char * buffer = (char*)malloc(sizeof(char)*BUFFER_SIZE);
  while (!done){
    memset(buffer, '\0', BUFFER_SIZE);
    s = read_word(input_file,buffer);
    if (s == ERROR){
      done = true;
    } else {
      if (is_palindrome(buffer)){
        fwrite(buffer,s,1,output_file->file);
        fputc('\n',output_file->file);
      }
    }
  }
  return SUCCESS;
}

void show_help_menu(){
  printf("%s","Usage:\n\t"
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
  bool input_path_found;
  bool output_path_found;
  int i,s;

  if (argc == 2 && (!strcmp(argv[1],"-h") || !strcmp(argv[1],"--help"))){
    show_help_menu();
    return SUCCESS;
  }
  if (argc == 2 && (!strcmp(argv[1],"-v") || !strcmp(argv[1],"--version"))){
    printf("%s","Palindrom Finder: v1.0\n");
    return SUCCESS;
  }

  input_path_found = false;
  i = 1;
  while (!input_path_found && i < argc){
    if (!strcmp(argv[i],"-i")){
      input_path_found = true;
    } else {
      i++;
    }
  }
  if (input_path_found && strcmp(argv[i+1],"-")){
    openFile(&input_file, argv[i+1], "r");
  } else {
    input_file.file = stdin;
  }

  output_path_found = false;
  i = 1;
  while (!output_path_found && i < argc){
    if (!strcmp(argv[i],"-o")){
      output_path_found= true;
    } else {
      i++;
    }
  }
  if (output_path_found && strcmp(argv[i+1],"-")){
    openFile(&output_file, argv[i+1], "w");
  } else {
    output_file.file = stdout;
  }

  s = processFile(&input_file, &output_file);
  closeFile(&input_file);
  closeFile(&output_file);
  return s;
}

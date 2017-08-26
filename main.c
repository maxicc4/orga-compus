#include <stdio.h>
#include <stdbool.h>
#include "fileHandler.h"

//is_palindrome
//Devuelve true si la palabra almacenada en buff es palíndromo
//y false en caso contrario.
bool is_palindrome(char *buff) {
  size_t len;
  char firstHalfWord[BUFFER_SIZE / 2];
  char lastHalfWord[BUFFER_SIZE / 2];

  len = strnlen(buff, BUFFER_SIZE);
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
}

int main(int argc, char *argv[]) {
  file_t input_file;
  file_t output_file;
  openFile(&input_file, "../archivo.txt", "r");
  openFile(&output_file, "../salida.txt", "w");
  processFile(&input_file, &output_file);
  closeFile(&input_file);
  closeFile(&output_file);
  return 0;
}
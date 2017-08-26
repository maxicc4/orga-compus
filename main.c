#include <stdio.h>
#include <stdbool.h>
#include "fileHandler.h"

bool is_palindrome(char *buff) {
  size_t len;
  char firstHalfWord[BUFFER_SIZE / 2];
  char lastHalfWord[BUFFER_SIZE / 2];

  len = strnlen(buff, BUFFER_SIZE);
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

int processFile(file_t * file){
  bool done = false;
  int s;
  char * buffer = (char)malloc(sizeof(char)*BUFFER_SIZE);
  while (!done){
    s = read_word(file,buffer);
    if (is_palindrome(buffer)){

    }
    memset(buffer, '\0', BUFFER_SIZE);
  }

}
int main(int argc, char *argv[]) {
  file_t file;
  openFile(&file, "archivo.txt", "r");
  return 0;
}
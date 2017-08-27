#include "fileHandler.h"

//openFile
//El fileDescriptor del archivo abierto se guarda en file_t self.
//Path indica el camino al archivo, mode el modo de apertura del archivo.
//Devuelve SUCCESS en caso de exito, ERROR en caso contrario.
int openFile(file_t *self, const char *path, const char *mode) {
  self->file = fopen(path, mode);
  if (self->file == NULL) {
    perror("Error opening file.\n");
    return ERROR;
  }
  return SUCCESS;
}

//closeFile
//Cierra el archivo. Devuelve SUCCESS en caso de exito, ERROR en caso contrario.
int closeFile(file_t *self) {
  int s;
  s = fclose(self->file);
  if (s == ERROR) {
    perror("In file fileHandler.c, function closeFile: ERROR closing file\n");
    return ERROR;
  }
  return SUCCESS;
}

//read_word (desde un archivo)
//Lee una palabra desde un archivo y lo almacena en el buffer
//Devuelve ERROR en caso de fin de archivo o error de lectura
//y en caso de exito devuelve el largo de la palabra.
int read_word(file_t *file, char *buff) {
  char c;
  bool isValid = true;
  unsigned short len = 0;

  while (isValid) {
    c = fgetc(file->file);
    if (c == EOF) {
      return ERROR;
    }
    if (charIsValid(c)) {
      buff[len] = c;
      len++;
    } else {
      isValid = false;
    }
  }
  return len;
}

//charIsValid
//Devuelve true si el caracter pertenece a los conjuntos
// {a-z} o {A-Z} o {-} o {_}, false en caso contrario.
bool charIsValid(char c) {
  return ((c <= 122 && c >= 97)
      || (c <= 90 && c >= 65)
      || (c >= 48 && c <= 57)
      || (c == 45)
      || (c == 95));
}


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

bool at_eof(file_t * file) {
	return feof(file->file) != 0;
}


//read_word (desde un archivo)
//Lee una palabra desde un archivo y lo almacena en el buffer
//y en caso de exito devuelve el largo de la palabra.
int read_word(file_t *file, char **buff, int *buffer_size) {
	char c;
	bool isValid = true;
	unsigned short len = 0;

	while (isValid) {
		c = fgetc(file->file);
		if (charIsValid(c)) {
			if (len == *buffer_size) {
				*buffer_size += BUFFER_CHUNK_SIZE;
				(*buff) = (char*) realloc(*buff, *buffer_size * sizeof(char));
			}
			(*buff)[len] = c;
			len++;
		} else {
			isValid = false;
		}
	}
	return len;
}

void write_word(file_t *file, char *buffer, int size) {
	fwrite(buffer, size, sizeof(char), file->file);
	fputc('\n', file->file);
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


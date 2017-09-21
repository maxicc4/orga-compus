#include "fileHandler.h"

//openFile
//El fileDescriptor del archivo abierto se guarda en file_t self.
//Path indica el camino al archivo, mode el modo de apertura del archivo.
//Devuelve SUCCESS en caso de exito, ERROR en caso contrario.
int openFile(file_t *self, const char *path, const char *mode) {
	self->file = fopen(path, mode);
	if (self->file == NULL) {
		perror("Error opening file");
		return ERROR;
	}
	return SUCCESS;
}

//closeFile
//Cierra el archivo. Devuelve SUCCESS en caso de exito, ERROR en caso contrario.
int closeFile(file_t *self) {
	if (self->file == NULL)
		return ERROR;

	if (fclose(self->file) == ERROR) {
		perror("ERROR closing file");
		return ERROR;
	}
	return SUCCESS;
}

bool at_eof(file_t * file) {
	return feof(file->file) != 0;
}

bool has_error(file_t * file) {
	return ferror(file->file) != 0;
}

//read_word (desde un archivo)
//Lee una palabra desde un archivo y lo almacena en el buffer
//y en caso de exito devuelve el largo de la palabra.
int read_word(file_t *file, buff_t *buff) {
	int c;
	bool isValid = true;
	unsigned int len = 0;

	while (isValid) {
		c = fgetc(file->file);

		if (has_error(file)) {
			perror("Error leyendo del archivo");
			return ERROR;
		}

		if (! at_eof(file) && charIsValid(c)) {
			if (put_char(buff, len++, c) == ERROR)
				return ERROR;
		} else {
			isValid = false;
		}
	}
	return len;
}

int write_word(file_t *file, buff_t *buff, int size) {
	if (fwrite(get_buff(buff), sizeof(char), size, file->file) == size)
		fputc('\n', file->file);

	if (ferror(file->file)) {
		perror("Error escribiendo en el archivo");
		return ERROR;
	}

	return SUCCESS;
}

//charIsValid
//Devuelve true si el caracter pertenece a los conjuntos
// {a-z} o {A-Z} o {-} o {_}, false en caso contrario.
bool charIsValid(int c) {
	return ((c <= 122 && c >= 97) || (c <= 90 && c >= 65)
			|| (c >= 48 && c <= 57) || (c == 45) || (c == 95));
}


#ifndef FILEHANDLER_H_
#define FILEHANDLER_H_

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <memory.h>
#include "flags.h"
#include "errno.h"

typedef struct {
  FILE *file;
} file_t;

bool charIsValid(char c);

int openFile(file_t *self, const char *path, const char *mode);

int closeFile(file_t *self);

int read_word(file_t *file, char **buff, int* buffer_size);

void write_word(file_t *file, char* buff, int size);

bool at_eof(file_t * file);

#endif /* FILEHANDLER_H_ */

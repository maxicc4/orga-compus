#ifndef FILEHANDLER_H_
#define FILEHANDLER_H_

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <memory.h>
#include "flags.h"
#include "errno.h"

#include "buff.h"

typedef struct {
  FILE *file;
} file_t;

bool charIsValid(int c);

int openFile(file_t *self, const char *path, const char *mode);

int closeFile(file_t *self);

bool at_eof(file_t * file);

bool has_error(file_t * file);

int read_word(file_t *file, buff_t* buff);

int write_word(file_t *file, buff_t* buff, int size);



#endif /* FILEHANDLER_H_ */

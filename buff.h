#ifndef BUFF_H_
#define BUFF_H_

#include <stdio.h>
#include <stdlib.h>

#include "flags.h"

typedef struct {
  char* buff;
  size_t size;
} buff_t;

int init(buff_t* buff, size_t size);

void destroy(buff_t* buff);

char* get_buff(buff_t* buff);

int put_char(buff_t* buff, size_t pos, char c);

#endif

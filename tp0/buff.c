#include "buff.h"

int init(buff_t* buff, size_t size) {
	buff->size = size;
	buff->buff = malloc(size);
	if (buff->buff == NULL) {
		fprintf(stderr, "Error reservando memoria");
		return ERROR;
	}
	return SUCCESS;
}

void destroy(buff_t* buff) {
	if (buff->buff != NULL)
		free(buff->buff);
}

char* get_buff(buff_t* buff) {
	return buff->buff;
}

int put_char(buff_t* buff, size_t pos, char c) {
	if (pos == buff->size) {
		size_t newSize = buff->size * 2;
		void* newBuff = realloc(buff->buff, newSize);
		if (newBuff == NULL) {
			fprintf(stderr, "Error reservando memoria");
			return ERROR;
		}

		buff->size = newSize;
		buff->buff = (char*) newBuff;
	}

	buff->buff[pos] = c;
	return SUCCESS;
}

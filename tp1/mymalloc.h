#ifndef _MYMALLOC_H_INCLUDED_
#define _MYMALLOC_H_INCLUDED_

extern void *mymalloc(size_t);
extern void myfree(void *);
extern void *myrealloc(void *, size_t, size_t);

#endif

#include <stdio.h>
#include <string.h>
#include <sys/types.h>
#include "mymalloc.h"

static char* text = "Copies the first num characters of source to destination. If the end of the source C string (which is signaled by a null-character) is found before num characters have been copied, destination is padded with zeros until a total of num characters have been written to it.";

int main(int argc, char * const argv[])
{
    char* s1 = (char*) mymalloc(100);
    strncpy(s1, text, 99);
    s1[99] = '\0';
    printf("%d %s\n", s1, s1);
        
    char* s2 = (char*) myrealloc(s1, 120);
    printf("%d %s\n", s2, s2);
    
    strncpy(s2, text, 119);
    s2[119] = '\0';
    printf("%d %s\n", s2, s2);
    
    myfree(s2);
    
	return 0;
}

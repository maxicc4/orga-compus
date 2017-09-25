#include <mips/regdef.h>
#include <sys/syscall.h>

#include "utils.h"
	  
# segmento de texto del programa
.text
.abicalls
.align 2


.globl	palindromes
.ent	palindromes
palindromes:
    FRAME(16)
    
    jal copyFile
 
	RETURN(16)
.end	palindromes

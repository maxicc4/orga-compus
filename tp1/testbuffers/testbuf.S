#include <mips/regdef.h>
#include <sys/syscall.h>

#include "../utils.h"
	  
# segmento de texto del programa
.text
.abicalls
.align 2

#copia del archivo de entrada al de salida usando buffers
.globl	copyFile
.ent	copyFile
copyFile:
    FRAME(48)
    
    jal initBuffers   
   	bltz v0, ret 
loop:	
    #leer caracter
    jal getch
    
    ##if (v0 >= 0) process char
    bgez v0, procch
    
    ## else if (! ateof) return error
    jal isEof
    
    bnez v0, retErr
    
    ## else return success
    li v0, SUCCESS
    b ret
    
procch:
    sw v0, 16(sp) #char

    lw a0, 16(sp)
    jal putch
    
    bltz v0, retErr
    j loop
retErr:
    li v0, ERROR
ret:
    sw v0, 20(sp) #status
    
    jal freeBuffers
    
    lw v0, 20(sp) #status

	RETURN(48)
.end	copyFile

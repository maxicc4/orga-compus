#include <mips/regdef.h>
#include <sys/syscall.h>

#include "utils.h"
	  
# segmento de texto del programa
.text
.abicalls
.align 2

#copia del archivo de entrada al de salida usando buffers
.globl	copyFile
.ent	copyFile
copyFile:
    FRAME(24)
    
    jal initBuffers   
   	bltz v0, ret 
loop:	
    #leer caracter
    jal getch
    
    ##if (v0 >= 0) process char
    bgez v0, procch
    
    ## else if (! ateof) return error
    la t0, ineof
    lw t0, 0(t0)
    
    bnez t0, retErr
    
    ## else return success
    li v0, SUCCESS
    b ret
    
procch:
    sw v0, 0(sp) #char

    lw a0, 0(sp)
    jal putch
    
    bltz v0, retErr
    j loop
retErr:
    li v0, ERROR
ret:
    sw v0, 4(sp) #status
    
    jal freeBuffers
    
    lw v0, 4(sp) #status

	RETURN(24)
.end	copyFile

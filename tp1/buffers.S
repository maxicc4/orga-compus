#include <mips/regdef.h>
#include <sys/syscall.h>

#include "utils.h"
	
.data
.align 2
    infile:      .word 0
    inbuf:       .word 0
    inbufsize:   .word 0
    inbufcur:    .word 0
    ineof:       .word 0
    
    outfile:     .word 0
    outbuf:      .word 0
    outbufsize:  .word 0
    outbufcur:   .word 0
    
.rdata
.align 2
    mallocError:	.ascii "Error resevando memoria\n"
    readError:      .ascii "Error de lectura\n"
    writeError:	    .ascii "Error de escritura\n"

#define mallocErrorLen 24
#define readErrorLen 17
#define writeErrorLen 19    
   
.text
.abicalls
.align 2

.globl	initBuffers
.ent	initBuffers
initBuffers:
    FRAME(16)

	# Salvo los parametros como globales
	sw	a0, infile
	sw	a1, outfile
	
	sw	a2, inbufsize
	sw	a2, inbufcur
	
	sw	a3, outbufsize
	sw	zero, outbufcur
	
	#crear buffer lectura
	lw a0, inbufsize
	la a1, inbuf
	jal buildbuf
	
	bltz v0, retInitBuffers 

	#crear buffer escritura
	lw a0, outbufsize
	la a1, outbuf
	jal buildbuf
	
retInitBuffers:
	RETURN(16)
.end    initBuffers


.globl	freeBuffers
.ent freeBuffers
freeBuffers:
    FRAME(16)

   #flush
    jal flushBuf
    
    #free inbuf
   	la t0, inbuf
   	lw a0, 0(t0)
    beqz a0, elif
   	
   	jal myfree
elif: 
   	#free outbuf
   	la t0, outbuf
   	lw a0, 0(t0)  	
   	beqz a0, else
   	
   	jal myfree
else:
	RETURN(16)
.end freeBuffers

.globl	getch
.ent getch
getch:
    FRAME(16)
       
    la t1, inbufsize
    lw t1, 0(t1)
    
    la t2, inbufcur
	lw t2, 0(t2)
    
    ##if(cur >= size)
    blt t2, t1, nextgch
    
    la t4, ineof
    lw t4, 0(t4)
    
    ##if (ateof) return ERROR
    bgtz t4, errgch
      
    #aLeer = inbufsize
    #cur = 0
    #do {
    #    v0 = read(infile, inbuf, aLeer)
    ##    if(error) 
    #       print error
    #       return -1
    #    aLeer -= v0
    #} while (v0 > 0 && aLeer > 0)

   	sw t1, 0(sp) #aLeer
  	la t2, inbufcur
   	sw zero, 0(t2)

gch_loop:
    #read(infile, inbuf, aLeer)
    la  t3, infile
    lw	a0, 0(t3)
    la a1, inbuf
    lw a1, 0(a1)
	lw a2, 0(sp)
	li	v0, SYS_read
	syscall

    ## if(a3 == 0)
    beqz a3, chkread

    #print error
    li  a0, 2
    la	a1, readError
	li	a2, readErrorLen
	li	v0, SYS_write
	syscall
	
	#return ERROR
    j errgch

chkread:   
    lw a2, 0(sp) #aLeer
    subu a2, a2, v0
    sw a2, 0(sp)
    
    bgtz v0, andKeepReading
    
    #v0 == 0 -> EOF
    li t0, 1
    la t1, ineof
    sw t0, 0(t1)

    #size -= aLeer
    la t2, inbufsize
    lw t3, 0(t2)

    subu t3, t3, a2
    sw t3, 0(t2)
    
    ##if(size > 0)
    bgtz t3, nextgch

    #return ERROR
    j errgch

andKeepReading:
    bgtz a2, gch_loop 
    
nextgch:
    la t0, inbuf
    lw t0, 0(t0)
    
    la t2, inbufcur
	lw t2, 0(t2)
    
    # v0 = *(inbuf + inbufcur)
    addu t3, t0, t2
    lbu v0, 0(t3)

    #cur++
    addiu t2, t2, 1
    la t1, inbufcur
    sw t2, 0(t1)
    
    j retgch

errgch:
    li v0, ERROR
    
retgch:
    RETURN(16)
          
.end getch


.globl putch
.ent putch
putch:
    FRAME(16)
       
    sw a0, 0(sp)

    la t1, outbufsize
    lw t1, 0(t1)
    
    la t2, outbufcur
    lw t2, 0(t2)
    
    ##if(cur >= size)
    blt t2, t1, nextpch
      
    jal flushBuf
    
    bltz v0, retpch
    
    la t2, outbufcur
    lw t2, 0(t2)
    
nextpch:
    la t0, outbuf
    lw t0, 0(t0)
    
    # *(outbuf `outbufcur) = a0
    lw a0, 0(sp)
    addu t3, t0, t2
    sb a0, 0(t3)

    #cur++
    addiu t2, t2, 1
    la t1, outbufcur
    sw t2, 0(t1)

retpch:
    RETURN(16)
          
.end putch

.globl isEof
.ent isEof
isEof:
    FRAME(8)
    
    la t0, ineof
    lw v0, 0(t0)
    
    RETURN(8)
.end isEof    


.ent flushBuf
flushBuf:
    FRAME(16)
    
    la t2, outbufcur
    lw t2, 0(t2)
    
    #aEscribir = outbufcur
    #do {
    #    v0 = write(outfile, outbuf, aEscribir)
    ##   if(error) 
    #       print error
    #       return -1
    #    aEscribir -= v0
    #} while (v0 > 0 && aEscribir > 0)

    sw t2, 0(sp) #aEscribir
    
write_do:
    #write(outfile, outbuf, aEscribir)
    la t3, outfile
    lw a0, 0(t3)
    la a1, outbuf
    lw a1, 0(a1)
    lw a2, 0(sp)
    li v0, SYS_write
    syscall
    
    ## if(a3 == 0)
    beqz a3, chkwrite

    #print error
    li  a0, 2
    la	a1, writeError
    li	a2, writeErrorLen
    li	v0, SYS_write
    syscall
	
    #return ERROR
    li v0, ERROR
    j retWB

chkwrite:   
    lw a2, 0(sp) #aEscribir
    subu a2, a2, v0
    sw a2, 0(sp)
    
    bgtz v0, andKeepWriting
    
    #return ERROR
    li v0, ERROR
    j retWB

andKeepWriting:
    bgtz a2, write_do 
    
    #outbufcur = 0
    la t2, outbufcur
    sw zero, 0(t2)
    
    li v0, SUCCESS
retWB:
    RETURN(16)
    
.end flushBuf


.ent buildbuf
buildbuf:
    FRAME(24)
    
    sw a1, 0(sp) #direccion
    sw a0, 4(sp) #tamano
    
    jal mymalloc
    
    lw a1, 0(sp)
    beqz v0, mallocErr
    
    sw v0, 0(a1)
    li v0, SUCCESS
    j retBB
    
mallocErr:
    #Imprimo mensaje de error
    li  a0, 2
    la	a1, mallocError
	li	a2, mallocErrorLen
	li	v0, SYS_write
	
	syscall
	
	lw a1, 0(sp)
    sw zero, 0(a1)
    li v0, ERROR

retBB:
    RETURN(24)
    
.end buildbuf


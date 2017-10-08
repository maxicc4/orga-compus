#include <mips/regdef.h>
#include <sys/syscall.h>

#include "utils.h"
	
/*
int infile, inbuf, inbufsize, inblufcur, ineof
int outfile, outbuf, outbufsize, outbufcur;
*/	
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

/*
inf initBuffers(int input_file_no, int output_file_no, size_t input_buf_size, size_t output_buf_size) {
    infile = input_file_no
    inbufsize = input_buf_size
    inbufcur = inbufsize

    outfile = output_file_no
    outbufsize = output_buf_size
    outbufcur = 0
    
    int status = buildbuf(inbufsize, &inbuf)
    if (status < 0)
        return status
        
    status = buildbuf(outbufsize, &outbuf)
    
    return status
}
*/
.globl	initBuffers
.ent	initBuffers
initBuffers:
    FRAME(32)

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
	RETURN(32)
.end    initBuffers

/*
void freeBuffers() {
    if (inbuf != 0)
        myfree(inbuf)
    
    if (outbuf != 0) {
        flushBuf()
        myfree(outbuf)
    }
}
*/
.globl	freeBuffers
.ent freeBuffers
freeBuffers:
    FRAME(32)

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
   	
    jal flushBuf
    
    la t0, outbuf
    lw a0, 0(t0)
   	jal myfree
else:
	RETURN(32)
.end freeBuffers

/*
int getch() {
    if (inbufcur >= inbufsize) {
        if (ineof)
            return ERROR

        inbufcur = 0        

        int leido = 0
        do {
            int v0 = read(infile, inbuf+leido, inbufsize - leido)
            if (error) {
                write(2, readError, readErrorLen)
                return ERROR
            }
            leido += v0
        } while (v0 > 0 && leido < inbufsize)        
        
        if (v0 == 0) {
            ineof = 1
            inbufsize = leido
            if (leido == 0)
                return ERROR
        }
    }
    
    char c = (char) *(inbuf + inbufcur++)
    return c
}
*/
.globl	getch
.ent getch
getch:
    FRAME(32)
       
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
      
  	la t2, inbufcur
   	sw zero, 0(t2)
   	
    sw zero, 16(sp) #leido

gch_loop:
    la t1, inbufsize
    lw t1, 0(t1)
    
    lw t2, 16(sp) #leido

    #read(infile, inbuf+leido, inbufsize-leido)
    la  a0, infile
    lw	a0, 0(a0)
    
    la a1, inbuf
    lw a1, 0(a1)
    addu a1, a1, t2
    
    move a2, t1
    subu a2, a2, t2
    
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
    lw a2, 16(sp) #leido
    addu a2, a2, v0
    sw a2, 16(sp)
    
    nop
    bgtz v0, andKeepReading
    nop
    
    #v0 == 0 -> EOF
    li t0, 1
    la t1, ineof
    sw t0, 0(t1)

    #size = leido
    la t2, inbufsize
    sw a2, 0(t2)

    ##if(size > 0)
    bgtz a2, nextgch

    #return ERROR
    j errgch

andKeepReading: #leido < inbufsize
    la t1, inbufsize
    lw t1, 0(t1)
    blt a2, t1, gch_loop 
    
nextgch:
    la t0, inbuf
    lw t0, 0(t0)
    
    la t1, inbufcur
	lw t2, 0(t1)
    
    # v0 = *(inbuf + inbufcur)
    addu t3, t0, t2
    lbu v0, 0(t3)

    #inbufcur++
    addiu t2, t2, 1
    la t1, inbufcur
    sw t2, 0(t1)
    
    j retgch

errgch:
    li v0, ERROR
    
retgch:
    RETURN(32)
          
.end getch

/*
int putch (char c) {   
    if (outbufcur >= outbufsize) {
        int status = flushBuf()
        if (status < 0)
            return ERROR
    }
    *(outbuf + outbufcur++) = c
    return SUCCESS
}
*/
.globl putch
.ent putch
putch:
    FRAME(32)
       
    sw a0, 16(sp)

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
    
    # *(outbuf + outbufcur) = a0
    lw a0, 16(sp)
    addu t3, t0, t2
    sb a0, 0(t3)

    #cur++
    addiu t2, t2, 1
    la t1, outbufcur
    sw t2, 0(t1)
    
    li v0, SUCCESS

retpch:
    RETURN(32)
.end putch

.globl isEof
.ent isEof
isEof:
    FRAME(8)
    
    la t0, ineof
    lw v0, 0(t0)
    
    RETURN(8)
.end isEof    

/*
int flushBuf() {
    if (outbuf != 0) {
        int escrito = 0;
        int v0;
        do {
            v0 = write(outfile, outbuf+escrito, outbufcur-escrito)
            if (error) {
                write(2, writeError, writeErrorLen)
                return ERROR
            }
            escrito += v0
        } while (v0 > 0 && escrito < outbufcur)
        
        outbufcur = 0
        return SUCCESS
    }
    return ERROR
}
*/
.ent flushBuf
flushBuf:
    FRAME(16)
    sw zero, 0(sp) #escrito  
    
write_do:
    lw t1, 0(sp) #escrito

    #write(outfile, outbuf+escrito, outbufcur-escrito)
    la a0, outfile
    lw a0, 0(a0)
    
    la a1, outbuf
    lw a1, 0(a1)
    addu a1, a1, t1
    
    la a2, outbufcur
    lw a2, 0(a2)
    subu a2, a2, t1
    
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
    j retFB

chkwrite:   
    lw t0, 0(sp) #escrito += v0
    addu t0, t0, v0
    sw t0, 0(sp)
    
    #v0 > 0
    bgtz v0, andKeepWriting
    
    #return ERROR
    li v0, ERROR
    j retFB

andKeepWriting:
    la t1, outbufcur
    lw t1, 0(t1)

    # escrito < outbufcur
    blt t0, t1, write_do 
    
    #outbufcur = 0
    la t1, outbufcur
    sw zero, 0(t1)
    
    li v0, SUCCESS  
retFB:
    RETURN(16)
    
.end flushBuf


/*
int buildbuf(size_t bufsize, void** buf) {
    void* v0 = mymalloc(bufsize)
    if (v0 == 0) {
        write(2, mallocError, mallocErrorLen);
        *buf = 0
        return ERROR
    }
    
    *buf = v0
    return SUCCESS
}
*/
.ent buildbuf
buildbuf:
    FRAME(40)
    
    sw a0, 16(sp) #tamaño
    sw a1, 20(sp) #direccion
    
    jal mymalloc
    
    lw a1, 20(sp)
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
	
	lw a1, 20(sp)
    sw zero, 0(a1)
    li v0, ERROR

retBB:
    RETURN(40)
    
.end buildbuf


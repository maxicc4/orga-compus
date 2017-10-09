#include <mips/regdef.h>
#include <sys/syscall.h>

#include "utils.h"

#define BUFFER_INITIAL_SIZE 32
	  
# segmento de texto del programa
.text
.abicalls
.align 2

#define PALINDROMES_STACK 48

#define BUFSIZE 16
#define BUFPTR 20
#define LEN 24
#define CHAR 28
#define STATUS 32

/*
int palindromes(int input_file_no, int output_file_no, size_t input_buf_size, size_t output_buf_size) {
    int status = initBuffers(input_file_no, output_file_no, input_buf_size, output_buf_size)
    
    if (status >= 0) {
        size_t bufsize = BUFFER_INITIAL_SIZE
        char* bufptr = (char*) mymalloc(bufsize)
        if (bufptr == 0) {
            write(2, memError, memErrorLen)
            status = ERROR
        } else {
            size_t length = 0
            while(true) {
                int ch = getch()
                
                if (ch < 0)
                    break
                
                if(isvalid(ch)) {
                    if (length == bufsize) {
                        bufSize *=2
                        void* newptr = myrealloc(bufptr, bufSize)
                        if (newptr == 0) {
                            write(2, memError, memErrorLen)
                            status = ERROR
                            break
                        } else
                            bufptr = (char*) newptr
                    }
                    
                    if (status >= 0) {
                        buf[length] = ch
                        length += 1
                    }
                } else {
                    status = checkWord(bufptr, length)
                    if (status < 0)
                        break;
                    
                    length = 0
                }
            }
            
            if (! isEof)
                status = ERROR
            else
                checkWord(bufptr, length)
        }
    }
    
    freeBuffers()
    
    if (bufptr != 0)
        free(bufptr)
    
    return status
}
*/
.globl	palindromes
.ent	palindromes
palindromes:
    FRAME(PALINDROMES_STACK)
    
  	sw zero, BUFPTR(sp) #bufPtr = 0
    
    #recibe los mismos parámetros que esta función
    jal initBuffers   
   	bltz v0, retErr 
   	
   	li t0, BUFFER_INITIAL_SIZE
   	sw t0, BUFSIZE(sp) #bufsize
   	
   	move a0, t0
   	jal mymalloc
   	
   	sw v0, BUFPTR(sp) #bufPtr
   	
   	## if (bufPtr == 0) return ERROR
   	bltz v0, pMemError 
   	
   	li t0, 0
   	sw t0, LEN(sp) #length
   	
loop:	
    #read char
    jal getch
    
    ##if (v0 < 0) break
    bltz v0, loopEnd
    
    sw v0, CHAR(sp) #char
    
    ##if(isvalid(c))
    move a0, v0
    jal charIsValid
    beqz v0, isSpace

    lw t0, BUFSIZE(sp) #bufSize
    lw t1, LEN(sp) #length

    ##if (length == bufSize)
    blt t1, t0, append
    
    sll t2, t0, 1 #bufSize *=2
    sw t2, BUFSIZE(sp)
    
    lw a0, BUFPTR(sp) #bufPtr
    move a1, t2 #newSize
    jal myrealloc
    
   	bltz v0, pMemError 
   	
   	sw v0, BUFPTR(sp) #bufptr
    
append: 
    #buf[len] = char
    lw t1, LEN(sp) #length
    lw t2, BUFPTR(sp) #bufPtr
    
    addu t0, t2, t1 #next char ptr
    
    lw a0, CHAR(sp) #char
    sb a0, 0(t0)
    
    #len++
    addiu t1, t1, 1
    sw t1, LEN(sp) #length
    
    j loop
    
    ##else (notvalid)
isSpace:    
    lw a0, BUFPTR(sp)    #bufptr
    lw a1, LEN(sp)    #length
    jal checkWord
    
    bltz v0, retErr
    
    #length = 0
    li t1, 0
    sw t1, LEN(sp) 
    
    j loop    
    
loopEnd:
    ## if (! isEof) return error
    jal isEof
    beqz v0, retErr
    
    #chequear si lo que quedo en el buffer es palindromo
    lw a0, BUFPTR(sp)    #bufptr
    lw a1, LEN(sp)    #length
    jal checkWord
    
    b cleanup
           
pMemError:
    #imprimir mensaje por stderr
    li  a0, 2
    la	a1, memError
	la	a2, memErrorLen
	lw  a2, 0(a2)
	li	v0, SYS_write
	syscall
    
retErr:
    li v0, ERROR
cleanup:
    sw v0, STATUS(sp) #status
        
    jal freeBuffers
    
    ##if (bufptr != 0) free(bufptr)
    lw a0, BUFPTR(sp) #bufPtr
    beqz a0, ret
    
    jal myfree   
ret:    
    lw v0, STATUS(sp) #status

	RETURN(PALINDROMES_STACK)
.end	palindromes


#define CHECK_WORD_STACK 32
#define INDEX 16
#define P_BUFPTR (CHECK_WORD_STACK)
#define P_LEN (CHECK_WORD_STACK+4)

/*
int checkWord(char* buf, size_t length) {
    int status
    if (len > 0) {
        if (is_palindrome(buf, length)) {
            for (int i = 0; i < length; i++) {
                char ch = buf[i]
                status = putch(ch)
                if (status < 0)
                    return status
            }
            status = putch('\n')
            if (status < 0)
                return status
        } else {
            status = 0
        }
    }
}
*/
.globl checkWord
.ent checkWord
checkWord:
    FRAME(CHECK_WORD_STACK)
    
    beqz a1, checkWordRet
    
    sw a0, P_BUFPTR(sp) #bufptr
    sw a1, P_LEN(sp) #length
    
    jal is_palindrome
    
    beqz v0, checkWordRet
    
    li t0, 0 
    sw t0, INDEX(sp) #i
    
for_loop:
    lw t0, INDEX(sp) #i

    lw t1, P_BUFPTR(sp) #bufptr
    addu t1, t1, t0 #bufptr+i

    lbu a0, 0(t1)
    jal putch
    
    bltz v0, checkWordRet
    
    #++i
    lw t1, INDEX(sp)
    addiu t1, t1, 1
    sw t1, INDEX(sp)

    lw t2, P_LEN(sp) # length
    
    blt t1, t2, for_loop
    
    li a0, 10 #\n
    jal putch
  
checkWordRet:    
    RETURN(CHECK_WORD_STACK)
.end checkWord

.rdata
.align 2
    memError:	  .ascii "Error resevando memoria\n"
    memErrorLen:  .word  24

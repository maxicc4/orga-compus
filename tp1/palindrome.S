#include <sys/syscall.h>
#include <mips/regdef.h>
#include "is_palindrome.S"
#include "getch.S"
#include "putch.S"
#include "mymalloc.S"

#ifndef
#define SZ 40 ##StackSize
#endif

        ##Es una funcion que no es hoja, invoca a otras funciones como is_palindrome

                    ##   |---------------|
                    ##   |////Padding////|
                    ##   |---------------|   >>>
                    ##   |      ra       |
                    ##   |---------------|
                    ##   |      gp       |      Saved Registers Area
                    ##   |---------------|
                    ##   |      fp       |
                    ##   |---------------|   <<<
                    ##   |               |
                    ##   |---------------|      LTA TODO: verificar tamaño cuando este el codigo
                    ##   |               |
                    ##   |---------------|   >>>
                    ##   |               |
                    ##   |---------------|
                    ##   |               |
                    ##   |---------------|      Argument Building Area
                    ##   |               |
                    ##   |---------------|
                    ##   |               |
                    ##   |---------------|   <<<
                    ##   |               |
                    ##   |---------------|
                    ##   |               |
                    ##   |---------------|
                    ##   |               |
                    ##   |---------------|
    .text
    .abicalls
    .align 2
    .globl palindrome
    .ent palindrome

palindrome:
    .frame
    .frame $fp,SZ,ra
    .set noreorder
    .cpload t9
    .set reorder
    subu sp,sp,SZ
    .cprestore 28 ##Numero harcodeado, calcular el numero adecuado para adonde guardar el gp
    sw $fp,24(sp)
    sw ra,32(sp)
    move $fp,sp
    sw a0,40(sp)    ##int ifd
    sw a1,44(sp)    ##size_t ibytes
    sw a2,48(sp)    ##int ofd
    sw a3,52(sp)    ##size_t obytes

    move a0,a1
    jal mymalloc
    beqz v0,failure
    #TODO store s0 word in LTA
    move s0,v0      ##s0 direccion al buffer de lectura de tamaño ibytes (minibuffer)

    #TODO store s2 word in LTA
    addiu s2,zero,10
    li a0,s2        ##s2 tamaño del buffer mayor que contendrá la palabra entera (buffer)
    jal mymalloc
    beqz v0,failure
    #TODO store s1 word in LTA
    move s1,v0      ##s1 direccion al buffer mayor que contendrá la palabra entera (buffer)


    addu t0,s0,zero    #t0 == minibufferCharIndex
    lw t2,44($fp)      #t2 == minibufferSize
BUFFERING:             ##almacenamiento en el buffer
    addu t1,s1,zero    #t1 == bufferCharIndex

WHILE:
        bne t0,t2,L1
        #TODO store t0,t1,t2 in LTA
        li a0,4
        move a1,s0
        jal getch
        #TODO restore t0,t1,t2 from LTA
L1:     lbu t3,t0
        #TODO store t0,t1,t2,t3 in LTA
        move a0,t3
        jal charIsValid
        #TODO restore t0,t1,t2,t3 from LTA
        beqz v0,EOW         ##if !charIsValid -> EndOfWhile
        sb t3,t1            ##else: store char in buffer
L2:     addiu t1,t1,1
        addiu t0,t0,1
        beq t1,t2,EXPAND
        b WHILE

EXPAND: sll s2,s2,1 ##bufferSize = bufferSize*2
        li a0,s2
        #TODO store t0,t1,t2,t3 in LTA
        jal mymalloc
        beqz v0,failureB ##free buffer anterior antes de destruir
        #TODO restore t0,t1,t2,t3 from LTA
MEMMOVE:move t4,s1  #guardo en t4 el puntero al buffer anterior
        move s1,v0  #actualizo s1 como puntero al nuevo buffer
        move t6,s1  #indice al buffer nuevo temporal
        addu t5,s1,zero #t5 como puntero temporal del buffer viejo
L2:     beq t1,t5,FREEBUFFER
        lb t7,t5
        sb t7,t6
        addiu t6,t6,1
        addiu t5,t5,1
        b L2
FREEBUFFER:
        #TODO store t0,t1,t2,t3,t4,t5,t6,t7
        move a0,t4
        jal myfree  #myfree(punteroABufferViejo)
        #TODO restore t0,t1,t2,t3,t4,t5,t6,t7
CLEAN:  move t1,t6  #actualizo el indice del buffer nuevo
        move t6,zero #de más, pero anulo los registros t4,t5,t6,t7
        move t4,zero
        move t5,zero
        move t7,zero
        b L2

EOW:
        #TODO store t0,t1,t2,t3
        ##bool is_palindrome(char *buff, size_t len)
        move a0,s1  ##a0 <- *buff
        move a1,t1  ##a1 <- len
        jal is_palindrome
        #TODO restore t0,t1,t2,t3
        beqz v0,BUFFERING

SHOW_PALINDROME:
        ##____ TODO ____

failure:
    move v0,zero ##TODO: ver los codigos de retorno, es re trucho esto

    #######PSEUDOCODIGO DE BUFFERING#######
    ##minibuffercharindex = 0;
    ##buffercharindex = 0;
    ##while (charIsValid){
    ##    if (minibuffercharindex == minibufferSize){
    ##        getch(4,minibuffer);
    ##        minibuffercharindex = 0;
    ##    }
    ##    getCharFromMiniBuffer();
    ##    if (charIsValid){
    ##        putcharinbuffer();
    ##
    ##    }
    ##    inc buffercharindex;
    ##   inc minibuffercharindex;
    ##    if (buffercharindex == bufferSize){
    ##        agrandarBuffer;
    ##    }
    ##}
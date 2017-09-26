#include <sys/syscall.h>
#include <mips/regdef.h>

    ##   |---------------|   Se trata de una funcion hoja, no invoca a ninguna otra
    ##   |    caller     |   Por eso el stack frame mide 8
    ## 8 |---------------|   >>>
    ##   |      gp       |
    ## 4 |---------------|       Saved Registers Area
    ##   |      fp       |
    ## 0 |---------------|   <<<


    ##//charIsValid
    ##//Devuelve true si el caracter pertenece a los conjuntos
    ##// {a-z} o {A-Z} o {-} o {_}, false en caso contrario.
    ##bool charIsValid(int c) {
    ##	return ((c <= 122 && c >= 97) || (c <= 90 && c >= 65)
    ##			|| (c <= 57 && c >= 48) || (c == 45) || (c == 95));
    ##}

	.text
    .abicalls
	.align 2
	.globl	charIsValid
	.ent	charIsValid

charIsValid:
    .frame $fp, 8, ra

    .set noreorder
    .cpload t9
    .set reorder
    subu sp, sp, 8
	.cprestore 4
    sw $fp,0(sp)

    move $fp,sp            ## trabajo con el frame pointer ahora

    ## guardo los argumentos en la ABA de la funcion llamante
    sw a0,8($fp)           ## int c

IF1:    li t1,122
        ble a0,t1,IF2
        b IF3

IF2:    li t1,97
        bge a0,t1,returnTrue

IF3:    li t1,90
        ble a0,t1,IF4
        b IF5

IF4:    li t1,65
        bge a0,t1,returnTrue

IF5:    li t1,57
        ble a0,t1,IF6
        b IF7

IF6:    li t1,48
        bge a0,t1,returnTrue

IF7:    li t1,45
        beq a0,t1,returnTrue

IF8:    li t1,95
        beq a0,t1,returnTrue
        b returnFalse

returnTrue:
    li v0,1
    b return
returnFalse:
    li v0,0
    b return

return:
    lw gp,4(sp)
    lw $fp,0(sp)
    addi sp,sp,8
    jr ra

.end charIsValid
    

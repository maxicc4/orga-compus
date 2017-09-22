#include <sys/syscall.h>
#include <mips/regdef.h>

                    ##   |---------------|   Se trata de una funcion hoja, no invoca a ninguna otra
                    ##   |    caller     |   Por eso el stack frame mide 8
                    ## 8 |---------------|   >>>
                    ##   |      gp       |
                    ## 4 |---------------|       Saved Registers Area
                    ##   |      fp       |
                    ## 0 |---------------|   <<<

	.text			## segmento de texto del programa
	                ## lo que sigue a continuacion son instrucciones
	                ## y tiene que ser parte del code segment

    .abicalls       ## le decimos al compilador que vamos a usar llamadas
                    ## respetando la ABI

	.align 2		## alineacion 2^2

	.globl	is_palindrome   ## damos a la funcion palindrome un scope global

	.ent	is_palindrome   ## el label palindrome es la direccion de la primera
	                        ## instrucción de la función

is_palindrome:
    .frame $fp, 8, ra

    .set noreorder
    .cpload t9
    .set reorder

    subu sp, sp, 8

	.cprestore 4		## inserta aqui "sw gp, 4(sp)",
	        			## mas "lw gp, 4(sp)" luego de cada jal.

    sw $fp,0(sp)

    move $fp,sp            ## trabajo con el frame pointer ahora

    ## guardo los argumentos en la ABA de la funcion llamante
    sw a0,8($fp)           ## char * buff
    sw a1,12($fp)          ## size_t len

    beqz a1,return_false   ## if len == 0

    li t0,0                ## i <=> t0, i = 0
    li t1,2
    div t2,a1,t1         ## t2 = len/2

    addiu t3,a1,-1         ## (len - 1)
L1: subu t3,t3,t0        ## (len - 1) - i
    addu t4,a0,t0        ## t4 = puntero a char x izquierda; t4 = buff + i
    addu t5,a0,t3        ## t5 = puntero a char x derecha; t5 = buff + [ len - 1 - i ]
    lb t6,0(t4)             ## t6 <=> buff[i]
    lb t7,0(t5)             ## t7 <=> buff[len - 1 - i]
    bne t6,t7,return_false
    addiu t0,t0,1
    bge t0,t2,return_true
    b L1

return_false:
    li v0, 0
    b return

return_true:
    li v0, 1
    b return

return:
    lw gp,4(sp)
    lw $fp,0(sp)
    addi sp,sp,8
    jr ra

    .end is_palindrome


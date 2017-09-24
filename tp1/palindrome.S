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
    move s0,v0      ##s0 direccion al buffer de lectura de tamaño ibytes

    li a0,10
    jal mymalloc
    beqz v0,failure
    move s1,v0      ##s1 direccion al buffer mayor que contendrá la palabra entera


buffering:          ##almacenamiento en el buffer




################################
    move s0,zero    ##s0 <=> direccion al buffer con la palabra
    addiu s1,s1,10  ##s1 <=> tamaño del buffer
    move s2,zero    ##s2 <=> tamaño de la palabra

    ##extern void *mymalloc(size_t);

    move a0,s1      ##preparo el argumento de mymalloc
    jal mymalloc
    beqz v0,failure
    move s0,v0      ##exito reservando memoria, muevo a s0 el valor devuelto
    lw a0,40(sp)    ##preparo int ifd como argumento 0
    lw a1,44(sp)    ##preparo size_t ibytes como argumento 1
    jal getch
    ##suponiendo que getch anduvo bien
    ##ahora tengo que verificar que
failure:
    move v0,zero ##TODO: ver los codigos de retorno, es re trucho esto


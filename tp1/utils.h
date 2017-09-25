#ifndef _UTILS_H_
#define _UTILS_H_

#define SUCCESS 0
#define ERROR -1

/* Macro para construir el stack de tamaño SS */
#define FRAME(SS) \
    .frame $fp, SS, ra; \
    .set noreorder; \
    .cpload t9; \
    .set reorder; \
    \
    subu sp, sp, SS; \
    .cprestore (SS-8); \
    sw $fp, (SS-4)(sp); \
    sw ra, (SS)(sp); \
    move $fp, sp 

/* Macro para destruir el stack de tamaño SS y saltar a $ra */
#define RETURN(SS) \
    lw	gp, (SS-8)(sp); \
	lw	$fp, (SS-4)(sp); \
	lw	ra, (SS)(sp); \
	addu	sp, sp, SS; \
	jr	ra

#endif

#ifndef _UTILS_H_
#define _UTILS_H_

#define SUCCESS 0
#define ERROR -1

/* Macro para construir el stack de tamano SS */
#define FRAME(SS) \
    .frame $fp, SS, ra; \
    .set noreorder; \
    .cpload t9; \
    .set reorder; \
    \
    subu sp, sp, SS; \
    .cprestore (SS-12); \
    sw $fp, (SS-8)(sp); \
    sw ra, (SS-4)(sp); \
    move $fp, sp ; \
    \
    sw a0, (SS)(sp); \
    sw a1, (SS+4)(sp); \
    sw a2, (SS+8)(sp); \
    sw a3, (SS+12)(sp)

/* Macro para destruir el stack de tamano SS y saltar a $ra */
#define RETURN(SS) \
    lw	gp, (SS-12)(sp); \
	lw	$fp, (SS-8)(sp); \
	lw	ra, (SS-4)(sp); \
	addu	sp, sp, SS; \
	jr	ra

#endif

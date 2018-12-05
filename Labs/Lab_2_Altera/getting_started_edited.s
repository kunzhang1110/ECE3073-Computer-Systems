/********************************************************************************
 * This program demonstrates use of parallel ports in the DE2 Basic Computer
 *
 * It performs the following: 
 * 	1. displays the SW switch values on the red LEDR
 * 	2. displays the KEY[3..1] pushbutton values on the green LEDG
 * 	3. displays a rotating pattern on the HEX displays
 * 	4. if KEY[3..1] is pressed, uses the SW switches as the pattern
********************************************************************************/
	.text									/* executable code follows */
	.global	_start
_start:

	/* initialize base addresses of parallel ports */
	movia		r2, 0x00005800		/* 8 bits PIO */
	movia		r3, 0x00005810		/* 1 bits PIO */
	movia      r4, 0x033			/* 8 bits PIO ON display */
	movia      r5, 0x01			/* 1 bits PIO ON display */

DO_DISPLAY:
	stwio		r4, 0(r2)				/* ON 8 bits PIO */
	stwio		r5, 0(r3)				/* ON 1 bits PIO */

/* 	
	add        r12, r13, r14
	add        r12, r13, r14
	add        r12, r13, r14
	add        r12, r13, r14
	add        r12, r13, r14
*/

/*	
	jmpi label1

label1:
	jmpi label2

label2:
	jmpi label3

label3:
	jmpi label4

label4:
	jmpi label5

label5:
*/

/*	
	ldwio		r2,0(r3)
	ldwio		r2,0(r3)
	ldwio		r2,0(r3)
	ldwio		r2,0(r3)
	ldwio		r2,0(r3)
*/

/*	
	bne r5,r0,label1

label1:
	bne r5,r0,label2

label2:
	bne r5,r0,label3

label3:
	bne r5,r0,label4

label4:
	bne r5,r0,label5

label5:
*/

/*	
	bne r0,r0,label1

label1:
	bne r0,r0,label2

label2:
	bne r0,r0,label3

label3:
	bne r0,r0,label4

label4:
	bne r0,r0,label5

label5:
*/
	stwio		r0, 0(r3)				/* OFF 1 bits PIO */	
	br 		DO_DISPLAY
	nop

/********************************************************************************
	.data									/* data follows */

HEX_bits:
	.word 0x0000000F


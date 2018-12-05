#include "nios2_ctrl_reg_macros.h"

// function prototypes
int main(void);
void interrupt_handler(void);
void the_exception (void);

/* Declare volatile pointers to I/O registers. This will ensure that the 
resulting code will bypass the cache*/

//KEY1_base_add = 0x00011000;	
//MSB_base_add = 0x00011010; 		irq = 0
//RS232_UART_base_add = 0x00011020;	irq = 2
//JTAG_UART_base_add = 0x00011028;	irq = 1

volatile int *InPort_KEY1 = (int *) 0x00011020;	// connect to KEY [1]
volatile int *InPort_MSB = (int *) 0x00011030;	// connect to MSB of count
volatile int *RS232 = (int *) 0x00011000;
volatile int *JTAG =  (int *) 0x00011040;

int character = 0;

/**************************************************************************
* This program demonstrates use of interrupts in the DE2 Basic Computer. 
**************************************************************************/
int main(void)
{
	int i;
	int prev,current;
	
	// level 1
	NIOS2_WRITE_STATUS(1); 

	// level 2
	NIOS2_WRITE_IENABLE(0x00000005);

	// level 3
	*(RS232+3) = 0x80;  
	*(InPort_MSB+2) = 0x1;

	while (1)
	{
		prev = current;
		current = *InPort_KEY1;	
		if ( !prev && current)
			character = 0;
	}
}

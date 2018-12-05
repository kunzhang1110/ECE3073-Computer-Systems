
#include "nios2_ctrl_reg_macros.h"
// function prototypes
int main(void);
void interrupt_handler(void);
void the_exception (void);
/* Declare volatile pointers to I/O registers. This will ensure that the 
resulting code will bypass the cache*/
// INSERT YOUR DECLARATIONS HERE

/**************************************************************************
* This program demonstrates use of interrupts in the DE2 Basic Computer. 
**************************************************************************/
int main(void)
{
// your code to INITIALISE VARIABLES, I/O PORTS, INTERRUPTS, etc.
	volatile int *(InPort_KEY1) = (int *) 0x00009030;	// connect to KEY [1]
	volatile int *(InPort_MSB) = (int *) 0x00009040;	// connect to MSB of count
	volatile int *(OutPort_LEDG) = (int *) 0x00009020;	// connect to LEDG [1]
	
	int i;

	// set interrupt mask bit for counter IRQ level 1
	*( InPort_MSB + 0x2) = 0x1;

	//enable counter MSB interrupt
	NIOS2_WRITE_IENABLE(0x1);

	// enable Nios II interrupts (presumably PIE bit in status set to 1)
	NIOS2_WRITE_STATUS(0x1);

	// your infinite loop to POLL KEY1 and service it.
	// normal code infinite loop
	while (1)
	{
	// check for the KEY1 output
		if (*(InPort_KEY1) == 0)
		{
			// service KEY[1] pressed
			if (*OutPort_LEDG == 0)
			*(OutPort_LEDG) = 1;
			else
			*(OutPort_LEDG) = 0;
		}
		else
			//Dummy for loop
			for (i=0; i<100; i++)
			{}
	}

	return 0;
}

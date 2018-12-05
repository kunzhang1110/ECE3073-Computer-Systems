# include <stdio.h>

int main (void)
{
	int sw_value;
	int track = 0;
	volatile int *InPort_KEY1 = (int *) 0x00009030;		// connect to KEY [1]
	volatile int *InPort_MSB = (int *) 0x00009040;		// connect to MSB of count
	volatile int *OutPort_LEDR = (int *) 0x00009000;	// connect to LEDR [7:0]
	volatile int *OutPort_LEDG = (int *) 0x00009020;	// connect to LEDG [1]
	volatile int *OutPort_FLAG = (int *) 0x00009010;	// connect to GPIO_1 [2]

	while (1)
	{
		sw_value = *InPort_KEY1;
		*OutPort_LEDG = sw_value;	// LEDG [1] = KEY [1]
		
		if (*InPort_MSB == 1 && track == 0)
		{
			*OutPort_FLAG = 1;
			*OutPort_LEDR = *OutPort_LEDR + 1;
			*OutPort_FLAG = 0;
		}
		track = *InPort_MSB;

		if (*InPort_MSB == 1 && track == 0)
			*OutPort_LEDG = ~*OutPort_LEDG;
	return 0;
}
			
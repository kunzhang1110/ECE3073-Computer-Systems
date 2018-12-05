
#include <stdio.h>
#include "includes.h"
#include "system.h" // contains definitions of device addresses/IRQs
  // eg KEY_BASE, KEY_IRQ.  Use these symbols so your code will still
  // work after a change in SOPC addresses or IRQs
#include "altera_avalon_pio_regs.h"
#include "alt_types.h"
#include "sys/alt_irq.h"
 
 
void * context;
OS_EVENT * sem_key_change;  // semaphore declaration
 
static void KeyISR(void * isr_context, alt_u32 id)
{
// TODO: clear interrupt source using IOWR(KEY_BASE, ??, ??)
//              see documentation for PIO mentioned in section 3.1
// TODO: signal semaphore using OSSemPost()
}
 
// .....task definitions etc including task that calls OSSemPend()
 
int main(void)
{
// TODO: initialize, check semaphore create using ??=OSSemCreate(??)
//        if (??? == 0) ??
 
  IOWR(KEY_BASE, 3, 0); // clear KEY PIO interrupt capture register,
                        // hence clears any pending interrupts
 
alt_irq_register(KEY_IRQ, context, KeyISR); 
// registers and enables KEY_IRQ to interrupt
 
IOWR(KEY_BASE, 2, ??? );
// enable edge capture bits to generate interrupt for lowest 4 bits
                          
OSTaskCreateExt(......)
OSStart();
}

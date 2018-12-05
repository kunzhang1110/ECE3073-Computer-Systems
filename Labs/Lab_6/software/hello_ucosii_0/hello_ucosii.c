#include <stdio.h>
#include <stdlib.h>
#include "includes.h"
#include "io.h"   // found at <Nios II EDS install path>/components/altera_nios2/HAL/inc/io.h.

/* Definition of Task Stacks */
#define   TASK_STACKSIZE       2048
OS_STK    task1_stk[TASK_STACKSIZE];
OS_STK    task2_stk[TASK_STACKSIZE];
OS_STK    task3_stk[TASK_STACKSIZE];

/* Definition of Task Priorities */

#define TASK1_PRIORITY      1
#define TASK2_PRIORITY      2
#define PRIORITY_1      1
#define PRIORITY_2      2
#define PRIORITY_3      3

/*      Code for 3.2, need to edit as que asked          *     //add "/" to enable the code and remove "/" to disable the code

        //Prints "Hello World" and sleeps for three seconds
        void task1(void* pdata)
        {          
          while (1)
          { 
            printf("Hello from task1\n");
            OSTimeDlyHMSM(0, 0, 3, 0);
          }
        }
                
        // Prints "Hello World" and sleeps for three seconds 
        void task2(void* pdata)
        {
          while (1)
          { 
            printf("Hello from task2\n");
            OSTimeDlyHMSM(0, 0, 3, 0);
          }
        }

        // The main function creates one task and starts multi-tasking 
        int main(void)
        {

          OSTaskCreateExt(task1,
                          NULL,
                          (void *)&task1_stk[TASK_STACKSIZE-1],
                          TASK1_PRIORITY,
                          TASK1_PRIORITY,
                          task1_stk,
                          TASK_STACKSIZE,
                          NULL,
                          0);

        OSTaskCreateExt(task2,
                          NULL,
                          (void *)&task2_stk[TASK_STACKSIZE-1],
                          TASK2_PRIORITY,
                          TASK2_PRIORITY,
                          task2_stk,
                          TASK_STACKSIZE,
                          NULL,
                          0);

          OSStart();
          return 0;
        }
/*      end of code*/


/*      Code for 3.3 and 3.4                              *     //add "/" to enable the code and remove "/" to disable the code

        //function:  Hexdisplay
        //description: converts 0-9 in term of decimal / binary to 7 segment display format
        int Hexdisplay(int iBinary4)
        {
              int oHex;
              
              switch (iBinary4)
              {
                case 0:
                    oHex = 0x40;
                    break;
                case 1:
                    oHex = 0x79;
                    break;
                case 2: 
                    oHex = 0x24;
                    break;
                case 3: 
                    oHex = 0x30;
                    break;
                case 4:
                    oHex = 0x19;
                    break;
                case 5: 
                    oHex = 0x12;
                    break;
                case 6:
                    oHex = 0x02;
                    break;
                case 7: 
                    oHex = 0x78;
                    break;
                case 8:
                    oHex = 0x0;
                    break;
                case 9: 
                    oHex = 0x10;
                    break;
                default:
                    oHex = 0x7F;
              }
              
              return oHex;
        }

//        //function:  Dec_to_Hexdisplay
//        //description: converts decimal numbers to 7 segment display format
//        void Dec_to_Hexdisplay (int value_to_convert, int least_significant_hex_base_address, int display_significant)
//        {
//            int base_10_divider = 10;
//            int address_offset = 4; // in term of how many offset of address bus width (which standard 4), need 4 as each HEX address different 0x10, and start with 2 s.g
//            int oHEX_format;
//            double display_limit;
//            div_t divide_result;
//            display_limit = pow((double) 10,(display_significant-1));
//            divide_result = div(value_to_convert,base_10_divider);
//
//            while ( divide_result.quot > 9 )
//            {
//                if ( base_10_divider > display_limit )
//                {
//                    value_to_convert = value_to_convert - divide_result.quot * base_10_divider;
//                    base_10_divider = base_10_divider / 10;
//                    divide_result = div(value_to_convert,base_10_divider);
//                    address_offset = address_offset - 4;
//                }
//                else
//                {
//                    base_10_divider = 10 * base_10_divider;
//                    address_offset = 4 + address_offset;
//                    divide_result = div(value_to_convert,base_10_divider);
//                }
//                
//            }
//
//            while ( address_offset >= 0 )
//            {
//                oHEX_format = Hexdisplay(divide_result.quot);
//                IOWR (least_significant_hex_base_address, address_offset, oHEX_format);
//                value_to_convert = value_to_convert - divide_result.quot * base_10_divider;
//                base_10_divider = base_10_divider / 10;
//                divide_result = div(value_to_convert,base_10_divider);
//                address_offset = address_offset - 4;
//            }
//        }

        // Prints "Hello World" and sleeps for three seconds 
        void task2(void* pdata)
        {
          while (1)
          { 
            printf("Hello from task2\n");
            OSTimeDlyHMSM(0, 0, 0, 30);
          }
        }

        //Prints "Hello World" and sleeps for three seconds and create another task
        void task1(void* pdata)
        {
          int HEX6_address = 0x00081090;
          int HEX7_address = 0x000810a0;
          int HEX_6_display, HEX_7_display;
          OSStatInit();
          printf ("OSIdleCtrMax => %ld\n", OSIdleCtrMax);

          OSTaskCreateExt(task2,
                          NULL,
                          (void *)&task2_stk[TASK_STACKSIZE-1],
                          TASK2_PRIORITY,
                          TASK2_PRIORITY,
                          task2_stk,
                          TASK_STACKSIZE,
                          NULL,
                          0);
          while (1)
          { 
            HEX_6_display = Hexdisplay(OSCPUUsage%10);
            HEX_7_display = Hexdisplay(OSCPUUsage/10);
            IOWR (HEX6_address, 0, HEX_6_display);
            IOWR (HEX7_address, 0, HEX_7_display);
            printf ("constant print OSCPUUsage => %d\n",OSCPUUsage);
            printf("Hello from task1\n");
            OSTimeDlyHMSM(0, 0, 0, 30);
          }
        }

        // The main function creates one task and starts multi-tasking 
        int main(void)
        {

          OSTaskCreateExt(task1,
                          NULL,
                          (void *)&task1_stk[TASK_STACKSIZE-1],
                          TASK1_PRIORITY,
                          TASK1_PRIORITY,
                          task1_stk,
                          TASK_STACKSIZE,
                          NULL,
                          0);            
               
          OSStart();
          return 0;
        }
/*      end of code*/


/*      Code for 3.5                                 *    //add "/" to enable the code and remove "/" to disable the code

        //function:  Hexdisplay
        //description: converts a 4 bit BCD number to 7 segment display format
        int Hexdisplay(int iBinary4)
        {
              int oHex;
              
              switch (iBinary4)
              {
                case 0:
                    oHex = 0x40;
                    break;
                case 1:
                    oHex = 0x79;
                    break;
                case 2: 
                    oHex = 0x24;
                    break;
                case 3: 
                    oHex = 0x30;
                    break;
                case 4:
                    oHex = 0x19;
                    break;
                case 5: 
                    oHex = 0x12;
                    break;
                case 6:
                    oHex = 0x02;
                    break;
                case 7: 
                    oHex = 0x78;
                    break;
                case 8:
                    oHex = 0x0;
                    break;
                case 9: 
                    oHex = 0x10;
                    break;
                default:
                    oHex = 0x7F;
              }
              
              return oHex;
        }

         //function:  task1
        //description: dummy nested for loop
        void task1(void* pdata)
        {
            int i, j, k;
            
           while (1)
          { 
            for( i = 0 ; i <1000; i++)
            {
                for( j = 0 ; j <1000; j++)
                {
                    for ( k = 0; k < 10000; k++)
                    {
                    }

                }
            }
            OSTimeDlyHMSM(0, 0, 10, 0);
          }
        }
        //function:  task3
        //description: increase clock's timer and display to HEX
        void task3(void* pdata)
        {
         int HEX7 = 0x000810a0;
         int HEX6 = 0x00081090;
         int HEX5 = 0x00081080;
         int HEX4 = 0x00081070;
         int HEX3 = 0x00081060;
         int HEX2 = 0x00081050;
         int HEX1 = 0x00081040;
         int HEX0 = 0x00081030;
         
         int hour_MSF = 0;
         int hour_LSF = 0;
         int min_MSF = 0;
         int min_LSF = 0;
         int sec_MSF = 0;
         int sec_LSF = 0;

         int display_hour_MSF;
         int display_hour_LSF;
         int display_min_MSF;
         int display_min_LSF;
         int display_sec_MSF;
         int display_sec_LSF;
          
          while (1)
          { 

            sec_LSF = sec_LSF + 1;

            if (sec_LSF == 10)
            {
            sec_LSF = 0;
            sec_MSF = sec_MSF + 1;
            }

            if (sec_MSF == 6)
            {
            sec_MSF = 0;
            min_LSF = min_LSF + 1;
            }

            if (min_LSF == 10)
            {
            min_LSF = 0;
            min_MSF = min_MSF + 1;
            }

            if (min_MSF == 6)
            {
            min_MSF = 0;
            hour_LSF = hour_LSF + 1;
            }


            if (hour_LSF == 10)
            {
            hour_LSF = 0;
            hour_MSF = hour_MSF + 1;
            }

            display_sec_LSF = Hexdisplay( sec_LSF );
            display_sec_MSF = Hexdisplay( sec_MSF );
            display_min_LSF = Hexdisplay( min_LSF );
            display_min_MSF = Hexdisplay( min_MSF );
            display_hour_LSF = Hexdisplay( hour_LSF );
            display_hour_MSF = Hexdisplay( hour_MSF );

            IOWR(HEX7,0,display_sec_MSF);
            IOWR(HEX6,0,display_sec_LSF);
            IOWR(HEX5,0,display_min_MSF);
            IOWR(HEX4,0,display_min_LSF);
            IOWR(HEX3,0,display_hour_MSF);
            IOWR(HEX2,0,display_hour_LSF);
            IOWR(HEX1,0,0x7F);
            IOWR(HEX0,0,0x7F);

            OSTimeDlyHMSM(0, 0, 1, 0);
          }
        }
        
// The main function creates two task and starts multi-tasking 
        int main(void)
        {

         OSTaskCreateExt(task1,
                          NULL,
                          (void *)&task1_stk[TASK_STACKSIZE-1],
                          PRIORITY_1,
                          PRIORITY_1,
                          task1_stk,
                          TASK_STACKSIZE,
                          NULL,
                          0);   

          OSTaskCreateExt(task3,
                          NULL,
                          (void *)&task3_stk[TASK_STACKSIZE-1],
                          PRIORITY_3,
                          PRIORITY_3,
                          task3_stk,
                          TASK_STACKSIZE,
                          NULL,
                          0);
             
          OSStart();
          return 0;
        }
/*      end of code*/

/*      Code for 3.6                                 *    //add "/" to enable the code and remove "/" to disable the code
        INT8U LEDG_frequent_power (INT8U brightness, INT8U accumulator, INT8U *power, int LEDG_address, int LEDGX)
        {
            accumulator += brightness;
            if (accumulator >= 32 )
            {
                accumulator -= 32;
                *power = *power | LEDGX;
                IOWR(LEDG_address,0,*power);
            }
            else
            {
                *power = *power & ~LEDGX;
                IOWR(LEDG_address,0,*power);
            }
            return (accumulator);            
        }
        //function:  task3
        //description: increase clock's timer and display to HEX
        void task3(void* pdata)
        {
         int i;
         int gradient = 0;
         int LEDG_address = 0x000810b0;
         INT8U power = 0;
         INT8U brightness = 0;
         INT8U accumulator0 = 0;
         
         while (1)
         {
            //LEDG_frequent_power (INT8U brightness, INT8U accumulator, INT8U *power, int LEDG_address, int LEDGX)
            
            for (i = 0; i<100000; i++)
            {
                accumulator0 = LEDG_frequent_power ( brightness, accumulator0, &power, LEDG_address, 1 );
            }
            if (gradient == 0 && brightness <32)
            {
                brightness ++;
                if (brightness == 32)
                    gradient = 1;
            }
            else if (gradient == 1 && brightness > 0)
            {
                brightness --;
                if (brightness == 0)
                    gradient = 0;
            }
            OSTimeDly(1);    
         }
        }
        
// The main function creates two task and starts multi-tasking 
        int main(void)
        {
          OSTaskCreateExt(task3,
                          NULL,
                          (void *)&task3_stk[TASK_STACKSIZE-1],
                          PRIORITY_3,
                          PRIORITY_3,
                          task3_stk,
                          TASK_STACKSIZE,
                          NULL,
                          0);
             
          OSStart();
          return 0;
        }
/*      end of code*/

/*      Code for 3.7                                 */     //add "/" to enable the code and remove "/" to disable the code
                //function:  Hexdisplay
        //description: converts 0-9 in term of decimal / binary to 7 segment display format
        int Hexdisplay(int iBinary4)
        {
              int oHex;
              
              switch (iBinary4)
              {
                case 0:
                    oHex = 0x40;
                    break;
                case 1:
                    oHex = 0x79;
                    break;
                case 2: 
                    oHex = 0x24;
                    break;
                case 3: 
                    oHex = 0x30;
                    break;
                case 4:
                    oHex = 0x19;
                    break;
                case 5: 
                    oHex = 0x12;
                    break;
                case 6:
                    oHex = 0x02;
                    break;
                case 7: 
                    oHex = 0x78;
                    break;
                case 8:
                    oHex = 0x0;
                    break;
                case 9: 
                    oHex = 0x10;
                    break;
                default:
                    oHex = 0x7F;
              }
              
              return oHex;
        }
        
        
        INT8U LEDG_frequent_power (INT8U brightness, INT8U accumulator, INT8U *power, int LEDG_address, int LEDGX)
        {
            accumulator += brightness;
            if (accumulator >= 32 )
            {
                accumulator -= 32;
                *power = *power | LEDGX;
                IOWR(LEDG_address,0,*power);
            }
            else
            {
                *power = *power & ~LEDGX;
                IOWR(LEDG_address,0,*power);
            }
            return (accumulator);            
        }
         //function:  task3
        //description: increase clock's timer and display to HEX
        void task3(void* pdata)
        {
         int HEX7 = 0x000810a0;
         int HEX6 = 0x00081090;
         int HEX5 = 0x00081080;
         int HEX4 = 0x00081070;
         int HEX3 = 0x00081060;
         int HEX2 = 0x00081050;
         int HEX1 = 0x00081040;
         int HEX0 = 0x00081030;
         
         int hour_MSF = 0;
         int hour_LSF = 0;
         int min_MSF = 0;
         int min_LSF = 0;
         int sec_MSF = 0;
         int sec_LSF = 0;

         int display_hour_MSF;
         int display_hour_LSF;
         int display_min_MSF;
         int display_min_LSF;
         int display_sec_MSF;
         int display_sec_LSF;
          
          while (1)
          { 

            sec_LSF = sec_LSF + 1;

            if (sec_LSF == 10)
            {
            sec_LSF = 0;
            sec_MSF = sec_MSF + 1;
            }

            if (sec_MSF == 6)
            {
            sec_MSF = 0;
            min_LSF = min_LSF + 1;
            }

            if (min_LSF == 10)
            {
            min_LSF = 0;
            min_MSF = min_MSF + 1;
            }

            if (min_MSF == 6)
            {
            min_MSF = 0;
            hour_LSF = hour_LSF + 1;
            }


            if (hour_LSF == 10)
            {
            hour_LSF = 0;
            hour_MSF = hour_MSF + 1;
            }

            display_sec_LSF = Hexdisplay( sec_LSF );
            display_sec_MSF = Hexdisplay( sec_MSF );
            display_min_LSF = Hexdisplay( min_LSF );
            display_min_MSF = Hexdisplay( min_MSF );
            display_hour_LSF = Hexdisplay( hour_LSF );
            display_hour_MSF = Hexdisplay( hour_MSF );

            IOWR(HEX5,0,display_sec_MSF);
            IOWR(HEX4,0,display_sec_LSF);
            IOWR(HEX3,0,display_min_MSF);
            IOWR(HEX2,0,display_min_LSF);
            IOWR(HEX1,0,0x7F);
            IOWR(HEX0,0,display_hour_LSF);

            OSTimeDlyHMSM(0, 0, 1, 0);
          }
        }
        
        //function:  task1
        //description: increase clock's timer and display to HEX
        void task1(void* pdata)
        {
         // CPU Usage
          int HEX6_address = 0x00081090;
          int HEX7_address = 0x000810a0;
          int HEX_6_display, HEX_7_display;
          OSStatInit();
         
         // LED oscillation        
         int i;
         int LEDG_address = 0x000810b0;
         INT8U power = 0;
         INT8U brightness [8] = {2,6,10,14,16,20,24,28};

         int gradient [9] = {0,0,0,0,0,0,0,0};
         INT8U accumulator[8] = {0,0,0,0,0,0,0,0}; 
         
       OSTaskCreateExt(task3,
              NULL,
              (void *)&task3_stk[TASK_STACKSIZE-1],
              PRIORITY_1,
              PRIORITY_1,
              task3_stk,
              TASK_STACKSIZE,
              NULL,
              0);
                          
         while (1)
         {
            //INT8U LEDG_frequent_power (INT8U *brightness, int gradient, INT8U accumulator, INT8U *power, int LEDG_address, int LEDGX)
            
            for (i = 0; i<1000; i++)
            {
                // CPU Usage
                HEX_6_display = Hexdisplay(OSCPUUsage%10);
                HEX_7_display = Hexdisplay(OSCPUUsage/10);
                IOWR (HEX6_address, 0, HEX_6_display);
                IOWR (HEX7_address, 0, HEX_7_display);
                
                // LED oscillation
                accumulator[0] = LEDG_frequent_power ( brightness[0], accumulator[0], &power, LEDG_address, 1 );
                accumulator[1] = LEDG_frequent_power ( brightness[1], accumulator[1], &power, LEDG_address, 2 );
                accumulator[2] = LEDG_frequent_power ( brightness[2], accumulator[2], &power, LEDG_address, 4 );
                accumulator[3] = LEDG_frequent_power ( brightness[3], accumulator[3], &power, LEDG_address, 8 );
                accumulator[4] = LEDG_frequent_power ( brightness[4], accumulator[4], &power, LEDG_address, 16 );
                accumulator[5] = LEDG_frequent_power ( brightness[5], accumulator[5], &power, LEDG_address, 32 );
                accumulator[6] = LEDG_frequent_power ( brightness[6], accumulator[6], &power, LEDG_address, 64 );
                accumulator[7] = LEDG_frequent_power ( brightness[7], accumulator[7], &power, LEDG_address, 128 );
                
            }
            
            for (i = 0; i<8; i++)
            {
                if (gradient[i] == 0 && brightness[i] <32)
                {
                brightness[i] ++;
                if (brightness[i] == 32)
                    gradient[i] = 1;
                }
                else if (gradient[i] == 1 && brightness[i] > 0)
                {
                brightness[i] --;
                if (brightness[i] == 0)
                    gradient[i] = 0;
                }
            }
            OSTimeDly(1);    
            
         }
        }
        
// The main function creates two task and starts multi-tasking 
        int main(void)
        {
          OSTaskCreateExt(task1,
                          NULL,
                          (void *)&task1_stk[TASK_STACKSIZE-1],
                          PRIORITY_3,
                          PRIORITY_3,
                          task1_stk,
                          TASK_STACKSIZE,
                          NULL,
                          0);
             
          OSStart();
          return 0;
        }
/*      end of code*/

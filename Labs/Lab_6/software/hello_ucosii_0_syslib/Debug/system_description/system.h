/* system.h
 *
 * Machine generated for a CPU named "cpu_0" as defined in:
 * e:\ECE3073_labs\Lab_6\software\hello_ucosii_0_syslib\..\..\RTSLab1CPU.ptf
 *
 * Generated: 2013-05-08 09:26:23.786
 *
 */

#ifndef __SYSTEM_H_
#define __SYSTEM_H_

/*

DO NOT MODIFY THIS FILE

   Changing this file will have subtle consequences
   which will almost certainly lead to a nonfunctioning
   system. If you do modify this file, be aware that your
   changes will be overwritten and lost when this file
   is generated again.

DO NOT MODIFY THIS FILE

*/

/******************************************************************************
*                                                                             *
* License Agreement                                                           *
*                                                                             *
* Copyright (c) 2003 Altera Corporation, San Jose, California, USA.           *
* All rights reserved.                                                        *
*                                                                             *
* Permission is hereby granted, free of charge, to any person obtaining a     *
* copy of this software and associated documentation files (the "Software"),  *
* to deal in the Software without restriction, including without limitation   *
* the rights to use, copy, modify, merge, publish, distribute, sublicense,    *
* and/or sell copies of the Software, and to permit persons to whom the       *
* Software is furnished to do so, subject to the following conditions:        *
*                                                                             *
* The above copyright notice and this permission notice shall be included in  *
* all copies or substantial portions of the Software.                         *
*                                                                             *
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR  *
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,    *
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE *
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER      *
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING     *
* FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER         *
* DEALINGS IN THE SOFTWARE.                                                   *
*                                                                             *
* This agreement shall be governed in all respects by the laws of the State   *
* of California and by the laws of the United States of America.              *
*                                                                             *
******************************************************************************/

/*
 * system configuration
 *
 */

#define ALT_SYSTEM_NAME "RTSLab1CPU"
#define ALT_CPU_NAME "cpu_0"
#define ALT_CPU_ARCHITECTURE "altera_nios2"
#define ALT_DEVICE_FAMILY "CYCLONEII"
#define ALT_STDIN "/dev/jtag_uart_0"
#define ALT_STDIN_TYPE "altera_avalon_jtag_uart"
#define ALT_STDIN_BASE 0x000810d0
#define ALT_STDIN_DEV jtag_uart_0
#define ALT_STDIN_PRESENT
#define ALT_STDOUT "/dev/jtag_uart_0"
#define ALT_STDOUT_TYPE "altera_avalon_jtag_uart"
#define ALT_STDOUT_BASE 0x000810d0
#define ALT_STDOUT_DEV jtag_uart_0
#define ALT_STDOUT_PRESENT
#define ALT_STDERR "/dev/jtag_uart_0"
#define ALT_STDERR_TYPE "altera_avalon_jtag_uart"
#define ALT_STDERR_BASE 0x000810d0
#define ALT_STDERR_DEV jtag_uart_0
#define ALT_STDERR_PRESENT
#define ALT_CPU_FREQ 50000000
#define ALT_IRQ_BASE NULL
#define ALT_LEGACY_INTERRUPT_API_PRESENT

/*
 * processor configuration
 *
 */

#define NIOS2_CPU_IMPLEMENTATION "fast"
#define NIOS2_BIG_ENDIAN 0
#define NIOS2_INTERRUPT_CONTROLLER_ID 0

#define NIOS2_ICACHE_SIZE 4096
#define NIOS2_DCACHE_SIZE 2048
#define NIOS2_ICACHE_LINE_SIZE 32
#define NIOS2_ICACHE_LINE_SIZE_LOG2 5
#define NIOS2_DCACHE_LINE_SIZE 32
#define NIOS2_DCACHE_LINE_SIZE_LOG2 5
#define NIOS2_FLUSHDA_SUPPORTED

#define NIOS2_EXCEPTION_ADDR 0x00040020
#define NIOS2_RESET_ADDR 0x00040000
#define NIOS2_BREAK_ADDR 0x00080820

#define NIOS2_HAS_DEBUG_STUB

#define NIOS2_CPU_ID_SIZE 1
#define NIOS2_CPU_ID_VALUE 0

/*
 * A define for each class of peripheral
 *
 */

#define __ALTERA_AVALON_JTAG_UART
#define __ALTERA_AVALON_TRI_STATE_BRIDGE
#define __ALTERA_AVALON_LCD_16207
#define __ALTERA_AVALON_PIO
#define __ALTERA_AVALON_TIMER
#define __STATIC_RAM

/*
 * jtag_uart_0 configuration
 *
 */

#define JTAG_UART_0_NAME "/dev/jtag_uart_0"
#define JTAG_UART_0_TYPE "altera_avalon_jtag_uart"
#define JTAG_UART_0_BASE 0x000810d0
#define JTAG_UART_0_SPAN 8
#define JTAG_UART_0_IRQ 0
#define JTAG_UART_0_IRQ_INTERRUPT_CONTROLLER_ID 0
#define JTAG_UART_0_WRITE_DEPTH 64
#define JTAG_UART_0_READ_DEPTH 64
#define JTAG_UART_0_WRITE_THRESHOLD 8
#define JTAG_UART_0_READ_THRESHOLD 8
#define JTAG_UART_0_READ_CHAR_STREAM ""
#define JTAG_UART_0_SHOWASCII 1
#define JTAG_UART_0_RELATIVEPATH 1
#define JTAG_UART_0_READ_LE 0
#define JTAG_UART_0_WRITE_LE 0
#define JTAG_UART_0_ALTERA_SHOW_UNRELEASED_JTAG_UART_FEATURES 0
#define ALT_MODULE_CLASS_jtag_uart_0 altera_avalon_jtag_uart

/*
 * tri_state_bridge_0 configuration
 *
 */

#define TRI_STATE_BRIDGE_0_NAME "/dev/tri_state_bridge_0"
#define TRI_STATE_BRIDGE_0_TYPE "altera_avalon_tri_state_bridge"
#define ALT_MODULE_CLASS_tri_state_bridge_0 altera_avalon_tri_state_bridge

/*
 * lcd_0 configuration
 *
 */

#define LCD_0_NAME "/dev/lcd_0"
#define LCD_0_TYPE "altera_avalon_lcd_16207"
#define LCD_0_BASE 0x00081020
#define LCD_0_SPAN 16
#define ALT_MODULE_CLASS_lcd_0 altera_avalon_lcd_16207

/*
 * HEX0 configuration
 *
 */

#define HEX0_NAME "/dev/HEX0"
#define HEX0_TYPE "altera_avalon_pio"
#define HEX0_BASE 0x00081030
#define HEX0_SPAN 16
#define HEX0_DO_TEST_BENCH_WIRING 0
#define HEX0_DRIVEN_SIM_VALUE 0
#define HEX0_HAS_TRI 0
#define HEX0_HAS_OUT 1
#define HEX0_HAS_IN 0
#define HEX0_CAPTURE 0
#define HEX0_DATA_WIDTH 7
#define HEX0_RESET_VALUE 0
#define HEX0_EDGE_TYPE "NONE"
#define HEX0_IRQ_TYPE "NONE"
#define HEX0_BIT_CLEARING_EDGE_REGISTER 0
#define HEX0_BIT_MODIFYING_OUTPUT_REGISTER 0
#define HEX0_FREQ 50000000
#define ALT_MODULE_CLASS_HEX0 altera_avalon_pio

/*
 * HEX1 configuration
 *
 */

#define HEX1_NAME "/dev/HEX1"
#define HEX1_TYPE "altera_avalon_pio"
#define HEX1_BASE 0x00081040
#define HEX1_SPAN 16
#define HEX1_DO_TEST_BENCH_WIRING 0
#define HEX1_DRIVEN_SIM_VALUE 0
#define HEX1_HAS_TRI 0
#define HEX1_HAS_OUT 1
#define HEX1_HAS_IN 0
#define HEX1_CAPTURE 0
#define HEX1_DATA_WIDTH 7
#define HEX1_RESET_VALUE 0
#define HEX1_EDGE_TYPE "NONE"
#define HEX1_IRQ_TYPE "NONE"
#define HEX1_BIT_CLEARING_EDGE_REGISTER 0
#define HEX1_BIT_MODIFYING_OUTPUT_REGISTER 0
#define HEX1_FREQ 50000000
#define ALT_MODULE_CLASS_HEX1 altera_avalon_pio

/*
 * HEX2 configuration
 *
 */

#define HEX2_NAME "/dev/HEX2"
#define HEX2_TYPE "altera_avalon_pio"
#define HEX2_BASE 0x00081050
#define HEX2_SPAN 16
#define HEX2_DO_TEST_BENCH_WIRING 0
#define HEX2_DRIVEN_SIM_VALUE 0
#define HEX2_HAS_TRI 0
#define HEX2_HAS_OUT 1
#define HEX2_HAS_IN 0
#define HEX2_CAPTURE 0
#define HEX2_DATA_WIDTH 7
#define HEX2_RESET_VALUE 0
#define HEX2_EDGE_TYPE "NONE"
#define HEX2_IRQ_TYPE "NONE"
#define HEX2_BIT_CLEARING_EDGE_REGISTER 0
#define HEX2_BIT_MODIFYING_OUTPUT_REGISTER 0
#define HEX2_FREQ 50000000
#define ALT_MODULE_CLASS_HEX2 altera_avalon_pio

/*
 * HEX3 configuration
 *
 */

#define HEX3_NAME "/dev/HEX3"
#define HEX3_TYPE "altera_avalon_pio"
#define HEX3_BASE 0x00081060
#define HEX3_SPAN 16
#define HEX3_DO_TEST_BENCH_WIRING 0
#define HEX3_DRIVEN_SIM_VALUE 0
#define HEX3_HAS_TRI 0
#define HEX3_HAS_OUT 1
#define HEX3_HAS_IN 0
#define HEX3_CAPTURE 0
#define HEX3_DATA_WIDTH 7
#define HEX3_RESET_VALUE 0
#define HEX3_EDGE_TYPE "NONE"
#define HEX3_IRQ_TYPE "NONE"
#define HEX3_BIT_CLEARING_EDGE_REGISTER 0
#define HEX3_BIT_MODIFYING_OUTPUT_REGISTER 0
#define HEX3_FREQ 50000000
#define ALT_MODULE_CLASS_HEX3 altera_avalon_pio

/*
 * HEX4 configuration
 *
 */

#define HEX4_NAME "/dev/HEX4"
#define HEX4_TYPE "altera_avalon_pio"
#define HEX4_BASE 0x00081070
#define HEX4_SPAN 16
#define HEX4_DO_TEST_BENCH_WIRING 0
#define HEX4_DRIVEN_SIM_VALUE 0
#define HEX4_HAS_TRI 0
#define HEX4_HAS_OUT 1
#define HEX4_HAS_IN 0
#define HEX4_CAPTURE 0
#define HEX4_DATA_WIDTH 7
#define HEX4_RESET_VALUE 0
#define HEX4_EDGE_TYPE "NONE"
#define HEX4_IRQ_TYPE "NONE"
#define HEX4_BIT_CLEARING_EDGE_REGISTER 0
#define HEX4_BIT_MODIFYING_OUTPUT_REGISTER 0
#define HEX4_FREQ 50000000
#define ALT_MODULE_CLASS_HEX4 altera_avalon_pio

/*
 * HEX5 configuration
 *
 */

#define HEX5_NAME "/dev/HEX5"
#define HEX5_TYPE "altera_avalon_pio"
#define HEX5_BASE 0x00081080
#define HEX5_SPAN 16
#define HEX5_DO_TEST_BENCH_WIRING 0
#define HEX5_DRIVEN_SIM_VALUE 0
#define HEX5_HAS_TRI 0
#define HEX5_HAS_OUT 1
#define HEX5_HAS_IN 0
#define HEX5_CAPTURE 0
#define HEX5_DATA_WIDTH 7
#define HEX5_RESET_VALUE 0
#define HEX5_EDGE_TYPE "NONE"
#define HEX5_IRQ_TYPE "NONE"
#define HEX5_BIT_CLEARING_EDGE_REGISTER 0
#define HEX5_BIT_MODIFYING_OUTPUT_REGISTER 0
#define HEX5_FREQ 50000000
#define ALT_MODULE_CLASS_HEX5 altera_avalon_pio

/*
 * HEX6 configuration
 *
 */

#define HEX6_NAME "/dev/HEX6"
#define HEX6_TYPE "altera_avalon_pio"
#define HEX6_BASE 0x00081090
#define HEX6_SPAN 16
#define HEX6_DO_TEST_BENCH_WIRING 0
#define HEX6_DRIVEN_SIM_VALUE 0
#define HEX6_HAS_TRI 0
#define HEX6_HAS_OUT 1
#define HEX6_HAS_IN 0
#define HEX6_CAPTURE 0
#define HEX6_DATA_WIDTH 7
#define HEX6_RESET_VALUE 0
#define HEX6_EDGE_TYPE "NONE"
#define HEX6_IRQ_TYPE "NONE"
#define HEX6_BIT_CLEARING_EDGE_REGISTER 0
#define HEX6_BIT_MODIFYING_OUTPUT_REGISTER 0
#define HEX6_FREQ 50000000
#define ALT_MODULE_CLASS_HEX6 altera_avalon_pio

/*
 * HEX7 configuration
 *
 */

#define HEX7_NAME "/dev/HEX7"
#define HEX7_TYPE "altera_avalon_pio"
#define HEX7_BASE 0x000810a0
#define HEX7_SPAN 16
#define HEX7_DO_TEST_BENCH_WIRING 0
#define HEX7_DRIVEN_SIM_VALUE 0
#define HEX7_HAS_TRI 0
#define HEX7_HAS_OUT 1
#define HEX7_HAS_IN 0
#define HEX7_CAPTURE 0
#define HEX7_DATA_WIDTH 7
#define HEX7_RESET_VALUE 0
#define HEX7_EDGE_TYPE "NONE"
#define HEX7_IRQ_TYPE "NONE"
#define HEX7_BIT_CLEARING_EDGE_REGISTER 0
#define HEX7_BIT_MODIFYING_OUTPUT_REGISTER 0
#define HEX7_FREQ 50000000
#define ALT_MODULE_CLASS_HEX7 altera_avalon_pio

/*
 * LEDG configuration
 *
 */

#define LEDG_NAME "/dev/LEDG"
#define LEDG_TYPE "altera_avalon_pio"
#define LEDG_BASE 0x000810b0
#define LEDG_SPAN 16
#define LEDG_DO_TEST_BENCH_WIRING 0
#define LEDG_DRIVEN_SIM_VALUE 0
#define LEDG_HAS_TRI 0
#define LEDG_HAS_OUT 1
#define LEDG_HAS_IN 0
#define LEDG_CAPTURE 0
#define LEDG_DATA_WIDTH 8
#define LEDG_RESET_VALUE 0
#define LEDG_EDGE_TYPE "NONE"
#define LEDG_IRQ_TYPE "NONE"
#define LEDG_BIT_CLEARING_EDGE_REGISTER 0
#define LEDG_BIT_MODIFYING_OUTPUT_REGISTER 0
#define LEDG_FREQ 50000000
#define ALT_MODULE_CLASS_LEDG altera_avalon_pio

/*
 * KEY configuration
 *
 */

#define KEY_NAME "/dev/KEY"
#define KEY_TYPE "altera_avalon_pio"
#define KEY_BASE 0x000810c0
#define KEY_SPAN 16
#define KEY_DO_TEST_BENCH_WIRING 0
#define KEY_DRIVEN_SIM_VALUE 0
#define KEY_HAS_TRI 0
#define KEY_HAS_OUT 0
#define KEY_HAS_IN 1
#define KEY_CAPTURE 0
#define KEY_DATA_WIDTH 4
#define KEY_RESET_VALUE 0
#define KEY_EDGE_TYPE "NONE"
#define KEY_IRQ_TYPE "NONE"
#define KEY_BIT_CLEARING_EDGE_REGISTER 0
#define KEY_BIT_MODIFYING_OUTPUT_REGISTER 0
#define KEY_FREQ 50000000
#define ALT_MODULE_CLASS_KEY altera_avalon_pio

/*
 * timer_0 configuration
 *
 */

#define TIMER_0_NAME "/dev/timer_0"
#define TIMER_0_TYPE "altera_avalon_timer"
#define TIMER_0_BASE 0x00081000
#define TIMER_0_SPAN 32
#define TIMER_0_IRQ 1
#define TIMER_0_IRQ_INTERRUPT_CONTROLLER_ID 0
#define TIMER_0_ALWAYS_RUN 1
#define TIMER_0_FIXED_PERIOD 1
#define TIMER_0_SNAPSHOT 0
#define TIMER_0_PERIOD 1
#define TIMER_0_PERIOD_UNITS "ms"
#define TIMER_0_RESET_OUTPUT 0
#define TIMER_0_TIMEOUT_PULSE_OUTPUT 0
#define TIMER_0_LOAD_VALUE 49999
#define TIMER_0_COUNTER_SIZE 32
#define TIMER_0_MULT 0.0010
#define TIMER_0_TICKS_PER_SEC 1000
#define TIMER_0_FREQ 50000000
#define ALT_MODULE_CLASS_timer_0 altera_avalon_timer

/*
 * static_ram_0 configuration
 *
 */

#define STATIC_RAM_0_NAME "/dev/static_ram_0"
#define STATIC_RAM_0_TYPE "static_ram"
#define STATIC_RAM_0_BASE 0x00040000
#define STATIC_RAM_0_SPAN 262144
#define ALT_MODULE_CLASS_static_ram_0 static_ram

/*
 * MicroC/OS-II configuration
 *
 */

#define ALT_MAX_FD 32
#define OS_MAX_TASKS 10
#define OS_LOWEST_PRIO 20
#define OS_FLAG_EN 1
#define OS_THREAD_SAFE_NEWLIB 1
#define OS_MUTEX_EN 1
#define OS_SEM_EN 1
#define OS_MBOX_EN 1
#define OS_Q_EN 1
#define OS_MEM_EN 1
#define OS_FLAG_WAIT_CLR_EN 1
#define OS_FLAG_ACCEPT_EN 1
#define OS_FLAG_DEL_EN 1
#define OS_FLAG_QUERY_EN 1
#define OS_FLAG_NAME_SIZE 32
#define OS_MAX_FLAGS 20
#define OS_FLAGS_NBITS 16
#define OS_MUTEX_ACCEPT_EN 1
#define OS_MUTEX_DEL_EN 1
#define OS_MUTEX_QUERY_EN 1
#define OS_SEM_ACCEPT_EN 1
#define OS_SEM_SET_EN 1
#define OS_SEM_DEL_EN 1
#define OS_SEM_QUERY_EN 1
#define OS_MBOX_ACCEPT_EN 1
#define OS_MBOX_DEL_EN 1
#define OS_MBOX_POST_EN 1
#define OS_MBOX_POST_OPT_EN 1
#define OS_MBOX_QUERY_EN 1
#define OS_Q_ACCEPT_EN 1
#define OS_Q_DEL_EN 1
#define OS_Q_FLUSH_EN 1
#define OS_Q_POST_EN 1
#define OS_Q_POST_FRONT_EN 1
#define OS_Q_POST_OPT_EN 1
#define OS_Q_QUERY_EN 1
#define OS_MAX_QS 20
#define OS_MEM_QUERY_EN 1
#define OS_MEM_NAME_SIZE 32
#define OS_MAX_MEM_PART 60
#define OS_ARG_CHK_EN 1
#define OS_CPU_HOOKS_EN 1
#define OS_DEBUG_EN 1
#define OS_SCHED_LOCK_EN 1
#define OS_TASK_STAT_EN 1
#define OS_TASK_STAT_STK_CHK_EN 1
#define OS_TICK_STEP_EN 1
#define OS_EVENT_NAME_SIZE 32
#define OS_MAX_EVENTS 60
#define OS_TASK_IDLE_STK_SIZE 512
#define OS_TASK_STAT_STK_SIZE 512
#define OS_TASK_CHANGE_PRIO_EN 1
#define OS_TASK_CREATE_EN 1
#define OS_TASK_CREATE_EXT_EN 1
#define OS_TASK_DEL_EN 1
#define OS_TASK_NAME_SIZE 32
#define OS_TASK_PROFILE_EN 1
#define OS_TASK_QUERY_EN 1
#define OS_TASK_SUSPEND_EN 1
#define OS_TASK_SW_HOOK_EN 1
#define OS_TIME_TICK_HOOK_EN 1
#define OS_TIME_GET_SET_EN 1
#define OS_TIME_DLY_RESUME_EN 1
#define OS_TIME_DLY_HMSM_EN 1
#define OS_TMR_EN 0
#define OS_TMR_CFG_MAX 16
#define OS_TMR_CFG_NAME_SIZE 16
#define OS_TMR_CFG_TICKS_PER_SEC 10
#define OS_TMR_CFG_WHEEL_SIZE 2
#define OS_TASK_TMR_STK_SIZE 512
#define OS_TASK_TMR_PRIO 1
#define ALT_SYS_CLK TIMER_0
#define ALT_TIMESTAMP_CLK none
#define OS_TICKS_PER_SEC 1000

/*
 * Devices associated with code sections.
 *
 */

#define ALT_TEXT_DEVICE       STATIC_RAM_0
#define ALT_RODATA_DEVICE     STATIC_RAM_0
#define ALT_RWDATA_DEVICE     STATIC_RAM_0
#define ALT_EXCEPTIONS_DEVICE STATIC_RAM_0
#define ALT_RESET_DEVICE      STATIC_RAM_0

/*
 * The text section is initialised so no bootloader will be required.
 * Set a variable to tell crt0.S to provide code at the reset address and
 * to initialise rwdata if appropriate.
 */

#define ALT_NO_BOOTLOADER


#endif /* __SYSTEM_H_ */

#!/bin/sh
#
# generated.sh - shell script fragment - not very useful on its own
#
# Machine generated for a CPU named "cpu_0" as defined in:
# E:\ECE3073_labs\Lab_7\RTSLab1CPU.ptf
#
# Generated: 2013-05-15 09:39:12.779

# DO NOT MODIFY THIS FILE
#
#   Changing this file will have subtle consequences
#   which will almost certainly lead to a nonfunctioning
#   system. If you do modify this file, be aware that your
#   changes will be overwritten and lost when this file
#   is generated again.
#
# DO NOT MODIFY THIS FILE

# This variable indicates where the PTF file for this design is located
ptf=E:\ECE3073_labs\Lab_7\RTSLab1CPU.ptf

# This variable indicates whether there is a CPU debug core
nios2_debug_core=yes

# This variable indicates how to connect to the CPU debug core
nios2_instance=0

# This variable indicates the CPU module name
nios2_cpu_name=cpu_0

# Include operating system specific parameters, if they are supplied.

if test -f /cygdrive/c/Altera/10.1/nios2eds/components/micrium_uc_osii/build/os.sh ; then
   . /cygdrive/c/Altera/10.1/nios2eds/components/micrium_uc_osii/build/os.sh
fi

# Legal Notice: (C)2013 Altera Corporation. All rights reserved.  Your
# use of Altera Corporation's design tools, logic functions and other
# software and tools, and its AMPP partner logic functions, and any
# output files any of the foregoing (including device programming or
# simulation files), and any associated documentation or information are
# expressly subject to the terms and conditions of the Altera Program
# License Subscription Agreement or other applicable license agreement,
# including, without limitation, that your use is for the sole purpose
# of programming logic devices manufactured by Altera and sold by Altera
# or its authorized distributors.  Please refer to the applicable
# agreement for further details.

#**************************************************************
# Timequest JTAG clock definition
#   Uncommenting the following lines will define the JTAG
#   clock in TimeQuest Timing Analyzer
#**************************************************************

#create_clock -period 10MHz {altera_reserved_tck}
#set_clock_groups -asynchronous -group {altera_reserved_tck}

#**************************************************************
# Set TCL Path Variables 
#**************************************************************

set 	DE270_cpu 	DE270_cpu:*
set 	DE270_cpu_oci 	DE270_cpu_nios2_oci:the_DE270_cpu_nios2_oci
set 	DE270_cpu_oci_break 	DE270_cpu_nios2_oci_break:the_DE270_cpu_nios2_oci_break
set 	DE270_cpu_ocimem 	DE270_cpu_nios2_ocimem:the_DE270_cpu_nios2_ocimem
set 	DE270_cpu_oci_debug 	DE270_cpu_nios2_oci_debug:the_DE270_cpu_nios2_oci_debug
set 	DE270_cpu_wrapper 	DE270_cpu_jtag_debug_module_wrapper:the_DE270_cpu_jtag_debug_module_wrapper
set 	DE270_cpu_jtag_tck 	DE270_cpu_jtag_debug_module_tck:the_DE270_cpu_jtag_debug_module_tck
set 	DE270_cpu_jtag_sysclk 	DE270_cpu_jtag_debug_module_sysclk:the_DE270_cpu_jtag_debug_module_sysclk
set 	DE270_cpu_oci_path 	 [format "%s|%s" $DE270_cpu $DE270_cpu_oci]
set 	DE270_cpu_oci_break_path 	 [format "%s|%s" $DE270_cpu_oci_path $DE270_cpu_oci_break]
set 	DE270_cpu_ocimem_path 	 [format "%s|%s" $DE270_cpu_oci_path $DE270_cpu_ocimem]
set 	DE270_cpu_oci_debug_path 	 [format "%s|%s" $DE270_cpu_oci_path $DE270_cpu_oci_debug]
set 	DE270_cpu_jtag_tck_path 	 [format "%s|%s|%s" $DE270_cpu_oci_path $DE270_cpu_wrapper $DE270_cpu_jtag_tck]
set 	DE270_cpu_jtag_sysclk_path 	 [format "%s|%s|%s" $DE270_cpu_oci_path $DE270_cpu_wrapper $DE270_cpu_jtag_sysclk]
set 	DE270_cpu_jtag_sr 	 [format "%s|*sr" $DE270_cpu_jtag_tck_path]

set 	DE270_cpu_oci_im 	DE270_cpu_nios2_oci_im:the_DE270_cpu_nios2_oci_im
set 	DE270_cpu_oci_traceram 	DE270_cpu_traceram_lpm_dram_bdp_component_module:DE270_cpu_traceram_lpm_dram_bdp_component
set 	DE270_cpu_oci_itrace 	DE270_cpu_nios2_oci_itrace:the_DE270_cpu_nios2_oci_itrace
set 	DE270_cpu_oci_im_path 	 [format "%s|%s" $DE270_cpu_oci_path $DE270_cpu_oci_im]
set 	DE270_cpu_oci_itrace_path 	 [format "%s|%s" $DE270_cpu_oci_path $DE270_cpu_oci_itrace]
set 	DE270_cpu_traceram_path 	 [format "%s|%s" $DE270_cpu_oci_im_path $DE270_cpu_oci_traceram]

#**************************************************************
# Set False Paths
#**************************************************************

set_false_path -from [get_keepers *$DE270_cpu_oci_break_path|break_readreg*] -to [get_keepers *$DE270_cpu_jtag_sr*]
set_false_path -from [get_keepers *$DE270_cpu_oci_debug_path|*resetlatch]     -to [get_keepers *$DE270_cpu_jtag_sr[33]]
set_false_path -from [get_keepers *$DE270_cpu_oci_debug_path|monitor_ready]  -to [get_keepers *$DE270_cpu_jtag_sr[0]]
set_false_path -from [get_keepers *$DE270_cpu_oci_debug_path|monitor_error]  -to [get_keepers *$DE270_cpu_jtag_sr[34]]
set_false_path -from [get_keepers *$DE270_cpu_ocimem_path|*MonDReg*] -to [get_keepers *$DE270_cpu_jtag_sr*]
set_false_path -from *$DE270_cpu_jtag_sr*    -to *$DE270_cpu_jtag_sysclk_path|*jdo*
set_false_path -from sld_hub:*|irf_reg* -to *$DE270_cpu_jtag_sysclk_path|ir*
set_false_path -from sld_hub:*|sld_shadow_jsm:shadow_jsm|state[1] -to *$DE270_cpu_oci_debug_path|monitor_go
set_false_path -from [get_keepers *$DE270_cpu_oci_break_path|dbrk_hit?_latch] -to [get_keepers *$DE270_cpu_jtag_sr*]
set_false_path -from [get_keepers *$DE270_cpu_oci_break_path|trigbrktype] -to [get_keepers *$DE270_cpu_jtag_sr*]
set_false_path -from [get_keepers *$DE270_cpu_oci_break_path|trigger_state] -to [get_keepers *$DE270_cpu_jtag_sr*]

set_false_path -from [get_keepers *$DE270_cpu_traceram_path*address*] -to [get_keepers *$DE270_cpu_jtag_sr*]
set_false_path -from [get_keepers *$DE270_cpu_traceram_path*we_reg*] -to [get_keepers *$DE270_cpu_jtag_sr*]
set_false_path -from [get_keepers *$DE270_cpu_oci_im_path|*trc_im_addr*] -to [get_keepers *$DE270_cpu_jtag_sr*]
set_false_path -from [get_keepers *$DE270_cpu_oci_im_path|*trc_wrap] -to [get_keepers *$DE270_cpu_jtag_sr*]
set_false_path -from [get_keepers *$DE270_cpu_oci_itrace_path|trc_ctrl_reg*] -to [get_keepers *$DE270_cpu_jtag_sr*]
set_false_path -from [get_keepers *$DE270_cpu_oci_itrace_path|d1_debugack] -to [get_keepers *$DE270_cpu_jtag_sr*]
